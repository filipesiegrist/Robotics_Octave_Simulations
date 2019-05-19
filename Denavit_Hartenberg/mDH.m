#
# @Author: Filipe Ernesto Siegrist Gonçalves
# @Date:   2019-05-17 17:29:21
# @Last Modified by:   filipe-ufsc
# @Last Modified time: 2019-05-17 17:29:21
#

function DH_matrix = mDH (DH_robot_table)
	% Calculates the Denavit-Hartenberg matrix of the robot defined in the input DH table
	% [alpha,a,d,theta]
	% Pattern of the input matrix:
	alpha_pos = 1;
	a_pos = 2;
	d_pos = 3;
	theta_pos = 4;

	rows = size(DH_robot_table, 1);
	DH_matrix = [
	  [sym(1) 0 0 0]
	  [0 sym(1) 0 0]
	  [0 0 sym(1) 0]
	  [0 0 0 sym(1)]
	];

	for row=1:rows
		alphai_1 = DH_robot_table(row,alpha_pos);
		ai_1 = DH_robot_table(row,a_pos);
		di = DH_robot_table(row,d_pos);
		thetai = DH_robot_table(row,theta_pos);
		DH_matrix = DH_matrix*T_back(alphai_1,ai_1,thetai,di);
		DH_matrix = simplify(DH_matrix);
	end
endfunction
