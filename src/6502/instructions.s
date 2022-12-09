@ Copyright 2022 Vulcalien
@
@ This program is free software: you can redistribute it and/or modify
@ it under the terms of the GNU General Public License as published by
@ the Free Software Foundation, either version 3 of the License, or
@ (at your option) any later version.
@
@ This program is distributed in the hope that it will be useful,
@ but WITHOUT ANY WARRANTY; without even the implied warranty of
@ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
@ GNU General Public License for more details.
@
@ You should have received a copy of the GNU General Public License
@ along with this program.  If not, see <https://www.gnu.org/licenses/>.

.section .iwram, "ax"

@ processor status flags
.equ    carry_flag,        (1 << 0)
.equ    zero_flag,         (1 << 1)
.equ    interrupt_disable, (1 << 2)
.equ    decimal_mode,      (1 << 3)
.equ    break_flag,        (1 << 4)
.equ    unused_flag,       (1 << 5)
.equ    overflow_flag,     (1 << 6)
.equ    negative_flag,     (1 << 7)

@ output:
@   r0 = byte read
read_byte:
    push    {lr}

    ldr     r1, =addressing_mode        @ r1 = pointer to addressing mode
    ldr     r1, [r1]                    @ r1 = addressing mode

    @ if addr_ACC (Accumulator)
    ldr     r2, =addr_ACC
    cmp     r1, r2
    bne     1f @ else

    ldr     r0, =reg_a                  @ r0 = pointer to accumulator
    ldrb    r0, [r0]                    @ r0 = accumulator
    b       255f @ exit
1: @ else

    @ if addr_IMM (Immediate) or addr_REL (Relative)
    ldr     r2, =addr_IMM
    cmp     r1, r2
    ldrne   r2, =addr_REL
    cmpne   r1, r2
    bne     1f @ else

    bl      memory_fetch_byte           @ r0 = fetched byte
    b       255f @ exit
1: @ else

    bl      addressing_get_addr         @ r0 = addr
    bl      memory_read_byte            @ r0 = byte read

255: @ exit
    pop     {lr}
    bx      lr

.align
.pool

@ input:
@   r0 = byte to write
write_byte:
    push    {r4, lr}

    ldr     r1, =addressing_mode        @ r1 = pointer to addressing mode
    ldr     r1, [r1]                    @ r1 = addressing mode

    @ if addr_ACC (Accumulator)
    ldr     r2, =addr_ACC
    cmp     r1, r2
    bne     1f @ else

    ldr     r2, =reg_a                  @ r2 = pointer to accumulator
    strb    r0, [r2]
    b       255f @ exit
1: @ else

    mov     r4, r0
    bl      addressing_get_addr         @ r0 = addr
    mov     r1, r4                      @ r1 = byte to write
    bl      memory_write_byte

255: @exit
    pop     {r4, lr}
    bx      lr

.align
.pool

@ input:
@   r0 = relative offset
@   r1 = condition flag
branch_if_set:
    ldr     r2, =reg_status             @ r2 = pointer to processor status
    ldrb    r2, [r2]                    @ r2 = processor status

    @ if conditional flag is clear, return
    tst     r2, r1
    bxeq    lr

    @ add relative offset to program counter
    ldr     r2, =reg_pc                 @ pointer to program counter
    ldrh    r3, [r2]                    @ r3 = program counter
    add     r3, r0
    strh    r3, [r2]

    bx      lr

.align
.pool

@ input:
@   r0 = relative offset
@   r1 = condition flag
branch_if_clear:
    ldr     r2, =reg_status             @ r2 = pointer to processor status
    ldrb    r2, [r2]                    @ r2 = processor status

    @ if conditional flag is set, return
    tst     r2, r1
    bxne    lr

    @ add relative offset to program counter
    ldr     r2, =reg_pc                 @ pointer to program counter
    ldrh    r3, [r2]                    @ r3 = program counter
    add     r3, r0
    strh    r3, [r2]

    bx      lr

.align
.pool

@ input:
@   r0 = value to test
set_flags_z_n:
    ldr     r1, =reg_status             @ r1 = pointer to processor status
    ldrb    r2, [r1]                    @ r2 = processor status

    ands    r0, #0xff
    orreq   r2, #zero_flag
    bicne   r2, #zero_flag

    tst     r0, #0x80
    orrne   r2, #negative_flag
    biceq   r2, #negative_flag

    strb    r2, [r1]

