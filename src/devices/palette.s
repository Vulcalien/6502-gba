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

.equ bg_palette_addr,  0x05000000
.equ obj_palette_addr, 0x05000200

.global palette_write_byte
@ input:
@   r0 = addr
@   r1 = value
palette_write_byte:
    sub     r0, #(palette_start << 8)

    lsl     r0, #1                      @ r0 = addr * 2

    @ transcode color from 8-bit to 15-bit
    and     r2, r1, #0b11100000         @ r2 = R component (3-bits)
    mov     r3, r2, lsr #3              @ r3 = R

    and     r2, r1, #0b00011100         @ r2 = G component (3-bits)
    orr     r3, r2, lsl #5              @ r3 = R | G

    and     r2, r1, #0b00000011         @ r2 = B component (2-bits)
    orr     r3, r2, lsl #13             @ r3 = R | G | B

    @ if addr * 2 < 0x20
    cmp     r0, #0x20
    bge     1f @ else

    ldr     r1, =bg_palette_addr
    strh    r3, [r1, r0]                @ BG Palette[addr * 2] = color

    b       255f @ exit
1: @ else

    @ if addr * 2 < 0x40
    cmp     r0, #0x40
    bge     1f @ else

    sub     r0, #0x20
    ldr     r1, =obj_palette_addr
    strh    r3, [r1, r0]                @ OBJ Palette[addr * 2] = color

    b       255f @ exit
1: @ else

255: @ exit
    bx      lr

.end
