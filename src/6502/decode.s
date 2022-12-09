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

@ For each instruction there are 8 bytes:
@   4 - 6502 instruction address
@   4 - addressing mode
instruction_list:
    .word   inst_BRK, addr_IMP          @ 00
    .word   inst_ORA, addr_INX          @ 01
    .word   0, 0                        @ 02
    .word   0, 0                        @ 03
    .word   0, 0                        @ 04
    .word   inst_ORA, addr_ZPG          @ 05
    .word   inst_ASL, addr_ZPG          @ 06
    .word   0, 0                        @ 07
    .word   inst_PHP, addr_IMP          @ 08
    .word   inst_ORA, addr_IMM          @ 09
    .word   inst_ASL, addr_ACC          @ 0a
    .word   0, 0                        @ 0b
    .word   0, 0                        @ 0c
    .word   inst_ORA, addr_ABS          @ 0d
    .word   inst_ASL, addr_ABS          @ 0e
    .word   0, 0                        @ 0f
    .word   inst_BPL, addr_REL          @ 10
    .word   inst_ORA, addr_INY          @ 11
    .word   0, 0                        @ 12
    .word   0, 0                        @ 13
    .word   0, 0                        @ 14
    .word   inst_ORA, addr_ZPX          @ 15
    .word   inst_ASL, addr_ZPX          @ 16
    .word   0, 0                        @ 17
    .word   inst_CLC, addr_IMP          @ 18
    .word   inst_ORA, addr_ABY          @ 19
    .word   0, 0                        @ 1a
    .word   0, 0                        @ 1b
    .word   0, 0                        @ 1c
    .word   inst_ORA, addr_ABX          @ 1d
    .word   inst_ASL, addr_ABX          @ 1e
    .word   0, 0                        @ 1f
    .word   inst_JSR, addr_ABS          @ 20
    .word   inst_AND, addr_INX          @ 21
    .word   0, 0                        @ 22
    .word   0, 0                        @ 23
    .word   inst_BIT, addr_ZPG          @ 24
    .word   inst_AND, addr_ZPG          @ 25
    .word   inst_ROL, addr_ZPG          @ 26
    .word   0, 0                        @ 27
    .word   inst_PLP, addr_IMP          @ 28
    .word   inst_AND, addr_IMM          @ 29
    .word   inst_ROL, addr_ACC          @ 2a
    .word   0, 0                        @ 2b
    .word   inst_BIT, addr_ABS          @ 2c
    .word   inst_AND, addr_ABS          @ 2d
    .word   inst_ROL, addr_ABS          @ 2e
    .word   0, 0                        @ 2f
    .word   inst_BMI, addr_REL          @ 30
    .word   inst_AND, addr_INY          @ 31
    .word   0, 0                        @ 32
    .word   0, 0                        @ 33
    .word   0, 0                        @ 34
    .word   inst_AND, addr_ZPX          @ 35
    .word   inst_ROL, addr_ZPX          @ 36
    .word   0, 0                        @ 37
    .word   inst_SEC, addr_IMP          @ 38
    .word   inst_AND, addr_ABY          @ 39
    .word   0, 0                        @ 3a
    .word   0, 0                        @ 3b
    .word   0, 0                        @ 3c
    .word   inst_AND, addr_ABX          @ 3d
    .word   inst_ROL, addr_ABX          @ 3e
    .word   0, 0                        @ 3f
    .word   inst_RTI, addr_IMP          @ 40
    .word   inst_EOR, addr_INX          @ 41
    .word   0, 0                        @ 42
    .word   0, 0                        @ 43
    .word   0, 0                        @ 44
    .word   inst_EOR, addr_ZPG          @ 45
    .word   inst_LSR, addr_ZPG          @ 46
    .word   0, 0                        @ 47
    .word   inst_PHA, addr_IMP          @ 48
    .word   inst_EOR, addr_IMM          @ 49
    .word   inst_LSR, addr_ACC          @ 4a
    .word   0, 0                        @ 4b
    .word   inst_JMP, addr_ABS          @ 4c
    .word   inst_EOR, addr_ABS          @ 4d
    .word   inst_LSR, addr_ABS          @ 4e
    .word   0, 0                        @ 4f
    .word   inst_BVC, addr_REL          @ 50
    .word   inst_EOR, addr_INY          @ 51
    .word   0, 0                        @ 52
    .word   0, 0                        @ 53
    .word   0, 0                        @ 54
    .word   inst_EOR, addr_ZPX          @ 55
    .word   inst_LSR, addr_ZPX          @ 56
    .word   0, 0                        @ 57
    .word   inst_CLI, addr_IMP          @ 58
    .word   inst_EOR, addr_ABY          @ 59
    .word   0, 0                        @ 5a
    .word   0, 0                        @ 5b
    .word   0, 0                        @ 5c
    .word   inst_EOR, addr_ABX          @ 5d
    .word   inst_LSR, addr_ABX          @ 5e
    .word   0, 0                        @ 5f
    .word   inst_RTS, addr_IMP          @ 60
    .word   inst_ADC, addr_INX          @ 61
    .word   0, 0                        @ 62
    .word   0, 0                        @ 63
    .word   0, 0                        @ 64
    .word   inst_ADC, addr_ZPG          @ 65
    .word   inst_ROR, addr_ZPG          @ 66
    .word   0, 0                        @ 67
    .word   inst_PLA, addr_IMP          @ 68
    .word   inst_ADC, addr_IMM          @ 69
    .word   inst_ROR, addr_ACC          @ 6a
    .word   0, 0                        @ 6b
    .word   inst_JMP, addr_IND          @ 6c
    .word   inst_ADC, addr_ABS          @ 6d
    .word   inst_ROR, addr_ABS          @ 6e
    .word   0, 0                        @ 6f
    .word   inst_BVS, addr_REL          @ 70
    .word   inst_ADC, addr_INY          @ 71
    .word   0, 0                        @ 72
    .word   0, 0                        @ 73
    .word   0, 0                        @ 74
    .word   inst_ADC, addr_ZPX          @ 75
    .word   inst_ROR, addr_ZPX          @ 76
    .word   0, 0                        @ 77
    .word   inst_SEI, addr_IMP          @ 78
    .word   inst_ADC, addr_ABY          @ 79
    .word   0, 0                        @ 7a
    .word   0, 0                        @ 7b
    .word   0, 0                        @ 7c
    .word   inst_ADC, addr_ABX          @ 7d
    .word   inst_ROR, addr_ABX          @ 7e
    .word   0, 0                        @ 7f
    .word   0, 0                        @ 80
    .word   inst_STA, addr_INX          @ 81
    .word   0, 0                        @ 82
    .word   0, 0                        @ 83
    .word   inst_STY, addr_ZPG          @ 84
    .word   inst_STA, addr_ZPG          @ 85
    .word   inst_STX, addr_ZPG          @ 86
    .word   0, 0                        @ 87
    .word   inst_DEY, addr_IMP          @ 88
    .word   0, 0                        @ 89
    .word   inst_TXA, addr_IMP          @ 8a
    .word   0, 0                        @ 8b
    .word   inst_STY, addr_ABS          @ 8c
    .word   inst_STA, addr_ABS          @ 8d
    .word   inst_STX, addr_ABS          @ 8e
    .word   0, 0                        @ 8f
    .word   inst_BCC, addr_REL          @ 90
    .word   inst_STA, addr_INY          @ 91
    .word   0, 0                        @ 92
    .word   0, 0                        @ 93
    .word   inst_STY, addr_ZPX          @ 94
    .word   inst_STA, addr_ZPX          @ 95
    .word   inst_STX, addr_ZPY          @ 96
    .word   0, 0                        @ 97
    .word   inst_TYA, addr_IMP          @ 98
    .word   inst_STA, addr_ABY          @ 99
    .word   inst_TXS, addr_IMP          @ 9a
    .word   0, 0                        @ 9b
    .word   0, 0                        @ 9c
    .word   inst_STA, addr_ABX          @ 9d
    .word   0, 0                        @ 9e
    .word   0, 0                        @ 9f
    .word   inst_LDY, addr_IMM          @ a0
    .word   inst_LDA, addr_INX          @ a1
    .word   inst_LDX, addr_IMM          @ a2
    .word   0, 0                        @ a3
    .word   inst_LDY, addr_ZPG          @ a4
    .word   inst_LDA, addr_ZPG          @ a5
    .word   inst_LDX, addr_ZPG          @ a6
    .word   0, 0                        @ a7
    .word   inst_TAY, addr_IMP          @ a8
    .word   inst_LDA, addr_IMM          @ a9
    .word   inst_TAX, addr_IMP          @ aa
    .word   0, 0                        @ ab
    .word   inst_LDY, addr_ABS          @ ac
    .word   inst_LDA, addr_ABS          @ ad
    .word   inst_LDX, addr_ABS          @ ae
    .word   0, 0                        @ af
    .word   inst_BCS, addr_REL          @ b0
    .word   inst_LDA, addr_INY          @ b1
    .word   0, 0                        @ b2
    .word   0, 0                        @ b3
    .word   inst_LDY, addr_ZPX          @ b4
    .word   inst_LDA, addr_ZPX          @ b5
    .word   inst_LDX, addr_ZPY          @ b6
    .word   0, 0                        @ b7
    .word   inst_CLV, addr_IMP          @ b8
    .word   inst_LDA, addr_ABY          @ b9
    .word   inst_TSX, addr_IMP          @ ba
    .word   0, 0                        @ bb
    .word   inst_LDY, addr_ABX          @ bc
    .word   inst_LDA, addr_ABX          @ bd
    .word   inst_LDX, addr_ABY          @ be
    .word   0, 0                        @ bf
    .word   inst_CPY, addr_IMM          @ c0
    .word   inst_CMP, addr_INX          @ c1
    .word   0, 0                        @ c2
    .word   0, 0                        @ c3
    .word   inst_CPY, addr_ZPG          @ c4
    .word   inst_CMP, addr_ZPG          @ c5
    .word   inst_DEC, addr_ZPG          @ c6
    .word   0, 0                        @ c7
    .word   inst_INY, addr_IMP          @ c8
    .word   inst_CMP, addr_IMM          @ c9
    .word   inst_DEX, addr_IMP          @ ca
    .word   0, 0                        @ cb
    .word   inst_CPY, addr_ABS          @ cc
    .word   inst_CMP, addr_ABS          @ cd
    .word   inst_DEC, addr_ABS          @ ce
    .word   0, 0                        @ cf
    .word   inst_BNE, addr_REL          @ d0
    .word   inst_CMP, addr_INY          @ d1
    .word   0, 0                        @ d2
    .word   0, 0                        @ d3
    .word   0, 0                        @ d4
    .word   inst_CMP, addr_ZPX          @ d5
    .word   inst_DEC, addr_ZPX          @ d6
    .word   0, 0                        @ d7
    .word   inst_CLD, addr_IMP          @ d8
    .word   inst_CMP, addr_ABY          @ d9
    .word   0, 0                        @ da
    .word   0, 0                        @ db
    .word   0, 0                        @ dc
    .word   inst_CMP, addr_ABX          @ dd
    .word   inst_DEC, addr_ABX          @ de
    .word   0, 0                        @ df
    .word   inst_CPX, addr_IMM          @ e0
    .word   inst_SBC, addr_INX          @ e1
    .word   0, 0                        @ e2
    .word   0, 0                        @ e3
    .word   inst_CPX, addr_ZPG          @ e4
    .word   inst_SBC, addr_ZPG          @ e5
    .word   inst_INC, addr_ZPG          @ e6
    .word   0, 0                        @ e7
    .word   inst_INX, addr_IMP          @ e8
    .word   inst_SBC, addr_IMM          @ e9
    .word   inst_NOP, addr_IMP          @ ea
    .word   0, 0                        @ eb
    .word   inst_CPX, addr_ABS          @ ec
    .word   inst_SBC, addr_ABS          @ ed
    .word   inst_INC, addr_ABS          @ ee
    .word   0, 0                        @ ef
    .word   inst_BEQ, addr_REL          @ f0
    .word   inst_SBC, addr_INY          @ f1
    .word   0, 0                        @ f2
    .word   0, 0                        @ f3
    .word   0, 0                        @ f4
    .word   inst_SBC, addr_ZPX          @ f5
    .word   inst_INC, addr_ZPX          @ f6
    .word   0, 0                        @ f7
    .word   inst_SED, addr_IMP          @ f8
    .word   inst_SBC, addr_ABY          @ f9
    .word   0, 0                        @ fa
    .word   0, 0                        @ fb
    .word   0, 0                        @ fc
    .word   inst_SBC, addr_ABX          @ fd
    .word   inst_INC, addr_ABX          @ fe
    .word   0, 0                        @ ff

.global decode_instruction
@ input:
@   r0 = instruction
@
@ output:
@   r0 = 6502 instruction address
decode_instruction:
    push    {lr}

    ldr     r1, =instruction_list       @ r1 = list of instructions
    add     r0, r1, r0, lsl #3          @ r0 = pointer to instruction

    @ set addressing mode
    ldr     r1, [r0, #4]                @ r1 = addressing mode
    ldr     r2, =addressing_mode        @ r2 = pointer to addressing mode
    str     r1, [r2]

    @ get 6502 instruction address
    ldr     r0, [r0]                    @ r0 = 6502 instruction address

    pop     {lr}
    bx      lr

.end
