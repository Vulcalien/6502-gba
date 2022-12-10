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

@ RAM:  00 - 0f (4 KB)
.equ ram_start,     0x00
.equ ram_size,      0x10
.equ ram_end,       ram_start + ram_size

@ SRAM: 80 - 83 (1 KB)
.equ sram_start,    0x80
.equ sram_size,     0x04
.equ sram_end,      sram_start + sram_size

@ ROM:  84 - ff (31 KB)
.equ rom_start,     0x84
.equ rom_size,      0x7c
.equ rom_end,       rom_start + rom_size
