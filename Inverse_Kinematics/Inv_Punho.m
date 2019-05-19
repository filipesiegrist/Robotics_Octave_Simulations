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
## @deftypefn {} {@var{retval} =} Inv_Punho (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Filipe-UFSC <filipe-ufsc@filipeufsc-Aspire-5740>
## Created: 2019-04-20

function [th_4,th_5,th_6] = Inv_Punho (R63)
% Dada uma orientação desejada (R63, matriz 3x3), computa os angulos do punho.
	N = R63(:,1);
	S = R63(:,2);
	A = R63(:,3);

	ax = A(1);
	ay = A(2);
	az = A(3);
	sz = S(3);
	nz = S(3);

	% using theta5 in (-pi,0)
	th_4 = atan2(ay,ax);
	th_5 = atan2(sqrt(ay^2+ax^2),az);
	th_6 = atan2(sz,-nz);

endfunction
