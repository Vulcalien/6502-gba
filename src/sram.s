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

.equ sram_start_address, 0x0e000000

.global sram_read_byte
@ input:
@   r0 = addr
@
@ output:
@   r0 = byte read
sram_read_byte:
    ldr     r1, =sram_start_address     @ r1 = pointer to SRAM start
    ldrb    r0, [r1, r0]                @ r0 = SRAM[addr]

    bx      lr

.align
.pool

.global sram_write_byte
@ input:
@   r0 = addr
@   r1 = value
sram_write_byte:
    ldr     r2, =sram_start_address     @ r2 = pointer to SRAM start
    strb    r1, [r2, r0]                @ SRAM[addr] = value

    bx      lr
