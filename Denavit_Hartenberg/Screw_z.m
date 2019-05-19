#
# @Author: Filipe Ernesto Siegrist Gonçalves
# @Date:   2019-05-19 17:22:32
# @Last Modified by:   filipe-ufsc
# @Last Modified time: 2019-04-20 15:11:25
#

function T = Screw_z (thetai,di)
  %Turns the referential in a angle 'thetai' and moves it in 'di'
  addpath('./Basic_Transformations/');
  T = mtz(di);
  T = mrotz(thetai)*T;

endfunction
