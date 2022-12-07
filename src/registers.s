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

.data

.global reg_pc, reg_a, reg_x, reg_y, reg_s, reg_sp

.align
reg_pc: .hword 0

reg_a:  .byte 0
reg_x:  .byte 0
reg_y:  .byte 0
reg_s:  .byte 0
reg_sp: .byte 0

.end
