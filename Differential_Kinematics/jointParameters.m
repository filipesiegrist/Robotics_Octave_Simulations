#
# @Author: Filipe Ernesto Siegrist Gonçalves
# @Date:   2019-05-17 17:39:29
# @Last Modified by:   filipe-ufsc
# @Last Modified time: 2019-05-17 17:39:29
#

function [joint_z_vector, joint_pos_vector, joint_rotation_matrices_vector] = jointParameters (DH_robot_table)
	% Receives the DH robot table and returns two matrices with the positions and axis of the joints of the mechanism
	
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

	% This vector starts with the axis of the referential of the base.
	z_lines = 1:3;
	z_col = 3;
	joint_z_vector = [];

	% This vector will contain the expressions of the joint positions, starting at the first joint.
	pos_lines = 1:3;
	pos_col = 4;
	joint_pos_vector = [];


	% This vector will contain the rotation matrices from i to i+1, from zero to N.
	rotation_matrix_lines = 1:3;
	rotation_matrix_cols = 1:3;
	joint_rotation_matrices_vector = [];

	rot_mtrx = [
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

		DH_matrix = DH_matrix*Screw_x(alphai_1,ai_1);
		DH_matrix = simplify(DH_matrix);

		rot_mtrx = rot_mtrx*Screw_x(alphai_1,ai_1);
		rot_mtrx = simplify(rot_mtrx);
		

		% Gets the point before using the operation Screw_z, so the values match with the bibliography.
		joint_pos_vector = [joint_pos_vector  DH_matrix(pos_lines, pos_col)];

		joint_rotation_matrices_vector = [
		joint_rotation_matrices_vector rot_mtrx(rotation_matrix_lines, rotation_matrix_cols)
		];
		rot_mtrx = [
		  [sym(1) 0 0 0]
		  [0 sym(1) 0 0]
		  [0 0 sym(1) 0]
		  [0 0 0 sym(1)]
		];

		DH_matrix = DH_matrix*Screw_z(thetai,di);
		DH_matrix = simplify(DH_matrix);

		rot_mtrx = rot_mtrx*Screw_z(thetai,di);

		joint_z_vector = [joint_z_vector  DH_matrix(z_lines, z_col)];
	end
endfunction
