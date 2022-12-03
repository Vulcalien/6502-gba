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

.global memory_read_byte
@ input:
@   r0 = addr
@
@ output:
@   r0 = byte read
memory_read_byte:
    ldr     r1, =0xffff
    and     r0, r1

    @ TODO
    mov     r0, #0

    bx      lr

@ input:
@   r0 = addr
@   r1 = value
memory_write_byte:
    @ TODO

    bx      lr

.end
