# Emulatore 6502 per Game Boy Advance

## Introduzione

### Cos'è questo progetto?
Si tratta di un programma per Game Boy Advance, scritto in assembly ARM, in grado di emulare il comportamento del processore 6502.\
Questo consente al programmatore di scrivere programmi utilizzando l'ISA del processore 6502, per poi eseguirli su un Game Boy Advance.

L'emulatore ha a disposizione alcuni dispositivi hardware del Game Boy Advance, quali schermo LCD, PPU (Picture Processing Unit), bottoni...

### Riguardo il Game Boy Advance
Il Game Boy Advance (in breve GBA) è una console portatile realizzata da Nintendo negli anni 2000. La scelta del GBA è dovuta principalmente al suo processore, l'ARM7TDMI che esegue programmi per ARM 7. Inoltre, la console non ha sistema operativo, lasciando quindi al programmatore totale controllo sull'hardware dopo l'avvio.

### Perchè questo progetto?
Visto che il corso tratta l'Architettura degli Elaboratori, emulare un elaboratore sembrava naturale: il progetto tocca infatti molti argomenti trattati nel corso.\
Inoltre, l'utilizzo esclusivo dell'assembly ARM per realizzarlo mi è servito come pratica.

***

L'emulatore è stato pensato per essere modulare. Il codice è diviso in due gruppi: emulazione del 6502 ed emulazione dei dispositivi hardware.

## Emulazione del processore 6502

### Breve descrizione del 6502
Il processore in questione ha un architettura ad 8-bit, con bus di indirizzo a 16-bit, in grado di indirizzare 64 KB di memoria.\
È un processore CISC: le sue istruzioni variano sia in lunghezza (in byte) sia in tempo di esecuzione (in clicli di clock).

Possiede pochi registri: Accumulatore, X, Y, Program Counter, Stack Pointer e Processor Status.

Tutti i dispositivi hardware collegati ad esso sono mappati in memoria.\
Presenta tre tipi di interrupt: IRQ, NMI e RESET.

### Note al codice in assemby ARM
Questo significa che si vuole porre il codice nella IWRAM del Game Boy Advance, cioè la memoria più veloce del dispositivo.
```asm
    .section .iwram, "ax"
```

Queste due linee invece permettono all'assembler di inserire in quella locazione una "literal pool".
```asm
    .align
    .pool
```

Viene garantito che i registri da r4 in su mantengano il loro valore anche dopo aver chiamato una funzione: questo significa che se una funzione intende usare quei registri deve prima conservarli nello stack e poi riprenderli.

Alcune funzioni specificano dei parametri in input e dei risultati in output. Esempio:
```asm
@ input:
@   r0 = addr
@
@ output:
@   r0 = byte read
memory_read_byte:
    ...
```

### Registri
```asm
.data

.global reg_pc, reg_a, reg_x, reg_y, reg_s, reg_status

.align
reg_pc:     .hword 0                    @ Program Counter

reg_a:      .byte 0                     @ Accumulator
reg_x:      .byte 0                     @ X Register
reg_y:      .byte 0                     @ Y Register
reg_s:      .byte 0                     @ Stack Pointer

reg_status: .byte 0                     @ Processor Status
```
I registri emulati sono posti nella sezione `.data`, resi disponibili a tutti i file tramite `.global` e infine allocati con `.hword` e `.byte`.\
Si noti che `reg_pc` è l'unico allocato come halfword, dato che è un registro da 16-bit.

