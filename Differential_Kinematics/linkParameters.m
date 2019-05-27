#
# @Author: Filipe Ernesto Siegrist Gonçalves
# @Date:   2019-05-17 17:39:29
# @Last Modified by:   filipe-ufsc
# @Last Modified time: 2019-05-27 20:26:29
#

function [rotation_matrices_vector, relative_positions_vector] = linkParameters (DH_robot_table)
	% Receives the DH robot table and returns two lists with the relative positions and orientation of the mechanism links
	
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

	% This vector will contain the rotation matrices from i to i+1, from zero to N.
	rotation_matrix_lines = 1:3;
	rotation_matrix_cols = 1:3;
	rotation_matrices_vector = [];

	% This vector will contain the relative positions from i to i+1, from zero to N.
	relative_positions_lines = 1:3;
	relative_positions_col = 4;
	relative_positions_vector = [];

	transf_mtrx = [
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

		transf_mtrx = transf_mtrx*Screw_x(alphai_1,ai_1);
		transf_mtrx = simplify(transf_mtrx);
		
		% Insert the calculated rotation matrices and relative position at their respective lists/vectors
		rotation_matrices_vector = [
		rotation_matrices_vector transf_mtrx(rotation_matrix_lines, rotation_matrix_cols)
		];

		relative_positions_vector = [
			relative_positions_vector transf_mtrx(relative_positions_lines, relative_positions_col)
		];

		% Resets the transformation matrix.
		transf_mtrx = [
		  [sym(1) 0 0 0]
		  [0 sym(1) 0 0]
		  [0 0 sym(1) 0]
		  [0 0 0 sym(1)]
		];

		transf_mtrx = transf_mtrx*Screw_z(thetai,di);
	end
endfunction
