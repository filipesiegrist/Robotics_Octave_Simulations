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
## @deftypefn {} {@var{retval} =} Inv_Esferico (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Filipe-UFSC <filipe-ufsc@filipeufsc-Aspire-5740>
## Created: 2019-04-20

function [th_1,th_2,d3] = Inv_Esferico (pos_vector, d2)
	s1 = (-pos_vector(1)+ sqrt(pos_vector(1)^2+pos_vector(2)^2-d2^2));
	c1 = (d2+pos_vector(2));
	th_1 = 2*atan2(s1,c1);
	% Taking the positive value for d3
	d3 = sqrt((pos_vector(1)*cos(th_1) + pos_vector(2)*sin(th_1))^2 +pos_vector(3)^2);
	s2 = (pos_vector(1)*cos(th_1) + pos_vector(2)*sin(th_1));
	th_2 = atan2(s2,pos_vector(3));


endfunction
