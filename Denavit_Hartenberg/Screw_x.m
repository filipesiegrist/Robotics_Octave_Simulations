#
# @Author: Filipe Ernesto Siegrist Gonçalves
# @Date:   2019-05-19 17:22:32
# @Last Modified by:   filipe-ufsc
# @Last Modified time: 2019-04-20 15:11:25
#

function T = Screw_x (alfai_1,ai_1)
  %Turns the referential in a angle 'alfai_1' and moves it in 'ai_1'
  addpath('./Basic_Transformations/');
  T = mtx(ai_1);
  T = mrotx(alfai_1)*T;

endfunction