.align
.pool

@@@@@@@@@@@@@@@@@
@   OPERATORS   @
@@@@@@@@@@@@@@@@@

.global inst_ADC, inst_SBC, inst_AND, inst_ORA, inst_EOR
.global inst_ASL, inst_LSR, inst_ROL, inst_ROR, inst_BIT

@ ADC - add with carry
inst_ADC:
    @ TODO
    bx      lr

@ SBC - subtract with carry
inst_SBC:
    @ TODO
    bx      lr

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

@ ORA - logical inclusive OR
inst_ORA:
    push    {lr}

    bl      read_byte                   @ r0 = byte read

    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    ldrb    r2, [r1]                    @ r2 = accumulator
    orr     r0, r2
    strb    r0, [r1]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ EOR - exclusive OR
inst_EOR:
    push    {lr}

    bl      read_byte                   @ r0 = byte read

    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    ldrb    r2, [r1]                    @ r2 = accumulator
    eor     r0, r2
    strb    r0, [r1]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ ASL - arithmetic shift left
inst_ASL:
    push    {r4, lr}

    bl      read_byte                   @ r0 = byte read

    @ set/clear carry bit
    ldr     r1, =reg_status             @ r1 = pointer to processor status
    ldrb    r2, [r1]                    @ r2 = processor status

    tst     r0, #0x80
    orrne   r2, #carry_flag
    biceq   r2, #carry_flag

    strb    r2, [r1]

    @ shift left
    lsl     r0, #1

    mov     r4, r0
    bl      write_byte
    mov     r0, r4

    bl      set_flags_z_n

    pop     {r4, lr}
    bx      lr

@ LSR - logical shift right
inst_LSR:
    push    {r4, lr}

    bl      read_byte                   @ r0 = byte read

    @ set/clear carry bit
    ldr     r1, =reg_status             @ r1 = pointer to processor status
    ldrb    r2, [r1]                    @ r2 = processor status

    tst     r0, #0x01
    orrne   r2, #carry_flag
    biceq   r2, #carry_flag

    @ shift right
    lsr     r0, #1

    mov     r4, r0
    bl      write_byte
    mov     r0, r4

    bl      set_flags_z_n

    pop     {r4, lr}
    bx      lr

@ ROL - rotate left
inst_ROL:
    @ TODO
    bx      lr

@ ROR - rotate right
inst_ROR:
    @ TODO
    bx      lr

@ BIT - bit test
inst_BIT:
    push    {lr}

    bl      read_byte                   @ r0 = byte read

    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    ldrb    r1, [r1]                    @ r1 = accumulator

    ldr     r2, =reg_status             @ r2 = pointer to processor status
    ldrb    r3, [r2]                    @ r3 = processor status

    @ set/clear zero flag
    tst     r1, r0
    orreq   r3, #zero_flag
    bicne   r3, #zero_flag

    @ set/clear overflow flag
    tst     r0, #0x40
    orrne   r3, #overflow_flag
    biceq   r3, #overflow_flag

    @ set/clear negative flag
    tst     r0, #0x80
    orrne   r3, #negative_flag
    biceq   r3, #overflow_flag

    strb    r3, [r2]

    pop     {lr}
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@@@@@@@@@@@@@
@   INCREMENT/DECREMENT   @
@@@@@@@@@@@@@@@@@@@@@@@@@@@

.global inst_INC, inst_INX, inst_INY
.global inst_DEC, inst_DEX, inst_DEY

@ INC - increment memory
inst_INC:
    push    {r4, lr}

    bl      read_byte                   @ r0 = byte read
    add     r0, #1

    mov     r4, r0
    bl      write_byte
    mov     r0, r4

    bl      set_flags_z_n

    pop     {r4, lr}
    bx      lr

@ INX - increment X register
inst_INX:
    push    {lr}

    ldr     r1, =reg_x                  @ r1 = pointer to X register
    ldrb    r0, [r1]                    @ r0 = value of X register
    add     r0, #1
    strb    r0, [r1]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ INY - increment Y register
inst_INY:
    push    {lr}

    ldr     r1, =reg_y                  @ r1 = pointer to Y register
    ldrb    r0, [r1]                    @ r0 = value of Y register
    add     r0, #1
    strb    r0, [r1]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ DEC - decrement memory
