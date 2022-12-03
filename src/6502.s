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
    @ TODO execute
    b       1b

@ Load Reset vector in PC
reset:
    push    {lr}

    ldr     r0, =0xfffc
    bl      load_pc_vector

    pop     {lr}
    bx      lr

.global load_pc_vector
@ input:
@   r0 = vector pointer
load_pc_vector:
    push    {lr}

    ldr     r1, =reg_pc
    mov     r2, r0                      @ r2 = vector pointer
    mov     r3, #0                      @ r3 = pc value

    @ lo byte
    mov     r0, r2
    bl      memory_read_byte
    mov     r3, r0

    @ hi byte
    add     r0, r2, #1
    bl      memory_read_byte
    orr     r3, r0, lsl #8

    str     r3, [r1]

    pop     {lr}
    bx      lr

.end
