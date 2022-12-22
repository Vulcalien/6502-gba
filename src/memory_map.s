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

@ For each memory page there are 8 bytes:
@   4 - read  byte function
@   4 - write byte function
.global memory_map
memory_map:
    @ RAM
    .word   ram_read_byte, ram_write_byte           @ 00
    .word   ram_read_byte, ram_write_byte           @ 01
    .word   ram_read_byte, ram_write_byte           @ 02
    .word   ram_read_byte, ram_write_byte           @ 03
    .word   ram_read_byte, ram_write_byte           @ 04
    .word   ram_read_byte, ram_write_byte           @ 05
    .word   ram_read_byte, ram_write_byte           @ 06
    .word   ram_read_byte, ram_write_byte           @ 07
    .word   ram_read_byte, ram_write_byte           @ 08
    .word   ram_read_byte, ram_write_byte           @ 09
    .word   ram_read_byte, ram_write_byte           @ 0a
    .word   ram_read_byte, ram_write_byte           @ 0b
    .word   ram_read_byte, ram_write_byte           @ 0c
    .word   ram_read_byte, ram_write_byte           @ 0d
    .word   ram_read_byte, ram_write_byte           @ 0e
    .word   ram_read_byte, ram_write_byte           @ 0f

    @ I/O Registers
    .word   io_reg_read_byte, io_reg_write_byte     @ 10

    .word   0, 0                                    @ 11
    .word   0, 0                                    @ 12
    .word   0, 0                                    @ 13
    .word   0, 0                                    @ 14
    .word   0, 0                                    @ 15
    .word   0, 0                                    @ 16
    .word   0, 0                                    @ 17
    .word   0, 0                                    @ 18
    .word   0, 0                                    @ 19
    .word   0, 0                                    @ 1a
    .word   0, 0                                    @ 1b
    .word   0, 0                                    @ 1c
    .word   0, 0                                    @ 1d
    .word   0, 0                                    @ 1e
    .word   0, 0                                    @ 1f

    @ Palette RAM
    .word   0, palette_write_byte                   @ 20

    .word   0, 0                                    @ 21
    .word   0, 0                                    @ 22
    .word   0, 0                                    @ 23
    .word   0, 0                                    @ 24
    .word   0, 0                                    @ 25
    .word   0, 0                                    @ 26
    .word   0, 0                                    @ 27
    .word   0, 0                                    @ 28
    .word   0, 0                                    @ 29
    .word   0, 0                                    @ 2a
    .word   0, 0                                    @ 2b
    .word   0, 0                                    @ 2c
    .word   0, 0                                    @ 2d
    .word   0, 0                                    @ 2e
    .word   0, 0                                    @ 2f
    .word   0, 0                                    @ 30
    .word   0, 0                                    @ 31
    .word   0, 0                                    @ 32
    .word   0, 0                                    @ 33
    .word   0, 0                                    @ 34
    .word   0, 0                                    @ 35
    .word   0, 0                                    @ 36
    .word   0, 0                                    @ 37
    .word   0, 0                                    @ 38
    .word   0, 0                                    @ 39
    .word   0, 0                                    @ 3a
    .word   0, 0                                    @ 3b
    .word   0, 0                                    @ 3c
    .word   0, 0                                    @ 3d
    .word   0, 0                                    @ 3e
    .word   0, 0                                    @ 3f

    @ VRAM
    .word   0, vram_write_byte                      @ 40
    .word   0, vram_write_byte                      @ 41
    .word   0, vram_write_byte                      @ 42
    .word   0, vram_write_byte                      @ 43
    .word   0, vram_write_byte                      @ 44
    .word   0, vram_write_byte                      @ 45
    .word   0, vram_write_byte                      @ 46
    .word   0, vram_write_byte                      @ 47
    .word   0, vram_write_byte                      @ 48
    .word   0, vram_write_byte                      @ 49
    .word   0, vram_write_byte                      @ 4a
    .word   0, vram_write_byte                      @ 4b
    .word   0, vram_write_byte                      @ 4c
    .word   0, vram_write_byte                      @ 4d
    .word   0, vram_write_byte                      @ 4e
    .word   0, vram_write_byte                      @ 4f
    .word   0, vram_write_byte                      @ 50
    .word   0, vram_write_byte                      @ 51
    .word   0, vram_write_byte                      @ 52
    .word   0, vram_write_byte                      @ 53
    .word   0, vram_write_byte                      @ 54
    .word   0, vram_write_byte                      @ 55
    .word   0, vram_write_byte                      @ 56
    .word   0, vram_write_byte                      @ 57
    .word   0, vram_write_byte                      @ 58
    .word   0, vram_write_byte                      @ 59
    .word   0, vram_write_byte                      @ 5a
    .word   0, vram_write_byte                      @ 5b
    .word   0, vram_write_byte                      @ 5c
    .word   0, vram_write_byte                      @ 5d
    .word   0, vram_write_byte                      @ 5e
    .word   0, vram_write_byte                      @ 5f

    .word   0, 0                                    @ 60
    .word   0, 0                                    @ 61
    .word   0, 0                                    @ 62
    .word   0, 0                                    @ 63
    .word   0, 0                                    @ 64
    .word   0, 0                                    @ 65
    .word   0, 0                                    @ 66
    .word   0, 0                                    @ 67
    .word   0, 0                                    @ 68
    .word   0, 0                                    @ 69
    .word   0, 0                                    @ 6a
    .word   0, 0                                    @ 6b
    .word   0, 0                                    @ 6c
    .word   0, 0                                    @ 6d
    .word   0, 0                                    @ 6e
    .word   0, 0                                    @ 6f
    .word   0, 0                                    @ 70
    .word   0, 0                                    @ 71
    .word   0, 0                                    @ 72
    .word   0, 0                                    @ 73
    .word   0, 0                                    @ 74
    .word   0, 0                                    @ 75
    .word   0, 0                                    @ 76
    .word   0, 0                                    @ 77
    .word   0, 0                                    @ 78
    .word   0, 0                                    @ 79
    .word   0, 0                                    @ 7a
    .word   0, 0                                    @ 7b
    .word   0, 0                                    @ 7c
    .word   0, 0                                    @ 7d
    .word   0, 0                                    @ 7e
    .word   0, 0                                    @ 7f

    @ SRAM
    .word   sram_read_byte, sram_write_byte         @ 80
    .word   sram_read_byte, sram_write_byte         @ 81
    .word   sram_read_byte, sram_write_byte         @ 82
    .word   sram_read_byte, sram_write_byte         @ 83

    @ ROM
    .word   rom_read_byte, 0                        @ 84
    .word   rom_read_byte, 0                        @ 85
    .word   rom_read_byte, 0                        @ 86
    .word   rom_read_byte, 0                        @ 87
    .word   rom_read_byte, 0                        @ 88
    .word   rom_read_byte, 0                        @ 89
    .word   rom_read_byte, 0                        @ 8a
    .word   rom_read_byte, 0                        @ 8b
    .word   rom_read_byte, 0                        @ 8c
    .word   rom_read_byte, 0                        @ 8d
    .word   rom_read_byte, 0                        @ 8e
    .word   rom_read_byte, 0                        @ 8f
    .word   rom_read_byte, 0                        @ 90
    .word   rom_read_byte, 0                        @ 91
    .word   rom_read_byte, 0                        @ 92
    .word   rom_read_byte, 0                        @ 93
    .word   rom_read_byte, 0                        @ 94
    .word   rom_read_byte, 0                        @ 95
    .word   rom_read_byte, 0                        @ 96
    .word   rom_read_byte, 0                        @ 97
    .word   rom_read_byte, 0                        @ 98
    .word   rom_read_byte, 0                        @ 99
    .word   rom_read_byte, 0                        @ 9a
    .word   rom_read_byte, 0                        @ 9b
    .word   rom_read_byte, 0                        @ 9c
    .word   rom_read_byte, 0                        @ 9d
    .word   rom_read_byte, 0                        @ 9e
    .word   rom_read_byte, 0                        @ 9f
    .word   rom_read_byte, 0                        @ a0
    .word   rom_read_byte, 0                        @ a1
    .word   rom_read_byte, 0                        @ a2
    .word   rom_read_byte, 0                        @ a3
    .word   rom_read_byte, 0                        @ a4
    .word   rom_read_byte, 0                        @ a5
    .word   rom_read_byte, 0                        @ a6
    .word   rom_read_byte, 0                        @ a7
    .word   rom_read_byte, 0                        @ a8
    .word   rom_read_byte, 0                        @ a9
    .word   rom_read_byte, 0                        @ aa
    .word   rom_read_byte, 0                        @ ab
    .word   rom_read_byte, 0                        @ ac
    .word   rom_read_byte, 0                        @ ad
    .word   rom_read_byte, 0                        @ ae
    .word   rom_read_byte, 0                        @ af
    .word   rom_read_byte, 0                        @ b0
    .word   rom_read_byte, 0                        @ b1
    .word   rom_read_byte, 0                        @ b2
    .word   rom_read_byte, 0                        @ b3
    .word   rom_read_byte, 0                        @ b4
    .word   rom_read_byte, 0                        @ b5
    .word   rom_read_byte, 0                        @ b6
    .word   rom_read_byte, 0                        @ b7
    .word   rom_read_byte, 0                        @ b8
    .word   rom_read_byte, 0                        @ b9
    .word   rom_read_byte, 0                        @ ba
    .word   rom_read_byte, 0                        @ bb
    .word   rom_read_byte, 0                        @ bc
    .word   rom_read_byte, 0                        @ bd
    .word   rom_read_byte, 0                        @ be
    .word   rom_read_byte, 0                        @ bf
    .word   rom_read_byte, 0                        @ c0
    .word   rom_read_byte, 0                        @ c1
    .word   rom_read_byte, 0                        @ c2
    .word   rom_read_byte, 0                        @ c3
    .word   rom_read_byte, 0                        @ c4
    .word   rom_read_byte, 0                        @ c5
    .word   rom_read_byte, 0                        @ c6
    .word   rom_read_byte, 0                        @ c7
    .word   rom_read_byte, 0                        @ c8
    .word   rom_read_byte, 0                        @ c9
    .word   rom_read_byte, 0                        @ ca
    .word   rom_read_byte, 0                        @ cb
    .word   rom_read_byte, 0                        @ cc
    .word   rom_read_byte, 0                        @ cd
    .word   rom_read_byte, 0                        @ ce
    .word   rom_read_byte, 0                        @ cf
    .word   rom_read_byte, 0                        @ d0
    .word   rom_read_byte, 0                        @ d1
    .word   rom_read_byte, 0                        @ d2
    .word   rom_read_byte, 0                        @ d3
    .word   rom_read_byte, 0                        @ d4
    .word   rom_read_byte, 0                        @ d5
    .word   rom_read_byte, 0                        @ d6
    .word   rom_read_byte, 0                        @ d7
    .word   rom_read_byte, 0                        @ d8
    .word   rom_read_byte, 0                        @ d9
    .word   rom_read_byte, 0                        @ da
    .word   rom_read_byte, 0                        @ db
    .word   rom_read_byte, 0                        @ dc
    .word   rom_read_byte, 0                        @ dd
    .word   rom_read_byte, 0                        @ de
    .word   rom_read_byte, 0                        @ df
    .word   rom_read_byte, 0                        @ e0
    .word   rom_read_byte, 0                        @ e1
    .word   rom_read_byte, 0                        @ e2
    .word   rom_read_byte, 0                        @ e3
    .word   rom_read_byte, 0                        @ e4
    .word   rom_read_byte, 0                        @ e5
    .word   rom_read_byte, 0                        @ e6
    .word   rom_read_byte, 0                        @ e7
    .word   rom_read_byte, 0                        @ e8
    .word   rom_read_byte, 0                        @ e9
    .word   rom_read_byte, 0                        @ ea
    .word   rom_read_byte, 0                        @ eb
    .word   rom_read_byte, 0                        @ ec
    .word   rom_read_byte, 0                        @ ed
    .word   rom_read_byte, 0                        @ ee
    .word   rom_read_byte, 0                        @ ef
    .word   rom_read_byte, 0                        @ f0
    .word   rom_read_byte, 0                        @ f1
    .word   rom_read_byte, 0                        @ f2
    .word   rom_read_byte, 0                        @ f3
    .word   rom_read_byte, 0                        @ f4
    .word   rom_read_byte, 0                        @ f5
    .word   rom_read_byte, 0                        @ f6
    .word   rom_read_byte, 0                        @ f7
    .word   rom_read_byte, 0                        @ f8
    .word   rom_read_byte, 0                        @ f9
    .word   rom_read_byte, 0                        @ fa
    .word   rom_read_byte, 0                        @ fb
    .word   rom_read_byte, 0                        @ fc
    .word   rom_read_byte, 0                        @ fd
    .word   rom_read_byte, 0                        @ fe
    .word   rom_read_byte, 0                        @ ff

.end
