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

@ Allocate 6502 RAM in BSS section @
.bss
ram_start_address:
    .space ram_size

@@@

.section .iwram, "ax"

.global ram_read_byte
@ input:
@   r0 = addr
@
@ output:
@   r0 = byte read
ram_read_byte:
    sub     r0, #(ram_start << 8)

    ldr     r1, =ram_start_address      @ r1 = pointer to RAM start
    ldrb    r0, [r1, r0]                @ r0 = RAM[addr]

    bx      lr

.align
.pool

.global ram_write_byte
@ input:
@   r0 = addr
@   r1 = value
ram_write_byte:
    ldr     r2, =ram_start_address      @ r2 = pointer to RAM start
    strb    r1, [r2, r0]                @ RAM[addr] = value

    bx      lr
