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

@@@ BYTE @@@

.global memory_read_byte
@ input:
@   r0 = addr
@
@ output:
@   r0 = byte read
memory_read_byte:
    push    {lr}

    ldr     r1, =0xffff
    and     r0, r1

    @bl      emulator_read_byte

    pop     {lr}
    bx      lr

.align
.pool

.global memory_write_byte
@ input:
@   r0 = addr
@   r1 = value
memory_write_byte:
    push    {lr}

    ldr     r2, =0xffff
    and     r0, r2

    and     r1, #0xff

    @bl      emulator_write_byte

    pop     {lr}
    bx      lr

.align
.pool

.global memory_fetch_byte
@ output:
@   r0 = fetched byte
memory_fetch_byte:
    push    {r4-r5, lr}

    ldr     r4, =reg_pc                 @ r4 = pointer to program counter
    ldrh    r5, [r4]                    @ r5 = program counter

    mov     r0, r5                      @ r0 = program counter
    bl      memory_read_byte            @ r0 = byte read

    @ increment program counter
    add     r5, #1
    strh    r5, [r4]

    pop     {r4-r5, lr}
    bx      lr

.align
.pool

@@@ WORD @@@

.global memory_read_word
@ input:
@   r0 = addr
@
@ output:
@   r0 = word read
memory_read_word:
    push    {r4-r5, lr}

    mov     r4, r0                      @ r4 = addr

    @ lo byte
    bl      memory_read_byte            @ r0 = byte read
    mov     r5, r0                      @ r5 = lo byte

    @ hi byte
    add     r0, r4, #1                  @ r0 = addr + 1
    bl      memory_read_byte            @ r0 = byte read

    orr     r0, r5, r0, lsl #8          @ r0 = lo byte | hi byte << 8

    pop     {r4-r5, lr}
    bx      lr

.align
.pool

.global memory_write_word
@ input:
@   r0 = addr
@   r1 = value
memory_write_word:
    push    {r4-r5, lr}

    mov     r4, r0                      @ r4 = addr
    mov     r5, r1                      @ r5 = value

    @ lo byte
    bl      memory_write_byte

    @ hi byte
    add     r0, r4, #1                  @ r0 = addr + 1
    asr     r1, r5, #8                  @ r1 = value >> 8
    bl      memory_write_byte

    pop     {r4-r5, lr}
    bx      lr

.align
.pool

.global memory_fetch_word
@ output:
@   r0 = fetched word
memory_fetch_word:
    push    {r4, lr}

    @ lo byte
    bl      memory_fetch_byte           @ r0 = fetched byte
    mov     r4, r0                      @ r4 = lo byte

    @ hi byte
    bl      memory_fetch_byte           @ r0 = fetched byte

    orr     r0, r4, r0, lsl #8          @ r0 = lo byte | hi byte << 8

    pop     {r4, lr}
    bx      lr

.end