### Memoria
La memoria, come detto prima, è l'unico collegamento tra il processore 6502 e l'hardware che controlla.\
Le funzioni `memory_read_byte` e `memory_write_byte` non sono altro che 'wrapper' delle funzioni `cpu_read_byte` e `cpu_write_byte`, con il compito di sanificare gli input:
```asm
.global memory_read_byte
@ input:
@   r0 = addr
@
@ output:
@   r0 = byte read
memory_read_byte:
    push    {lr}

    ldr     r1, =0xffff
    and     r0, r1                      @ r0 = addr & 0xffff

    bl      cpu_read_byte               @ r0 = byte read
    and     r0, #0xff

    pop     {lr}
    bx      lr

.align
.pool

.global memory_write_byte
@ input:
@   r0 = addr
@   r1 = value
memory_write_byte:
    push    {lr}

    ldr     r2, =0xffff
    and     r0, r2                      @ r0 = addr & 0xffff

    and     r1, #0xff                   @ r1 = value & 0xff

    bl      cpu_write_byte

    pop     {lr}
    bx      lr
```

In particolare, `addr` diventa sempre un valore a 16-bit, mentre il valore letto o da scrivere sempre a 8-bit.

La funzione `memory_fetch_byte` legge un byte e poi incrementa il Program Counter.
```asm
.global memory_fetch_byte
@ output:
@   r0 = fetched byte
memory_fetch_byte:
    push    {r4-r5, lr}

    ldr     r4, =reg_pc                 @ r4 = pointer to program counter
    ldrh    r5, [r4]                    @ r5 = program counter

    mov     r0, r5                      @ r0 = program counter
    bl      memory_read_byte            @ r0 = byte read

    @ increment program counter
    add     r5, #1
    strh    r5, [r4]

    pop     {r4-r5, lr}
    bx      lr
```

Sono usate anche `memory_read_word`, `memory_write_word` e `memory_fetch_word` per ottenere valori da 16-bit. (Per il processore 6502, una word è 16-bit, dato che ha un bus di indirizzo di 16-bit)

### Stack
Dato che lo Stack Pointer è un registro a 8-bit, naturalmente sono disponibili solo 256 byte per lo stack. Questa è l'implementazione di `stack_pull_byte`. L'implementazione di `stack_push_byte` è molto simile.
```asm
.global stack_pull_byte
@ output:
@   r0 = pulled byte
stack_pull_byte:
    push    {lr}

    ldr     r1, =reg_s                  @ r1 = pointer to sp
    ldrb    r0, [r1]                    @ r0 = sp value

    @ increment sp
    add     r0, #1
    strb    r0, [r1]

    and     r0, #0xff
    add     r0, #0x100
    bl      memory_read_byte            @ r0 = read byte

    pop     {lr}
    bx      lr
```
Si noti come il valore di SP può andare in overflow dopo `add r0, #1`.\
Inoltre, viene aggiunto 0x100 (256) prima di leggere da memoria: lo stack è infatti collocato nell'area di indirizzo `0100 ... 01ff`.

### Esecuzione di un'istruzione
Il processore 6502 ha 56 istruzioni. Molte di queste istruzioni supportano più di un 'modo di indirizzamento' dei dati.\
Queste due informazioni sono codificate in un solo byte: per esempio, `A9` indica un'istruzione di `LDA` (load accumulator) con modo di indirizzamento 'immediato'.

Sebbene nel 6502 il numero di 'step' varia molto tra istruzioni e modi di indirizzamento vari, in questo emulatore ho riassunto tutta l'esecuzione in tre fasi: Fetch, Decode e Execute.

```asm
.global cpu_run_instruction
cpu_run_instruction:
    push    {lr}

    bl      memory_fetch_byte           @ r0 = fetched instruction
    bl      decode_instruction          @ r0 = 6502 instruction address
    bl      execute_instruction

    pop     {lr}
    bx      lr
```

`memory_fetch_byte` preleva il byte dell'istruzione e lo passa alla funzione `decode_instruction` che decodifica il valore:
```asm
.global decode_instruction
@ input:
@   r0 = instruction
@
@ output:
@   r0 = 6502 instruction address
decode_instruction:
    push    {lr}

    ldr     r1, =instruction_list       @ r1 = list of instructions
    add     r0, r1, r0, lsl #3          @ r0 = pointer to instruction

    @ set addressing mode
    ldr     r1, [r0, #4]                @ r1 = addressing mode
    ldr     r2, =addressing_mode        @ r2 = pointer to addressing mode
    str     r1, [r2]

    @ get 6502 instruction address
    ldr     r0, [r0]                    @ r0 = 6502 instruction address

    pop     {lr}
    bx      lr
```

