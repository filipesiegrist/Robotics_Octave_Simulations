## Copyright (C) 2019 Filipe-UFSC
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} Inv_Antrop_Completo (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Filipe-UFSC <filipe-ufsc@filipeufsc-Aspire-5740>
## Created: 2019-04-20

% Calcula os angulos das juntas, dados os parametros dos elos a2 e a3, a posicao e a orientacao desejadas.
function [th_1, th_2, th_3, th_4, th_5, th_6] = Inv_Antrop_Completo (a2, a3, pos_vector, orientation)
	[th_1,th_2,th_3] = Inv_Antropomorfico(a2, a3, pos_vector);
	[th_4,th_5,th_6] = Inv_Punho(orientation);
endfunction
