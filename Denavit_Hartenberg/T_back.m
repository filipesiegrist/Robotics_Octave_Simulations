#
# @Author: Filipe Ernesto Siegrist Gonçalves
# @Date:   2019-05-19 17:22:32
# @Last Modified by:   filipe-ufsc
# @Last Modified time: 2019-04-20 15:11:25
#

function T = T_back (alfai_1,ai_1,thetai,di)
  %Transforms the reference to the previous link (i-1)
  addpath('./Basic_Transformations/');
  T = mtz(di);
  T = mrotz(thetai)*T;
  T = mtx(ai_1)*T;
  T = mrotx(alfai_1)*T;

endfunction