In questa funzione si utilizza una 'lookup table' di puntatori a funzione: `instruction_list`.\
Utilizzando il byte dell'istruzione come indice, si ottengono i puntatori alla funzione del modo di indirizzamento, che si salva in memoria, e il puntatore alla funzione dell'istruzione, che si passa poi a `execute_instruction`.

Vediamo ora `execute_instruction`:
```asm
.global execute_instruction
@ input:
@   r0 = 6502 instruction address
execute_instruction:
    push    {lr}

    @ call 6502 instruction
    ldr     lr, =1f                     @ manually set lr
    bx      r0
1:

    pop     {lr}
    bx      lr
```

La funzione è semplicissima: prima, imposta manualmente il Link Register all'istruzione successiva alla chiamata; poi chiama la funzione in `r0`, cioè il puntatore alla funzione dell'istruzione.

Nota sull'implementazione: visto che la funzione ritorna subito dopo aver chiamato l'istruzione, salvare il Link Register è superfluo. Ho preferito farlo ugualmente per semplicità, invece di scrivere:
```asm
execute_instruction:
    @ call 6502 instruction
    bx      r0
```

### Istruzioni
Come detto, il processore 6502 ha 56 istruzioni. Tutte sono state implementate come funzioni indipendenti. Ne esporrò solo qualcuna.

`NOP`: la più semplice, non fa nulla.
```asm
@ NOP - no operation
inst_NOP:
    bx      lr
```

`LDA`: legge un byte e lo salva nel registro Accumulatore. `read_byte` è una funzione che legge un byte basandosi sul modo di indirizzamento.\
Alla fine viene chiamata `set_flags_z_n`, che imposta i bit Z (zero) e N (negativo) del Processor Status.
```asm
@ LDA - load accumulator
inst_LDA:
    push    {lr}

    bl      read_byte                   @ r0 = byte read
    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    strb    r0, [r1]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr
```

`AND`: and logico tra l'Accumulatore e un operando in memoria, deciso dal modo di indirizzamento.
```asm
@ AND - logical AND
inst_AND:
    push    {lr}

    bl      read_byte                   @ r0 = byte read

    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    ldrb    r2, [r1]                    @ r2 = accumulator
    and     r0, r2
    strb    r0, [r1]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr
```

`PHA`: salva l'Accumulatore nello stack.
```asm
@ PHA - push accumulator
inst_PHA:
    push    {lr}

    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    ldrb    r0, [r1]                    @ r0 = accumulator

    bl      stack_push_byte

    pop     {lr}
    bx      lr
```

`BEQ`: salto condizionato, eseguito solo se il flag Z (zero) del Processor Status vale 1.
```asm
@ BEQ - branch if equal
inst_BEQ:
    push    {lr}

    bl      read_byte                   @ r0 = byte read
    mov     r1, #zero_flag

    bl      branch_if_set

    pop     {lr}
    bx      lr
```

### Modi di indirizzamento
Le istruzioni possono operare secondo alcuni modi di indirizzamento. Rispetto ad un processore RISC, il 6502 è in grado di prelevare un operando direttamente dalla memoria.

Ad esempio, `IMM` (immediato) pone l'operando subito dopo l'istruzione, `ABS` (assoluto) invece specifica l'indirizzo assoluto dal quale prelevare l'operando.

Le funzioni di indirizzamento non fanno altro che prelevare l'indirizzo dell'operando, ad esempio `ABS` è implementato così:
```asm
@ Absolute
addr_ABS:
    b       memory_fetch_word           @ redirect to memory_fetch_word
```
Infatti, l'indirizzo è una word di 16-bit presente subito dopo il byte dell'istruzione.

