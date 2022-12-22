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

.include "devices.inc"

.section .iwram, "ax"

.global AgbMain
AgbMain:
    bl      init
    bl      cpu_reset

1: @ infinite loop
    bl      cpu_run_instruction
    b       1b @ infinite loop

.align
.pool

init:
    @ BG 0 Control
    ldr     r0, =(3 << 0 | 8 << 8)
    ldr     r1, =0x04000008
    strh    r0, [r1]

    @ BG 1 Control
    ldr     r0, =(2 << 0 | 9 << 8)
    ldr     r1, =0x0400000a
    strh    r0, [r1]

    @ BG 2 Control
    ldr     r0, =(1 << 0 | 10 << 8)
    ldr     r1, =0x0400000c
    strh    r0, [r1]

    @ BG 3 Control
    ldr     r0, =(0 << 0 | 11 << 8)
    ldr     r1, =0x0400000e
    strh    r0, [r1]

    bx      lr

.align
.pool

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

.align
.pool

.global cpu_write_byte
@ input:
@   r0 = addr
@   r1 = value
cpu_write_byte:
    push    {lr}

    lsr     r2, r0, #8                  @ r2 = memory page
    lsl     r2, #3                      @ r2 = memory page * 8

    ldr     r3, =memory_map             @ r3 = list of read functions
    add     r3, #4                      @ r3 = list of write functions (+4)
    ldr     r3, [r3, r2]                @ r3 = write function

    @ call write function, if defined
    cmp     r3, #0
    beq     255f @ exit

    ldr     lr, =1f                     @ manually set lr
    bx      r3                          @ r0 = read byte
1:

255: @ exit
    pop     {lr}
    bx      lr

.end