inst_DEC:
    push    {r4, lr}

    bl      read_byte                   @ r0 = byte read
    sub     r0, #1

    mov     r4, r0
    bl      write_byte
    mov     r0, r4

    bl      set_flags_z_n

    pop     {r4, lr}
    bx      lr

@ DEX - decrement X register
inst_DEX:
    push    {lr}

    ldr     r1, =reg_x                  @ r1 = pointer to X register
    ldrb    r0, [r1]                    @ r0 = value of X register
    sub     r0, #1
    strb    r0, [r1]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ DEY - decrement Y register
inst_DEY:
    push    {lr}

    ldr     r1, =reg_y                  @ r1 = pointer to Y register
    ldrb    r0, [r1]                    @ r0 = value of Y register
    sub     r0, #1
    strb    r0, [r1]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@@@@@@@@@@@
@   REGISTER TRANSFER   @
@@@@@@@@@@@@@@@@@@@@@@@@@

.global inst_TAX, inst_TAY
.global inst_TXA, inst_TXS
.global inst_TYA, inst_TSX

@ TAX - transfer accumulator to X
inst_TAX:
    push    {lr}

    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    ldrb    r0, [r1]                    @ r0 = accumulator

    ldr     r2, =reg_x                  @ r2 = pointer to X register
    strb    r0, [r2]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ TAY - transfer accumulator to Y
inst_TAY:
    push    {lr}

    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    ldrb    r0, [r1]                    @ r0 = accumulator

    ldr     r2, =reg_y                  @ r2 = pointer to Y register
    strb    r0, [r2]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ TXA - transfer X to accumulator
inst_TXA:
    push    {lr}

    ldr     r1, =reg_x                  @ r1 = pointer to X register
    ldrb    r0, [r1]                    @ r0 = X register

    ldr     r2, =reg_a                  @ r2 = pointer to accumulator
    strb    r0, [r2]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ TXS - transfer X to stack pointer
inst_TXS:
    ldr     r1, =reg_x                  @ r1 = pointer to X register
    ldrb    r0, [r1]                    @ r0 = X register

    ldr     r2, =reg_s                  @ r2 = pointer to stack pointer
    strb    r0, [r2]

    @ no flag is set

    bx      lr

@ TYA - transfer Y to accumulator
inst_TYA:
    push    {lr}

    ldr     r1, =reg_y                  @ r1 = pointer to Y register
    ldrb    r0, [r1]                    @ r0 = Y register

    ldr     r2, =reg_a                  @ r2 = pointer to accumulator
    strb    r0, [r2]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ TSX - transfer stack pointer to X
inst_TSX:
    push    {lr}

    ldr     r1, =reg_s                  @ r1 = pointer to stack pointer
    ldrb    r0, [r1]                    @ r0 = stack pointer

    ldr     r2, =reg_x                  @ r2 = pointer to X register
    strb    r0, [r2]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@@@@@@@@@@
@   PROCESSOR STATUS   @
@@@@@@@@@@@@@@@@@@@@@@@@

.global inst_CLC, inst_CLD, inst_CLI, inst_CLV
.global inst_SEC, inst_SED, inst_SEI

@ CLC - clear carry flag
inst_CLC:
    ldr     r1, =reg_status
    ldrb    r0, [r1]
    bic     r0, #carry_flag
    strb    r0, [r1]

    bx      lr

@ CLD - clear decimal mode
inst_CLD:
    ldr     r1, =reg_status
    ldrb    r0, [r1]
    bic     r0, #decimal_mode
    strb    r0, [r1]

    bx      lr

@ CLI - clear interrupt disable
inst_CLI:
    ldr     r1, =reg_status
    ldrb    r0, [r1]
    bic     r0, #interrupt_disable
    strb    r0, [r1]

    bx      lr

@ CLV - clear overflow flag
inst_CLV:
    ldr     r1, =reg_status
    ldrb    r0, [r1]
    bic     r0, #overflow_flag
    strb    r0, [r1]

    bx      lr

@ SEC - set carry flag
inst_SEC:
    ldr     r1, =reg_status
    ldrb    r0, [r1]
    orr     r0, #carry_flag
    strb    r0, [r1]

    bx      lr

@ SED - set decimal flag
inst_SED:
    ldr     r1, =reg_status
    ldrb    r0, [r1]
    orr     r0, #decimal_mode
    strb    r0, [r1]

    bx      lr

