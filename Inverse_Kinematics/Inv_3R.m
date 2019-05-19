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
## @deftypefn {} {@var{retval} =} Inv_3R (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Filipe-UFSC <filipe-ufsc@filipeufsc-Aspire-5740>
## Created: 2019-04-20

function [ th1, th2, th3 ] = Inv_3R (px,py,phi,a1,a2,a3)
  pwx = px - a3*cos(phi);
  pwy = py - a3*sin(phi);

  c2 = ((pwx^2) + (pwy^2) -(a1^2) - (a2^2)) / (2*a1*a2);
  th2 = acos(c2);

  alpha = atan2(pwy,pwx);
  beta = acos( ((pwx^2) + (pwy^2) +(a1^2) - (a2^2)) / (2*a1*sqrt(pwx^2+pwy^2)) );

  %Using the upper arm position
  th1 = alpha + beta;

  th3 = phi - th1 - th2;

endfunction
