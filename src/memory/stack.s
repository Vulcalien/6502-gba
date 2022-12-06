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

.global stack_pull_byte
@ output:
@   r0 = pulled byte
stack_pull_byte:
    push    {lr}

    ldr     r1, =reg_sp                 @ r1 = pointer to sp
    ldrb    r0, [r1]                    @ r0 = sp value

    @ increment sp
    add     r0, #1
    strb    r0, [r1]

    and     r0, #0xff
    add     r0, #0x100
    bl      memory_read_byte            @ r0 = read byte

    pop     {lr}
    bx      lr

.align
.pool

.global stack_push_byte
@ input:
@   r0 = byte to push
stack_push_byte:
    push    {r4, r5, lr}

    ldr     r4, =reg_sp                 @ r4 = pointer to sp
    ldrb    r5, [r4]                    @ r5 = sp value

    mov     r1, r0                      @ r1 = value
    mov     r0, r5                      @ r0 = addr
    bl      memory_write_byte

    @ decrement sp
    sub     r5, #1
    strb    r5, [r4]

    pop     {r4, r5, lr}
    bx      lr

.align
.pool

@@@ WORD @@@

.global stack_pull_word
@ output:
@   r0 = pulled word
stack_pull_word:
    push    {r4, lr}

    @ lo byte
    bl      stack_pull_byte             @ r0 = pulled byte
    mov     r4, r0

    @ hi byte
    bl      stack_pull_byte
    orr     r0, r4, r0, lsl #8

    pop     {r4, lr}
    bx      lr

.align
.pool

.global stack_push_word
@ input:
@   r0 = word to push
stack_push_word:
    push    {r4, lr}

    mov     r4, r0                      @ r4 = word to push

    @ lo byte
    bl      stack_push_byte

    @ hi byte
    asr     r0, r4, #8
    bl      stack_push_byte

    pop     {r5, lr}
    bx      lr

.end