@ SEI - set interrupt disable
inst_SEI:
    ldr     r1, =reg_status
    ldrb    r0, [r1]
    orr     r0, #interrupt_disable
    strb    r0, [r1]

    bx      lr

.align
.pool

@@@@@@@@@@@@@@@
@   COMPARE   @
@@@@@@@@@@@@@@@

.global inst_CMP, inst_CPX, inst_CPY

@ CMP - compare accumulator
inst_CMP:
    push    {lr}

    bl      read_byte                   @ r0 = byte read

    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    ldrb    r1, [r1]                    @ r1 = accumulator

    @ set/clear carry flag
    ldr     r2, =reg_status             @ r2 = pointer to processor status
    ldrb    r3, [r2]                    @ r3 = processor status

    cmp     r1, r0
    orrge   r3, #carry_flag
    biclt   r3, #carry_flag

    sub     r0, r1, r0                  @ r0 = accumulator - byte read
    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ CPX - compare X register
inst_CPX:
    push    {lr}

    bl      read_byte                   @ r0 = byte read

    ldr     r1, =reg_x                  @ r1 = pointer to X register
    ldrb    r1, [r1]                    @ r1 = X register

    @ set/clear carry flag
    ldr     r2, =reg_status             @ r2 = pointer to processor status
    ldrb    r3, [r2]                    @ r3 = processor status

    cmp     r1, r0
    orrge   r3, #carry_flag
    biclt   r3, #carry_flag

    sub     r0, r1, r0                  @ r0 = X register - byte read
    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ CPY - compare Y register
inst_CPY:
    push    {lr}

    bl      read_byte                   @ r0 = byte read

    ldr     r1, =reg_y                  @ r1 = pointer to Y register
    ldrb    r1, [r1]                    @ r1 = Y register

    @ set/clear carry flag
    ldr     r2, =reg_status             @ r2 = pointer to processor status
    ldrb    r3, [r2]                    @ r3 = processor status

    cmp     r1, r0
    orrge   r3, #carry_flag
    biclt   r3, #carry_flag

    sub     r0, r1, r0                  @ r0 = Y register - byte read
    bl      set_flags_z_n

    pop     {lr}
    bx      lr

.align
.pool

@@@@@@@@@@@@@@
@   BRANCH   @
@@@@@@@@@@@@@@

.global inst_BEQ, inst_BNE, inst_BPL, inst_BMI
.global inst_BCC, inst_BCS, inst_BVC, inst_BVS
.global inst_JMP, inst_JSR, inst_RTS, inst_RTI

@ BEQ - branch if equal
inst_BEQ:
    push    {lr}

    bl      read_byte                   @ r0 = byte read
    mov     r1, #zero_flag

    bl      branch_if_set

    pop     {lr}
    bx      lr

@ BNE - branch if not equal
inst_BNE:
    push    {lr}

    bl      read_byte                   @ r0 = byte read
    mov     r1, #zero_flag

    bl      branch_if_clear

    pop     {lr}
    bx      lr

@ BPL - branch if positive
inst_BPL:
    push    {lr}

    bl      read_byte                   @ r0 = byte read
    mov     r1, #negative_flag

    bl      branch_if_clear

    pop     {lr}
    bx      lr

@ BMI - branch if minus
inst_BMI:
    push    {lr}

    bl      read_byte                   @ r0 = byte read
    mov     r1, #negative_flag

    bl      branch_if_set

    pop     {lr}
    bx      lr

@ BCC - branch if carry clear
inst_BCC:
    push    {lr}

    bl      read_byte                   @ r0 = byte read
    mov     r1, #carry_flag

    bl      branch_if_clear

    pop     {lr}
    bx      lr

@ BCS - branch if carry set
inst_BCS:
    push    {lr}

    bl      read_byte                   @ r0 = byte read
    mov     r1, #carry_flag

    bl      branch_if_set

    pop     {lr}
    bx      lr

@ BVC - branch if overflow clear
inst_BVC:
    push    {lr}

    bl      read_byte                   @ r0 = byte read
    mov     r1, #overflow_flag

    bl      branch_if_clear

    pop     {lr}
    bx      lr

