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

.equ bg_tilemaps_addr, 0x06004000

.equ bg_tileset_addr,  0x06000000
.equ obj_tileset_addr, 0x06010000

@@@ VRAM Structure (8 KB) @@@
@ 1 KB - BG0 (32x32)
@ 1 KB - BG1 (32x32)
@ 1 KB - BG2 (32x32)
@ 1 KB - BG3 (32x32)
@
@ 2 KB - 64 BG Tileset  (4 bpp)
@ 2 KB - 64 OBJ Tileset (4 bpp)

@@@ BG Tile (1 Byte) @@@
@   bit     meaning             value
@
@   0-5     tile number         (0-63)
@   6       horizontal flip     (0 = Normal, 1 = Flipped)
@   7       vertical flip       (0 = Normal, 1 = Flipped)

.global vram_write_byte
@ input:
@   r0 = addr
@   r1 = value
vram_write_byte:
    push    {lr}

    sub     r0, #(vram_start << 8)

    @ if writing to BG Tilemaps
    cmp     r0, #0x1000
    bge     1f @ else

    @ transform BG Tile data from emulator (1 Byte) to GBA (2 Bytes)
    and     r2, r1, #0x3f               @ data: set tile number
    bic     r1, #0x3f                   @ clear tile number bits
    orr     r2, r1, lsl #4              @ data: set flip bits

    @ write BG Tile data (2 Bytes)
    ldr     r3, =bg_tilemaps_addr       @ r3 = pointer to BG tilemaps start
    lsl     r0, #1
    strh    r2, [r3, r0]                @ BG tilemaps[addr * 2] = data

    b       255f @ exit
1: @ else

    @ if writing to BG Tileset
    cmp     r0, #0x1800
    bge     1f @ else

    sub     r0, #0x1000                 @ r0 = BG Tileset index
    ldr     r2, =bg_tileset_addr        @ r2 = pointer to BG tileset start
    add     r0, r2                      @ r0 = pointer to BG tileset[index]
    bl      write_tileset_byte

    b       255f @ exit
1: @ else

    @ writing to OBJ Tileset
    sub     r0, #0x1800                 @ r0 = OBJ Tileset index
    ldr     r2, =obj_tileset_addr       @ r2 = pointer to OBJ tileset start
    add     r0, r2                      @ r0 = pointer to OBJ tileset[index]
    bl      write_tileset_byte

255: @ exit
    pop     {lr}
    bx      lr

.align
.pool

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

.end
