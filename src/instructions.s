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

@@@@@@@@@@@@@@@@@
@   OPERATORS   @
@@@@@@@@@@@@@@@@@

.global inst_ADC, inst_SBC, inst_AND, inst_ORA, inst_EOR
.global inst_ASL, inst_LSR, inst_ROL, inst_ROR, inst_BIT

inst_ADC:
    @ TODO
    bx      lr

inst_SBC:
    @ TODO
    bx      lr

inst_AND:
    @ TODO
    bx      lr

inst_ORA:
    @ TODO
    bx      lr

inst_EOR:
    @ TODO
    bx      lr

inst_ASL:
    @ TODO
    bx      lr

inst_LSR:
    @ TODO
    bx      lr

inst_ROL:
    @ TODO
    bx      lr

inst_ROR:
    @ TODO
    bx      lr

inst_BIT:
    @ TODO
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@@@@@@@@@@@@@
@   INCREMENT/DECREMENT   @
@@@@@@@@@@@@@@@@@@@@@@@@@@@

.global inst_INC, inst_INX, inst_INY
.global inst_DEC, inst_DEX, inst_DEY

inst_INC:
    @ TODO
    bx      lr

inst_INX:
    @ TODO
    bx      lr

inst_INY:
    @ TODO
    bx      lr

inst_DEC:
    @ TODO
    bx      lr

inst_DEX:
    @ TODO
    bx      lr

inst_DEY:
    @ TODO
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@@@@@@@@@@@
@   REGISTER TRANSFER   @
@@@@@@@@@@@@@@@@@@@@@@@@@

.global inst_TAX, inst_TAY
.global inst_TXA, inst_TXS
.global inst_TYA, inst_TSX

inst_TAX:
    @ TODO
    bx      lr

inst_TAY:
    @ TODO
    bx      lr

inst_TXA:
    @ TODO
    bx      lr

inst_TXS:
    @ TODO
    bx      lr

inst_TYA:
    @ TODO
    bx      lr

inst_TSX:
    @ TODO
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@@@@@@@@@@
@   PROCESSOR STATUS   @
@@@@@@@@@@@@@@@@@@@@@@@@

.global inst_CLC, inst_CLD, inst_CLI, inst_CLV
.global inst_SEC, inst_SED, inst_SEI

inst_CLC:
    @ TODO
    bx      lr

inst_CLD:
    @ TODO
    bx      lr

inst_CLI:
    @ TODO
    bx      lr

inst_CLV:
    @ TODO
    bx      lr

inst_SEC:
    @ TODO
    bx      lr

inst_SED:
    @ TODO
    bx      lr

inst_SEI:
    @ TODO
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@
@   COMPARE   @
@@@@@@@@@@@@@@@

.global inst_CMP, inst_CPX, inst_CPY

inst_CMP:
    @ TODO
    bx      lr

inst_CPX:
    @ TODO
    bx      lr

inst_CPY:
    @ TODO
    bx      lr

.align
.pool

@@@@@@@@@@@@@@
@   BRANCH   @
@@@@@@@@@@@@@@

.global inst_BEQ, inst_BNE, inst_BPL, inst_BMI
.global inst_BCC, inst_BCS, inst_BVC, inst_BVS
.global inst_JMP, inst_JSR, inst_RTS, inst_RTI

inst_BEQ:
    @ TODO
    bx      lr

inst_BNE:
    @ TODO
    bx      lr

inst_BPL:
    @ TODO
    bx      lr

inst_BMI:
    @ TODO
    bx      lr

inst_BCC:
    @ TODO
    bx      lr

inst_BCS:
    @ TODO
    bx      lr

inst_BVC:
    @ TODO
    bx      lr

inst_BVS:
    @ TODO
    bx      lr

inst_JMP:
    @ TODO
    bx      lr

inst_JSR:
    @ TODO
    bx      lr

inst_RTS:
    @ TODO
    bx      lr

inst_RTI:
    @ TODO
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@@@@
@   LOAD/STORE   @
@@@@@@@@@@@@@@@@@@

.global inst_LDA, inst_LDX, inst_LDY
.global inst_STA, inst_STX, inst_STY

inst_LDA:
    @ TODO
    bx      lr

inst_LDX:
    @ TODO
    bx      lr

inst_LDY:
    @ TODO
    bx      lr

inst_STA:
    @ TODO
    bx      lr

inst_STX:
    @ TODO
    bx      lr

inst_STY:
    @ TODO
    bx      lr

.align
.pool

@@@@@@@@@@@@@
@   STACK   @
@@@@@@@@@@@@@

.global inst_PLA, inst_PLP, inst_PHA, inst_PHP

inst_PLA:
    @ TODO
    bx      lr

inst_PLP:
    @ TODO
    bx      lr

inst_PHA:
    @ TODO
    bx      lr

inst_PHP:
    @ TODO
    bx      lr

.align
.pool

@@@@@@@@@@@@@
@   OTHER   @
@@@@@@@@@@@@@

.global inst_BRK, inst_NOP

inst_BRK:
    @ TODO
    bx      lr

inst_NOP:
    @ TODO
    bx      lr

.end
