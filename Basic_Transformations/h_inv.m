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
## @deftypefn {} {@var{retval} =} h_inv (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Filipe-UFSC <filipe-ufsc@filipeufsc-Aspire-5740>
## Created: 2019-04-05

function inv_matrix = h_inv (T)
  R = T(1:3,1:3);
  P = T(1:3,4);
  
  Rinv = transpose(R);
  inv_matrix = sym(zeros(4,4));
  
  newP = -Rinv*P;
  
  %Populating the new matrix
  inv_matrix(4,4) = sym(1);
  inv_matrix(1:3,1:3) = Rinv;
  inv_matrix(1:3,4) = newP;
  

endfunction
