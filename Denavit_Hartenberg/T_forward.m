#
# @Author: Filipe Ernesto Siegrist Gonçalves
# @Date:   2019-05-19 17:22:32
# @Last Modified by:   filipe-ufsc
# @Last Modified time: 2019-04-20 15:11:25
#

function T = T_forward (alfai_1,ai_1,thetai,di)
  %Transforms the reference to the next link
  % from (i-1) to (i)
  addpath('./Basic_Transformations/');
  T = mtx(ai_1)*T;
  T = mrotx(alfai_1)*T;
  T = mtz(di);
  T = mrotz(thetai)*T;

endfunction