`ABX` (Assoluto + X) invece preleva prima l'indirizzo e poi aggiunge il valore del registro X.
```asm
@ Absolute, X
addr_ABX:
    push    {lr}

    bl      memory_fetch_word           @ r0 = fetched word

    ldr     r1, =reg_x                  @ r1 = pointer to X register
    ldrb    r1, [r1]                    @ r1 = X register

    add     r0, r1                      @ r0 = fetched word + X register

    pop     {lr}
    bx      lr
```

Ci sono poi i modi di indirizzamento della 'Zero Page', cioè i primi 256 byte di memoria e quelli indiretti, che operano su doppi puntatori.

## Emulazione dei dispositivi hardware
Vista la natura modulare del progetto, la parte di codice che emula il processore 6502 può essere considerata un modulo. Questo modulo comunica con il resto del programma solo attraverso queste funzioni: `cpu_run_instruction`, `cpu_reset`, `cpu_read_byte` e `cpu_write_byte`.

`cpu_run_instruction` va chiamata per far eseguire un'istruzione al modulo 6502.\
`cpu_reset` invece si comporta come un'interrupt di RESET e prepara il modulo 6502 ad eseguire il codice che gestisce quell'interrupt.

Ecco la funzione `AgbMain` che va considerata come punto di ingresso dell'intero emulatore:
```asm
.global AgbMain
AgbMain:
    bl      init
    bl      cpu_reset

1: @ infinite loop
    bl      cpu_run_instruction
    b       1b @ infinite loop
```

Come si può vedere, subito dopo il RESET, il programma non fa altro che chiedere al modulo 6502 di eseguire istruzioni.\
Dettaglio dell'implementazione: prima di eseguire `AgbMain` una parte di codice (nel file 'src/crt0.s') prepara il Game Boy Advance ad eseguire il programma, copiando ad esempio il codice dalla ROM alla IWRAM (RAM veloce).

***

I dispositivi hardware presenti sono 'mappati' alla memoria: ognuno è assegnato ad una o più 'memory page', cioè blocchi di memoria da 256 byte ciascuno.

| Dispositivo   | Memory Page(s) | Grandezza |
| ------------- | -------------- | --------- |
| RAM           | 00 - 0f        | 4 KB      |
| I/O Registers | 10             | 256 B     |
| Palette RAM   | 20             | 256 B     |
| VRAM          | 40 - 5f        | 8 KB      |
| SRAM          | 80 - 83        | 1 KB      |
| ROM           | 84 - ff        | 31 KB     |

### Data bus
Le due funzioni `cpu_read_byte` e `cpu_write_byte` implementano il data bus e hanno la responsabilità di trasferire un byte ai dispositivi hardware oppure di leggerne uno e restituirlo al modulo 6502.

```asm
.global cpu_read_byte
@ input:
@   r0 = addr
@
@ output:
@   r0 = byte read
cpu_read_byte:
    push    {lr}

    lsr     r2, r0, #8                  @ r2 = memory page
    lsl     r2, #3                      @ r2 = memory page * 8

    ldr     r3, =memory_map             @ r3 = list of read functions
    ldr     r3, [r3, r2]                @ r3 = read function

    @ call read function, if defined
    cmp     r3, #0
    moveq   r0, #0xff                   @ r0 = default value
    beq     255f @ exit

    ldr     lr, =1f                     @ manually set lr
    bx      r3                          @ r0 = read byte
1:

255: @ exit
    pop     {lr}
    bx      lr
```

Prima si trova il numero della memory page a cui si vuole accedere moltiplicato per 8. Poi, utilizzandolo come indice per una lookup table (`memory_map`) si ottiene la funzione di lettura del dispositivo associato a quella memory page.\
Se quella funzione è definita (cioè se un dispositivo è mappato a quella memory page) si chiede al dispositivo di leggere un byte; altrimenti si restituisce `ff`.

`cpu_write_byte` è implementata similmente.

