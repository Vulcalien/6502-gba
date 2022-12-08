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

@ For each instruction there are 8 bytes:
@   4 - addressing mode code
@   4 - 6502 instruction address
instruction_list:
    @ TODO

.global decode_instruction
@ input:
@   r0 = instruction
@
@ output:
@   r0 = 6502 instruction address
decode_instruction:
    push    {lr}

    ldr     r1, =instruction_list       @ r1 = pointer to instruction_list
    add     r0, r1, r0, lsl #3          @ r0 = pointer to addressing mode code

    @ set addressing mode
    ldr     r1, [r0]                    @ r1 = addressing mode code
    ldr     r2, =addressing_mode        @ r2 = pointer to addressing_mode
    strb    r1, [r2]

    @ get 6502 instruction address
    add     r0, #4                  @ r0 = pointer to 6502 instruction address
    ldr     r0, [r0]                    @ r0 = 6502 instruction address

    pop     {lr}
    bx      lr

.end
