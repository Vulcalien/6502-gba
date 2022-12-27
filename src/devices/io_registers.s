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

functions:
    .word   DISPLAY_CONTROL_read, DISPLAY_CONTROL_write         @ 00
    .word   VCOUNT_read, VCOUNT_write                           @ 01
    .word   0, 0                                                @ 02
    .word   0, 0                                                @ 03
    .word   0, 0                                                @ 04
    .word   0, 0                                                @ 05
    .word   0, 0                                                @ 06
    .word   0, 0                                                @ 07
    .word   0, 0                                                @ 08
    .word   0, 0                                                @ 09
    .word   0, 0                                                @ 0a
    .word   0, 0                                                @ 0b
    .word   0, 0                                                @ 0c
    .word   0, 0                                                @ 0d
    .word   0, 0                                                @ 0e
    .word   0, 0                                                @ 0f
    .word   KEY_INPUT_read, 0                                   @ 10
    .word   0, 0                                                @ 11
    .word   0, 0                                                @ 12
    .word   0, 0                                                @ 13
    .word   0, 0                                                @ 14
    .word   0, 0                                                @ 15
    .word   0, 0                                                @ 16
    .word   0, 0                                                @ 17
    .word   0, 0                                                @ 18
    .word   0, 0                                                @ 19
    .word   0, 0                                                @ 1a
    .word   0, 0                                                @ 1b
    .word   0, 0                                                @ 1c
    .word   0, 0                                                @ 1d
    .word   0, 0                                                @ 1e
    .word   0, 0                                                @ 1f
    .word   0, 0                                                @ 20
    .word   0, 0                                                @ 21
    .word   0, 0                                                @ 22
    .word   0, 0                                                @ 23
    .word   0, 0                                                @ 24
    .word   0, 0                                                @ 25
    .word   0, 0                                                @ 26
    .word   0, 0                                                @ 27
    .word   0, 0                                                @ 28
    .word   0, 0                                                @ 29
    .word   0, 0                                                @ 2a
    .word   0, 0                                                @ 2b
    .word   0, 0                                                @ 2c
    .word   0, 0                                                @ 2d
    .word   0, 0                                                @ 2e
    .word   0, 0                                                @ 2f
    .word   0, 0                                                @ 30
    .word   0, 0                                                @ 31
    .word   0, 0                                                @ 32
    .word   0, 0                                                @ 33
    .word   0, 0                                                @ 34
    .word   0, 0                                                @ 35
    .word   0, 0                                                @ 36
    .word   0, 0                                                @ 37
    .word   0, 0                                                @ 38
    .word   0, 0                                                @ 39
    .word   0, 0                                                @ 3a
    .word   0, 0                                                @ 3b
    .word   0, 0                                                @ 3c
    .word   0, 0                                                @ 3d
    .word   0, 0                                                @ 3e
    .word   0, 0                                                @ 3f
    .word   0, 0                                                @ 40
    .word   0, 0                                                @ 41
    .word   0, 0                                                @ 42
    .word   0, 0                                                @ 43
    .word   0, 0                                                @ 44
    .word   0, 0                                                @ 45
    .word   0, 0                                                @ 46
    .word   0, 0                                                @ 47
    .word   0, 0                                                @ 48
    .word   0, 0                                                @ 49
    .word   0, 0                                                @ 4a
    .word   0, 0                                                @ 4b
    .word   0, 0                                                @ 4c
    .word   0, 0                                                @ 4d
    .word   0, 0                                                @ 4e
    .word   0, 0                                                @ 4f
    .word   0, 0                                                @ 50
    .word   0, 0                                                @ 51
    .word   0, 0                                                @ 52
    .word   0, 0                                                @ 53
    .word   0, 0                                                @ 54
    .word   0, 0                                                @ 55
    .word   0, 0                                                @ 56
    .word   0, 0                                                @ 57
    .word   0, 0                                                @ 58
    .word   0, 0                                                @ 59
    .word   0, 0                                                @ 5a
    .word   0, 0                                                @ 5b
    .word   0, 0                                                @ 5c
    .word   0, 0                                                @ 5d
    .word   0, 0                                                @ 5e
    .word   0, 0                                                @ 5f
    .word   0, 0                                                @ 60
    .word   0, 0                                                @ 61
    .word   0, 0                                                @ 62
    .word   0, 0                                                @ 63
    .word   0, 0                                                @ 64
    .word   0, 0                                                @ 65
    .word   0, 0                                                @ 66
    .word   0, 0                                                @ 67
    .word   0, 0                                                @ 68
    .word   0, 0                                                @ 69
    .word   0, 0                                                @ 6a
    .word   0, 0                                                @ 6b
    .word   0, 0                                                @ 6c
    .word   0, 0                                                @ 6d
    .word   0, 0                                                @ 6e
    .word   0, 0                                                @ 6f
    .word   0, 0                                                @ 70
    .word   0, 0                                                @ 71
    .word   0, 0                                                @ 72
    .word   0, 0                                                @ 73
    .word   0, 0                                                @ 74
    .word   0, 0                                                @ 75
    .word   0, 0                                                @ 76
    .word   0, 0                                                @ 77
    .word   0, 0                                                @ 78
    .word   0, 0                                                @ 79
    .word   0, 0                                                @ 7a
    .word   0, 0                                                @ 7b
    .word   0, 0                                                @ 7c
    .word   0, 0                                                @ 7d
    .word   0, 0                                                @ 7e
    .word   0, 0                                                @ 7f
    .word   0, 0                                                @ 80
    .word   0, 0                                                @ 81
    .word   0, 0                                                @ 82
    .word   0, 0                                                @ 83
    .word   0, 0                                                @ 84
    .word   0, 0                                                @ 85
    .word   0, 0                                                @ 86
    .word   0, 0                                                @ 87
    .word   0, 0                                                @ 88
    .word   0, 0                                                @ 89
    .word   0, 0                                                @ 8a
    .word   0, 0                                                @ 8b
    .word   0, 0                                                @ 8c
    .word   0, 0                                                @ 8d
    .word   0, 0                                                @ 8e
    .word   0, 0                                                @ 8f
    .word   0, 0                                                @ 90
    .word   0, 0                                                @ 91
    .word   0, 0                                                @ 92
    .word   0, 0                                                @ 93
    .word   0, 0                                                @ 94
    .word   0, 0                                                @ 95
    .word   0, 0                                                @ 96
    .word   0, 0                                                @ 97
    .word   0, 0                                                @ 98
    .word   0, 0                                                @ 99
    .word   0, 0                                                @ 9a
    .word   0, 0                                                @ 9b
    .word   0, 0                                                @ 9c
    .word   0, 0                                                @ 9d
    .word   0, 0                                                @ 9e
    .word   0, 0                                                @ 9f
    .word   0, 0                                                @ a0
    .word   0, 0                                                @ a1
    .word   0, 0                                                @ a2
    .word   0, 0                                                @ a3
    .word   0, 0                                                @ a4
    .word   0, 0                                                @ a5
    .word   0, 0                                                @ a6
    .word   0, 0                                                @ a7
    .word   0, 0                                                @ a8
    .word   0, 0                                                @ a9
    .word   0, 0                                                @ aa
    .word   0, 0                                                @ ab
    .word   0, 0                                                @ ac
    .word   0, 0                                                @ ad
    .word   0, 0                                                @ ae
    .word   0, 0                                                @ af
    .word   0, 0                                                @ b0
    .word   0, 0                                                @ b1
    .word   0, 0                                                @ b2
    .word   0, 0                                                @ b3
    .word   0, 0                                                @ b4
    .word   0, 0                                                @ b5
    .word   0, 0                                                @ b6
    .word   0, 0                                                @ b7
    .word   0, 0                                                @ b8
    .word   0, 0                                                @ b9
    .word   0, 0                                                @ ba
    .word   0, 0                                                @ bb
    .word   0, 0                                                @ bc
    .word   0, 0                                                @ bd
    .word   0, 0                                                @ be
    .word   0, 0                                                @ bf
    .word   0, 0                                                @ c0
    .word   0, 0                                                @ c1
    .word   0, 0                                                @ c2
    .word   0, 0                                                @ c3
    .word   0, 0                                                @ c4
    .word   0, 0                                                @ c5
    .word   0, 0                                                @ c6
    .word   0, 0                                                @ c7
    .word   0, 0                                                @ c8
    .word   0, 0                                                @ c9
    .word   0, 0                                                @ ca
    .word   0, 0                                                @ cb
    .word   0, 0                                                @ cc
    .word   0, 0                                                @ cd
    .word   0, 0                                                @ ce
    .word   0, 0                                                @ cf
    .word   0, 0                                                @ d0
    .word   0, 0                                                @ d1
    .word   0, 0                                                @ d2
    .word   0, 0                                                @ d3
    .word   0, 0                                                @ d4
    .word   0, 0                                                @ d5
    .word   0, 0                                                @ d6
    .word   0, 0                                                @ d7
    .word   0, 0                                                @ d8
    .word   0, 0                                                @ d9
    .word   0, 0                                                @ da
    .word   0, 0                                                @ db
    .word   0, 0                                                @ dc
    .word   0, 0                                                @ dd
    .word   0, 0                                                @ de
    .word   0, 0                                                @ df
    .word   0, 0                                                @ e0
    .word   0, 0                                                @ e1
    .word   0, 0                                                @ e2
    .word   0, 0                                                @ e3
    .word   0, 0                                                @ e4
    .word   0, 0                                                @ e5
    .word   0, 0                                                @ e6
    .word   0, 0                                                @ e7
    .word   0, 0                                                @ e8
    .word   0, 0                                                @ e9
    .word   0, 0                                                @ ea
    .word   0, 0                                                @ eb
    .word   0, 0                                                @ ec
    .word   0, 0                                                @ ed
    .word   0, 0                                                @ ee
    .word   0, 0                                                @ ef
    .word   0, 0                                                @ f0
    .word   0, 0                                                @ f1
    .word   0, 0                                                @ f2
    .word   0, 0                                                @ f3
    .word   0, 0                                                @ f4
    .word   0, 0                                                @ f5
    .word   0, 0                                                @ f6
    .word   0, 0                                                @ f7
    .word   0, 0                                                @ f8
    .word   0, 0                                                @ f9
    .word   0, 0                                                @ fa
    .word   0, 0                                                @ fb
    .word   0, 0                                                @ fc
    .word   0, 0                                                @ fd
    .word   0, 0                                                @ fe
    .word   0, 0                                                @ ff

