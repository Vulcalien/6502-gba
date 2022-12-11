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
    sub     r0, #(vram_start << 8)

    @ if writing to BGs
    cmp     r0, #0x1000
    bge     1f @ else

    @ transform BG Tile data from emulator (1 Byte) to GBA (2 Bytes)
    and     r2, r1, #0x3f               @ data: set tile number
    bic     r1, #0x3f                   @ clear tile number bits
    orr     r2, r1, lsl #2              @ data: set flip bits

    @ write BG Tile data (2 Bytes)
    ldr     r3, =bg_tilemaps_addr       @ r3 = pointer to BG tilemaps start
    lsl     r0, #1
    strh    r2, [r3, r0]                @ BG tilemaps[addr * 2] = data

    b       255f @ exit
1: @ else

    @ if writing to BG Tileset
    cmp     r0, #0x1800
    bge     1f @ else

    @ TODO write to BG Tileset

    b       255f @ exit
1: @ else

    @ TODO write to OBJ Tileset

255: @ exit
    bx      lr
