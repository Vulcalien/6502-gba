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

.global AgbMain
AgbMain:
    bl      cpu_reset

1: @ infinite loop
    bl      cpu_run_instruction
    b       1b @ infinite loop

.align
.pool

.global cpu_read_byte
@ input:
@   r0 = addr
@
@ output:
@   r0 = byte read
cpu_read_byte:
    push    {lr}

    mov     r2, r0, lsr #8              @ r2 = memory page

    @ if ram_start <= memory page < ram_end
    cmp     r2, #ram_start
    blt     1f @ else
    cmp     r2, #ram_end
    bge     1f @ else

    bl      ram_read_byte

    b       255f @ exit
1: @ else

    @ if io_reg_start <= memory page < io_reg_end
    cmp     r2, #io_reg_start
    blt     1f @ else
    cmp     r2, #io_reg_end
    bge     1f @ else

    bl      io_reg_read_byte

    b       255f @ exit
1: @ else

    @ if sram_start <= memory page < sram_end
    cmp     r2, #sram_start
    blt     1f @ else
    cmp     r2, #sram_end
    bge     1f @ else

    bl      sram_read_byte

    b       255f @ exit
1: @ else

    @ if rom_start <= memory page < rom_end
    cmp     r2, #rom_start
    blt     1f @ else
    cmp     r2, #rom_end
    bge     1f @ else

    bl      rom_read_byte

    b       255f @ exit
1: @ else

    @ default
    mov     r0, #0xff

255: @ exit
    pop     {lr}
    bx      lr

.align
.pool

.global cpu_write_byte
@ input:
@   r0 = addr
@   r1 = value
cpu_write_byte:
    push    {lr}

    mov     r2, r0, lsr #8              @ r2 = memory page

    @ if ram_start <= memory page < ram_end
    cmp     r2, #ram_start
    blt     1f @ else
    cmp     r2, #ram_end
    bge     1f @ else

    bl      ram_write_byte

    b       255f @ exit
1: @ else

    @ if io_reg_start <= memory page < io_reg_end
    cmp     r2, #io_reg_start
    blt     1f @ else
    cmp     r2, #io_reg_end
    bge     1f @ else

    bl      io_reg_write_byte

    b       255f @ exit
1: @ else

    @ if vram_start <= memory page < vram_end
    cmp     r2, #vram_start
    blt     1f @ else
    cmp     r2, #vram_end
    bge     1f @ else

    bl      vram_write_byte

    b       255f @ exit
1: @ else

    @ if sram_start <= memory page < sram_end
    cmp     r2, #sram_start
    blt     1f @ else
    cmp     r2, #sram_end
    bge     1f @ else

    bl      sram_write_byte

    b       255f @ exit
1: @ else

255: @ exit
    pop     {lr}
    bx      lr

.end