La lookup table `memory_map` è definita nel file 'src/memory_map.s' così:
```asm
@ For each memory page there are 8 bytes:
@   4 - read  byte function
@   4 - write byte function
.global memory_map
memory_map:
    @ RAM
    .word   ram_read_byte, ram_write_byte           @ 00
    .word   ram_read_byte, ram_write_byte           @ 01
    .word   ram_read_byte, ram_write_byte           @ 02
    .word   ram_read_byte, ram_write_byte           @ 03
    @ etc ...
```

### RAM
L'implementazione della RAM è semplicissima: vengono allocati 4 KiloByte nella sezione BSS (memoria non inizializzata) del Game Boy Advance, dai quali si leggono e scrivono i byte.\
Ecco l'intera implementazione:
```asm
@ Allocate 6502 RAM in BSS section @
.bss
ram_start_address:
    .space (ram_size << 8)

@@@

.section .iwram, "ax"

.global ram_read_byte
@ input:
@   r0 = addr
@
@ output:
@   r0 = byte read
ram_read_byte:
    sub     r0, #(ram_start << 8)

    ldr     r1, =ram_start_address      @ r1 = pointer to RAM start
    ldrb    r0, [r1, r0]                @ r0 = RAM[addr]

    bx      lr

.align
.pool

.global ram_write_byte
@ input:
@   r0 = addr
@   r1 = value
ram_write_byte:
    sub     r0, #(ram_start << 8)

    ldr     r2, =ram_start_address      @ r2 = pointer to RAM start
    strb    r1, [r2, r0]                @ RAM[addr] = value

    bx      lr
```

### ROM
La ROM contiene il programma 6502 da eseguire e tutti i dati da esso utilizzato. Non è possibile scrivere in essa.\
Il contenuto viene caricato dal file di salvataggio del Game Boy Advance.

### SRAM
La SRAM è un'area di memoria in cui il programma 6502 può conservare dati che si conservano tra un'esecuzione e l'altra.\
Anche questo dispositivo si trova nel file di salvataggio del Game Boy Advance.

Nonostante la SRAM sia volatile, era un tempo comune trovarla come memoria di salvataggio nelle cartucce di gioco, associata ovviamente ad una batteria.

### Schermo e VRAM
Lo schermo dell'emulatore non funziona come gli schermi moderni, cioè a pixel disegnati direttamente sullo schermo.\
Utilizza invece il sistema dei 'tile', talvolta chiamati 'caratteri', perchè simile a come funziona l'interfaccia di un terminale.

Se ad esempio si vuole scrivere 'A A A' sullo schermo, invece di ridisegnare i pixel della lettera 'A' tre volte, ciò che si fa è descrivere il tile corrispondente alla lettera 'A' e impostare poi lo schermo per disegnare tre volte quel tile.

L'emulatore offre 4 'background' diversi e due 'tileset' da 64 tile. Il secondo tileset è attualmente inutilizzato.

Il dispositivo della VRAM è di sola scrittura ed è così diviso:
```asm
@@@ VRAM Structure (8 KB) @@@
@ 1 KB - BG0 (32x32)
@ 1 KB - BG1 (32x32)
@ 1 KB - BG2 (32x32)
@ 1 KB - BG3 (32x32)
@
@ 2 KB - 64 BG Tileset  (4 bpp)
@ 2 KB - 64 OBJ Tileset (4 bpp)
```

