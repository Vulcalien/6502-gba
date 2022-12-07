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

@ ADC - add with carry
inst_ADC:
    @ TODO
    bx      lr

@ SBC - subtract with carry
inst_SBC:
    @ TODO
    bx      lr

@ AND - logical AND
inst_AND:
    @ TODO
    bx      lr

@ ORA - logical inclusive OR
inst_ORA:
    @ TODO
    bx      lr

@ EOR - exclusive OR
inst_EOR:
    @ TODO
    bx      lr

@ ASL - arithmetic shift left
inst_ASL:
    @ TODO
    bx      lr

@ LSR - logical shift right
inst_LSR:
    @ TODO
    bx      lr

@ ROL - rotate left
inst_ROL:
    @ TODO
    bx      lr

@ ROR - rotate right
inst_ROR:
    @ TODO
    bx      lr

@ BIT - bit test
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

@ INC - increment memory
inst_INC:
    @ TODO
    bx      lr

@ INX - increment X register
inst_INX:
    @ TODO
    bx      lr

@ INY - increment Y register
inst_INY:
    @ TODO
    bx      lr

@ DEC - decrement memory
inst_DEC:
    @ TODO
    bx      lr

@ DEX - decrement X register
inst_DEX:
    @ TODO
    bx      lr

@ DEY - decrement Y register
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

@ TAX - transfer accumulator to X
inst_TAX:
    @ TODO
    bx      lr

@ TAY - transfer accumulator to Y
inst_TAY:
    @ TODO
    bx      lr

@ TXA - transfer X to accumulator
inst_TXA:
    @ TODO
    bx      lr

@ TXS - transfer X to stack pointer
inst_TXS:
    @ TODO
    bx      lr

@ TYA - transfer Y to accumulator
inst_TYA:
    @ TODO
    bx      lr

@ TSX - transfer stack pointer to X
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

@ CLC - clear carry flag
inst_CLC:
    @ TODO
    bx      lr

@ CLD - clear decimal mode
inst_CLD:
    @ TODO
    bx      lr

@ CLI - clear interrupt disable
inst_CLI:
    @ TODO
    bx      lr

@ CLV - clear overflow flag
inst_CLV:
    @ TODO
    bx      lr

@ SEC - set carry flag
inst_SEC:
    @ TODO
    bx      lr

@ SED - set decimal flag
inst_SED:
    @ TODO
    bx      lr

@ SEI - set interrupt disable
inst_SEI:
    @ TODO
    bx      lr

.align
.pool

@@@@@@@@@@@@@@@
@   COMPARE   @
@@@@@@@@@@@@@@@

.global inst_CMP, inst_CPX, inst_CPY

@ CMP - compare
inst_CMP:
    @ TODO
    bx      lr

@ CPX - compare X register
inst_CPX:
    @ TODO
    bx      lr

@ CPY - compare Y register
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

@ BEQ - branch if equal
inst_BEQ:
    @ TODO
    bx      lr

@ BNE - branch if not equal
inst_BNE:
    @ TODO
    bx      lr

@ BPL - branch if positive
inst_BPL:
    @ TODO
    bx      lr

@ BMI - branch if minus
inst_BMI:
    @ TODO
    bx      lr

@ BCC - branch if carry clear
inst_BCC:
    @ TODO
    bx      lr

@ BCS - branch if carry set
inst_BCS:
    @ TODO
    bx      lr

@ BVC - branch if overflow clear
inst_BVC:
    @ TODO
    bx      lr

@ BVS - branch if overflow set
inst_BVS:
    @ TODO
    bx      lr

@ JMP - jump
inst_JMP:
    @ TODO
    bx      lr

@ JSR - jump to subroutine
inst_JSR:
    @ TODO
    bx      lr

@ RTS - return from subroutine
inst_RTS:
    @ TODO
    bx      lr

@ RTI - return from interrupt
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

@ LDA - load accumulator
inst_LDA:
    @ TODO
    bx      lr

@ LDX - load X register
inst_LDX:
    @ TODO
    bx      lr

@ LDY - load Y register
inst_LDY:
    @ TODO
    bx      lr

@ STA - store accumulator
inst_STA:
    @ TODO
    bx      lr

@ STX - store X register
inst_STX:
    @ TODO
    bx      lr

@ STY - store Y register
inst_STY:
    @ TODO
    bx      lr

.align
.pool

@@@@@@@@@@@@@
@   STACK   @
@@@@@@@@@@@@@

.global inst_PLA, inst_PLP, inst_PHA, inst_PHP

@ PLA - pull accumulator
inst_PLA:
    @ TODO
    bx      lr

@ PLP - pull processor status
inst_PLP:
    @ TODO
    bx      lr

@ PHA - push accumulator
inst_PHA:
    @ TODO
    bx      lr

@ PHP - push processor status
inst_PHP:
    @ TODO
    bx      lr

.align
.pool

@@@@@@@@@@@@@
@   OTHER   @
@@@@@@@@@@@@@

.global inst_BRK, inst_NOP

@ BRK - force interrupt
inst_BRK:
    @ TODO
    bx      lr

@ NOP - no operation
inst_NOP:
    @ TODO
    bx      lr

.end