@ BVS - branch if overflow set
inst_BVS:
    push    {lr}

    bl      read_byte                   @ r0 = byte read
    mov     r1, #overflow_flag

    bl      branch_if_set

    pop     {lr}
    bx      lr

@ JMP - jump
inst_JMP:
    @ TODO
    bx      lr

@ JSR - jump to subroutine
inst_JSR:
    @ TODO
    bx      lr

@ RTS - return from subroutine
inst_RTS:
    push    {lr}

    bl      stack_pull_word             @ r0 = pulled word
    add     r0, #1

    ldr     r1, =reg_pc                 @ r1 = pointer to program counter
    strh    r0, [r1]

    pop     {lr}
    bx      lr

@ RTI - return from interrupt
inst_RTI:
    push    {lr}

    @ pop processor status
    bl      stack_pull_byte             @ r0 = pulled byte

    ldr     r1, =reg_status             @ r1 = pointer to processor status
    strb    r0, [r1]

    @ pop program counter
    bl      stack_pull_word             @ r0 = pulled word

    ldr     r1, =reg_pc                 @ r1 = pointer to program counter
    strh    r0, [r1]

    pop     {lr}
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@@@@
@   LOAD/STORE   @
@@@@@@@@@@@@@@@@@@

.global inst_LDA, inst_LDX, inst_LDY
.global inst_STA, inst_STX, inst_STY

@ LDA - load accumulator
inst_LDA:
    push    {lr}

    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    bl      read_byte                   @ r0 = byte read
    strb    r0, [r1]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ LDX - load X register
inst_LDX:
    push    {lr}

    ldr     r1, =reg_x                  @ r1 = pointer to X register
    bl      read_byte                   @ r0 = byte read
    strb    r0, [r1]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ LDY - load Y register
inst_LDY:
    push    {lr}

    ldr     r1, =reg_y                  @ r1 = pointer to Y register
    bl      read_byte                   @ r0 = byte read
    strb    r0, [r1]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ STA - store accumulator
inst_STA:
    push    {lr}

    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    ldrb    r0, [r1]                    @ r0 = accumulator
    bl      write_byte

    pop     {lr}
    bx      lr

@ STX - store X register
inst_STX:
    push    {lr}

    ldr     r1, =reg_x                  @ r1 = pointer to X register
    ldrb    r0, [r1]                    @ r0 = accumulator
    bl      write_byte

    pop     {lr}
    bx      lr

@ STY - store Y register
inst_STY:
    push    {lr}

    ldr     r1, =reg_y                  @ r1 = pointer to Y register
    ldrb    r0, [r1]                    @ r0 = accumulator
    bl      write_byte

    pop     {lr}
    bx      lr

.align
.pool

@@@@@@@@@@@@@
@   STACK   @
@@@@@@@@@@@@@

.global inst_PLA, inst_PLP, inst_PHA, inst_PHP

@ PLA - pull accumulator
inst_PLA:
    push    {lr}

    bl      stack_pull_byte             @ r0 = pulled byte

    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    strb    r0, [r1]

    bl      set_flags_z_n

    pop     {lr}
    bx      lr

@ PLP - pull processor status
inst_PLP:
    push    {lr}

    bl      stack_pull_byte             @ r0 = pulled byte

    ldr     r1, =reg_status             @ r1 = pointer to processor status
    strb    r0, [r1]

    pop     {lr}
    bx      lr

@ PHA - push accumulator
inst_PHA:
    push    {lr}

    ldr     r1, =reg_a                  @ r1 = pointer to accumulator
    ldrb    r0, [r1]                    @ r0 = accumulator

    bl      stack_push_byte

    pop     {lr}
    bx      lr

@ PHP - push processor status
inst_PHP:
    push    {lr}

    ldr     r1, =reg_status             @ r1 = pointer to processor status
    ldrb    r0, [r1]                    @ r0 = processor status

    @ set 'break flag' and 'unused flag' to 1, as they are pseudo-flags
    @ and don't physically exist in the processor)
    orr     r0, #(break_flag | unused_flag)

    bl      stack_push_byte

    pop     {lr}
    bx      lr

.align
.pool

@@@@@@@@@@@@@
@   OTHER   @
@@@@@@@@@@@@@

.global inst_BRK, inst_NOP

@ BRK - force interrupt
inst_BRK:
    @ TODO
    bx      lr

@ NOP - no operation
inst_NOP:
    bx      lr

.end
