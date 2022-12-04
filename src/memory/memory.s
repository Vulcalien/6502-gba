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

@@@ BYTE @@@

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

.align
.pool

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

@@@ WORD @@@

.global memory_read_word
@ input:
@   r0 = addr
@
@ output:
@   r0 = read word
memory_read_word:
    push    {r4, r5, lr}

    mov     r4, r0                      @ r4 = addr

    @ lo byte
    bl      memory_read_byte
    mov     r5, r0                      @ r5 = tmp value

    @ hi byte
    add     r0, r4, #1
    bl      memory_read_byte
    orr     r0, r5, r0, asr #8

    pop     {r4, r5, lr}
    bx      lr

.align
.pool

.global memory_write_word
@ input:
@   r0 = addr
@   r1 = value
memory_write_word:
    push    {r4, r5, lr}

    mov     r4, r0                      @ r4 = addr
    mov     r5, r1                      @ r5 = val

    @ lo byte
    bl      memory_write_byte

    @ hi byte
    mov     r0, r4
    asr     r1, r5, #8
    bl      memory_write_byte

    pop     {r4, r5, lr}
    bx      lr

.end
