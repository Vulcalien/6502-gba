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

.global AgbMain
AgbMain:
    bl      reset

1: @ infinite loop
    bl      memory_fetch_byte           @ r0 = fetched instruction
    bl      decode_instruction          @ r0 = 6502 instruction address
    bl      execute_instruction

    b       1b

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