La funzione `vram_write_byte` si occupa di dividere le scritture ai background da quelle ai tileset. Per questi ultimi viene chiamata la funzione `write_tileset_byte` passando come parametro l'indirizzo del tileset a cui si sta scrivendo.
```asm
@ input:
@   r0 = GBA addr
@   r1 = value
write_tileset_byte:
    @ Since the GBA's VRAM does not have an 8-bit
    @ data bus, 16-bit writes are used instead

    @ invert first and last 4 bits
    lsl     r2, r1, #4
    orr     r1, r2, r1, lsr #4

    @ if writing a lo byte
    tst     r0, #1
    bne     1f @ else

    ldrh    r2, [r0]                    @ r2 = old value
    and     r2, #0xff00                 @ r2 = old value & 0xff00
    orr     r1, r2                      @ r1 = (old value & 0xff00) | value
    strh    r1, [r0]

    b       255f @ exit
1: @ else

    @ writing an hi byte
    ldrh    r2, [r0, #-1]!              @ r2 = old value
    and     r2, #0x00ff                 @ r2 = old value & 0x00ff
    orr     r1, r2, r1, lsl #8          @ r1 = (value << 8) | (old value & 0xff)
    strh    r1, [r0]

255: @ exit
    bx      lr
```

Come nota il commento nel codice, la VRAM del Game Boy Advance accetta solo scritture a 16-bit per via di una scelta nella progettazione dell'hardware.\
Visto che il processore 6502 funziona ad 8-bit, `write_tileset_byte` aggira il problema leggendo prima 16-bit e rimpiazzando uno dei byte.\
Nota: `write_tileset_byte` scrive due pixel con soli 8-bit, perchè ogni pixel occupa solo 4-bit.

### Colori e Palette RAM
Il motivo per cui ogni pixel di un tile occupa solamente 4-bit è che l'emulatore è dotato di una 'palette' da 16 colori. I pixel individuali non sono quindi valori RGB, ma indici della palette.

Ogni colore della palette è poi un colore RGB a 8-bit:
```
7 6 5  4 3 2  1 0
R R R  G G G  B B
```

La palette può essere modificata scrivendo alla Palette RAM.

### I/O Registers
L'emulatore presenta dei registri I/O hardware: `DISPLAY_CONTROL`, `VCOUNT` e `KEY_INPUT`.

`DISPLAY_CONTROL` corrisponde ad un registro del Game Boy Advance e la sua funzione è di attivare o disattivare i background dello schermo.\
Le funzioni di lettura e scrittura fanno da interfaccia tra l'emulatore ed il GBA:
```asm
@@@ DISPLAY CONTROL @@@
@   bits    meaning         value
@
@   0       BG0 enable      (0 = OFF, 1 = ON)
@   1       BG1 enable      (0 = OFF, 1 = ON)
@   2       BG2 enable      (0 = OFF, 1 = ON)
@   3       BG3 enable      (0 = OFF, 1 = ON)

DISPLAY_CONTROL_read:
    ldr     r1, =0x04000000             @ r1 = pointer to GBA Display Control
    ldrh    r1, [r1]                    @ r1 = GBA Display Control (16 bits)

    @ transform value
    lsr     r0, r1, #8
    and     r0, #0x0f

    bx      lr

.align
.pool

DISPLAY_CONTROL_write:
    @ transform value
    lsl     r0, #8
    orr     r0, #(1 << 5 | 1 << 6)

    ldr     r1, =0x04000000             @ r1 = pointer to GBA Display Control
    strh    r0, [r1]

    bx      lr
```

`VCOUNT` è un numero che indica a che punto del refresh si trova lo schermo, utile per il 'V-Sync'. Il registro restituisce il valore alla lettura, mentre in scrittura l'emulatore attende che il VCOUNT raggiunga il valore indicato.

`KEY_INPUT` (sola lettura) restituisce lo stato degli 8 bottoni a disposizione dell'emulatore:
```asm
@@@ KEY INPUT @@@
@   bits    meaning         value
@
@   0       A               (0 = Pressed, 1 = Released)
@   1       B               (0 = Pressed, 1 = Released)
@   2       Select          (0 = Pressed, 1 = Released)
@   3       Start           (0 = Pressed, 1 = Released)
@   4       D-Pad Right     (0 = Pressed, 1 = Released)
@   5       D-Pad Left      (0 = Pressed, 1 = Released)
@   6       D-Pad Up        (0 = Pressed, 1 = Released)
@   7       D-Pad Down      (0 = Pressed, 1 = Released)

KEY_INPUT_read:
    ldr     r1, =0x04000130             @ r1 = pointer to GBA Key Input
    ldrh    r1, [r1]                    @ r1 = GBA Key Input

    @ transform value, by removing 'R' and 'L' buttons
    and     r0, r1, #0xff

    bx      lr
```

