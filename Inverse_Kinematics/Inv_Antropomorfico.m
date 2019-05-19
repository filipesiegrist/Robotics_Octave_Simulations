#
# @Author: Filipe Ernesto Siegrist Gonçalves
# @Date:   2019-04-20 21:31:14
# @Last Modified by:   filipe-ufsc
# @Last Modified time: 2019-05-09 23:14:38
#
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
## @deftypefn {} {@var{retval} =} Inv_Antropomorfico (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Filipe-UFSC <filipe-ufsc@filipeufsc-Aspire-5740>
## Created: 2019-04-20

function [th_1,th_2,th_3] = Inv_Antropomorfico (a2,a3,pwx,pwy,pwz)

	c3 = (pwx**2 + pwy**2 + pwz**2 - a2**2 - a3**2) / (2*a2*a3);
    s3 = sqrt(1-c3^2); % pode ser positivo
    th_3 = atan2(s3,c3);

    % É possivel trocar o sinal das duas raizes, mas tem que fazer nas duas.
	c2 = (sqrt(pwx^2+pwy^2)*(a2+a3*c3) + pwz*a3*s3) / (a2^2+a3^2+2*a2*a3*c3);
    s2 = (pwz*(a2+a3*c3)-sqrt(pwx^2+pwy^2)*a3*s3) / (a2^2+a3^2+2*a2*a3*c3);
    th_2 = atan2(s2,c2);

    th_1 = atan2(pwy,pwx);

endfunction
