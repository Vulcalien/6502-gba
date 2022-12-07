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

.text

.global AgbMain
AgbMain:
    bl      reset

1: @ infinite loop
    bl      fetch_instruction           @ r0 = fetched instruction
    bl      decode_instruction          @ r0 = 6502 instruction address
    bl      execute_instruction

    b       1b

.align
.pool

@ output:
@   r0 = instruction
fetch_instruction:
    push    {r4-r5, lr}

    ldr     r4, =reg_pc                 @ r4 = pointer to program counter
    ldrh    r5, [r4]                    @ r5 = program counter

    mov     r0, r5
    bl      memory_read_byte            @ r0 = fetched instruction

    @ increment pc
    add     r5, #1
    strh    r5, [r4]

    pop     {r4-r5, lr}
    bx      lr

.align
.pool

@ Load reset vector into PC
reset:
    push    {lr}

    ldr     r0, =0xfffc
    bl      memory_read_word            @ r0 = reset vector address

    ldr     r1, =reg_pc
    strh    r0, [r1]

    pop     {lr}
    bx      lr

.end
