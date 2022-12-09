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

.data

.global addressing_mode
addressing_mode:
    .word   0

.section .iwram, "ax"

.global addressing_get_addr
@ output:
@   r0 = addr
addressing_get_addr:
    push    {lr}

    ldr     r1, =addressing_mode        @ r1 = pointer to addressing function
    ldr     r1, [r1]                    @ r1 = addressing function

    @ call addressing function
    ldr     lr, =1f                     @ manually set lr
    bx      r1                          @ r0 = addr
1:

    pop     {lr}
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@   ADDRESSING FUNCTIONS   @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@ output:
@   r0 = 16 bit addr

.global addr_IMP, addr_ACC, addr_IMM, addr_REL

@ Implicit
addr_IMP:
    b       addr_IMP                    @ infinite loop (should never be called)

@ Accumulator
addr_ACC:
    b       addr_ACC                    @ infinite loop (should never be called)

@ Immediate
addr_IMM:
    b       addr_IMM                    @ infinite loop (should never be called)

@ Relative
addr_REL:
    b       addr_REL                    @ infinite loop (should never be called)

@@@@@@@@@@@@@@@@@
@   Zero Page   @
@@@@@@@@@@@@@@@@@

.global addr_ZPG, addr_ZPX, addr_ZPY

@ Zero Page
addr_ZPG:
    b       memory_fetch_byte           @ redirect to memory_fetch_byte

@ Zero Page, X
addr_ZPX:
    push    {lr}

    bl      memory_fetch_byte           @ r0 = fetched byte

    ldr     r1, =reg_x                  @ r1 = pointer to X register
    ldrb    r1, [r1]                    @ r1 = X register

    @ add X register and take only one byte
    add     r0, r1
    and     r0, #0xff

    pop     {lr}
    bx      lr

.align
.pool

@ Zero Page, Y
addr_ZPY:
    push    {lr}

    bl      memory_fetch_byte           @ r0 = fetched byte

    ldr     r1, =reg_y                  @ r1 = pointer to Y register
    ldrb    r1, [r1]                    @ r1 = Y register

    @ add Y register and take only one byte
    add     r0, r1
    and     r0, #0xff

    pop     {lr}
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@@
@   Absolute   @
@@@@@@@@@@@@@@@@

.global addr_ABS, addr_ABX, addr_ABY

@ Absolute
addr_ABS:
    b       memory_fetch_word           @ redirect to memory_fetch_word

@ Absolute, X
addr_ABX:
    push    {lr}

    bl      memory_fetch_word           @ r0 = fetched word

    ldr     r1, =reg_x                  @ r1 = pointer to X register
    ldrb    r1, [r1]                    @ r1 = X register

    add     r0, r1                      @ r0 = fetched word + X register

    pop     {lr}
    bx      lr

.align
.pool

@ Absolute, Y
addr_ABY:
    push    {lr}

    bl      memory_fetch_word           @ r0 = fetched word

    ldr     r1, =reg_y                  @ r1 = pointer to Y register
    ldrb    r1, [r1]                    @ r1 = Y register

    add     r0, r1                      @ r0 = fetched word + Y register

    pop     {lr}
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@@
@   Indirect   @
@@@@@@@@@@@@@@@@

.global addr_IND, addr_INX, addr_INY

@ (Indirect)
addr_IND:
    push    {lr}

    bl      memory_fetch_word           @ r0 = fetched word

    @ this implements an hardware bug present in the original 6502:
    @ TODO explain more
    @ TODO implement this

    pop     {lr}
    bx      lr

.align
.pool

@ (Indirect, X)
addr_INX:
    push    {lr}

    @ TODO

    pop     {lr}
    bx      lr

.align
.pool

@ (Indirect), Y
addr_INY:
    push    {lr}

    @ TODO

    pop     {lr}
    bx      lr

.end