## Programma dimostrativo
Vista la descrizione dell'emulatore, ritengo opportuno mostrare un esempio di programma fatto per esso.\
In 'programs/all-sorts-of-sort' si può vedere un programma in assembly 6502 che mostra visivamente l'esecuzione di tre algoritmi di ordinamento.

```asm
.export start
.proc start
    ; enable BG 0
    lda     #$01                ; lda = Load Accumulator
    sta     $1000               ; sta = Store Accumulator

    jsr     initialize_screen   ; jsr = Jump to Subroutine
    jsr     initialize_font

loop:
    jsr     write_bubble_sort
    jsr     initialize_data
    jsr     bubble_sort
    jsr     wait_key_press

    jsr     write_insertion_sort
    jsr     initialize_data
    jsr     insertion_sort
    jsr     wait_key_press

    jsr     write_selection_sort
    jsr     initialize_data
    jsr     selection_sort
    jsr     wait_key_press

    jmp     loop                ; jmp = Jump (unconditional)
.endproc
```

La funzione `start` è molto semplice: prima abilita lo schermo scrivendo al registro hardware `DISPLAY_CONTROL` (indirizzo `1000`).\
Poi, inizializza lo schermo e il font. Senza entrare nel dettaglio, questo vuol dire impostare i background e il tileset.\
Infine, ripete infinitamente gli algoritmi di ordinamento, attendendo che l'utente prema un bottone prima di passare al successivo.

Il Bubble Sort è così implementato:
```asm
.export bubble_sort
.proc bubble_sort
temp = R0

    ldy     #0                  ; Y = outer counter (= i)
outer_loop:
    ; while i != ARRAY_SIZE - 1
    cpy     #(ARRAY_SIZE - 1)
    beq     exit_outer

    ldx     #0                  ; X = inner counter (= j)
inner_loop:
    ; while j != ARRAY_SIZE - 1
    cpx     #(ARRAY_SIZE - 1)
    beq     exit_inner

    lda     ARRAY + 1, x        ; A = ARRAY[j + 1]

    ; if ARRAY[j + 1] < ARRAY[j] then swap
    cmp     ARRAY, x
    bcs     do_not_swap

    ; swap
    sta     temp                ; temp = ARRAY[j + 1]
    lda     ARRAY, x            ; A = ARRAY[j]
    sta     ARRAY + 1, x        ; ARRAY[j + 1] = ARRAY[j]
    lda     temp                ; A = temp
    sta     ARRAY, x            ; ARRAY[j] = temp

    jsr     refresh_save_x_y    ; fa il refresh dello schermo senza modificare X ed Y
do_not_swap:

    inx                         ; inner counter++
    jmp     inner_loop
exit_inner:

    iny                         ; outer counter++
    jmp     outer_loop
exit_outer:

    rts
.endproc
```

La funzione utilizza i registri X e Y come indici dell'array.\
Per mancanza di registri, durante lo swap, oltre all'accumulatore, si utililizza `temp`, un registro ausiliario in memoria.

L'istruzione `lda ARRAY, x` è un esempio di indirizzamento indicizzato. In questo caso, la variabile X fa da indice da sommare all'indirizzo di base ARRAY.

## Risorse utilizzate
Una descrizione dettagliata del processore 6502 e del suo Instruction Set:\
http://web.archive.org/web/20210803072420/http://www.obelisk.me.uk/6502/

Un mio emulatore del processore 6502 scritto in C:\
https://github.com/Vulcalien/6502-emulator

Una descrizione minuziosa del Game Boy Advance:\
https://problemkaputt.de/gbatek.htm
