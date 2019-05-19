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
## @deftypefn {} {@var{retval} =} mrotk (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Filipe-UFSC <filipe-ufsc@filipeufsc-Aspire-5740>
## Created: 2019-04-05

function out_matrix = mrotk(k_vector, angle )
%Rotaciona o in_point angle graus em torno do vetor k_vector
kx = k_vector(1);
ky = k_vector(2);
kz = k_vector(3);

ct = cos(angle);
st = sin(angle);
vt = 1 - cos(angle);

out_matrix = [
[kx*kx*vt+ct kx*ky*vt-kz*st kx*kz*vt+ky*st 0]
[kx*ky*vt+kz*st ky*ky*vt+ct ky*kz*vt-kx*st 0]
[kx*kz*vt-ky*st ky*kz*vt+kx*st kz*kz*vt+ct 0]
[0 0 0 sym(1)]
];

end

