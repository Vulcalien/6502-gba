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

.global memory_write_byte
@ input:
@   r0 = addr
@   r1 = value
memory_write_byte:
    ldr     r2, =0xffff
    and     r0, r2

    mov     r2, #0xff
    and     r1, r2

    @ TODO

    bx      lr

.align
.pool

.global memory_write_word
@ input:
@   r0 = addr
@   r1 = value
memory_write_word:
    push    {lr}

    @ TODO

    pop     {lr}
    bx      lr

.end