.global io_reg_read_byte
@ input:
@   r0 = addr
@
@ output:
@   r0 = byte read
io_reg_read_byte:
    push    {lr}

    sub     r0, #(io_reg_start << 8)

    lsl     r0, #3                      @ r0 = addr * 8
    ldr     r2, =functions              @ r2 = list of read functions
    ldr     r2, [r2, r0]                @ r2 = read function

    @ call read function, if defined
    cmp     r2, #0
    ldrne   lr, =1f                     @ manually set lr
    bxne    r2                          @ r0 = register value
1:

    pop     {lr}
    bx      lr

.align
.pool

.global io_reg_write_byte
@ input:
@   r0 = addr
@   r1 = value
io_reg_write_byte:
    push    {lr}

    sub     r0, #(io_reg_start << 8)

    lsl     r0, #3                      @ r0 = addr * 8
    ldr     r2, =(functions + 4)        @ r2 = list of write functions
    ldr     r2, [r2, r0]                @ r2 = write function

    @ call write function, if defined
    cmp     r2, #0
    ldrne   lr, =1f                     @ manually set lr
    movne   r0, r1                      @ r0 = value
    bxne    r2
1:

    pop     {lr}
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@   I/O Registers Read/Write   @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

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

.align
.pool

@@@ VCOUNT @@@
@
@ Read:  get the current VCOUNT value
@ Write: wait until VCOUNT reaches the given value

VCOUNT_read:
    ldr     r1, =0x04000006             @ r1 = pointer to GBA VCOUNT
    ldrh    r1, [r1]                    @ r1 = GBA VCOUNT (16 bits)

    and     r0, r1, #0xff

    bx      lr

.align
.pool

VCOUNT_write:
    @ This is a busy-wait implementation
    ldr     r1, =0x04000006             @ r1 = pointer to GBA VCOUNT

1: @ loop
    ldrh    r2, [r1]                    @ r2 = GBA VCOUNT (16 bits)

    cmp     r2, r0
    bne     1b @ loop

    bx      lr

.align
.pool

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

.end
