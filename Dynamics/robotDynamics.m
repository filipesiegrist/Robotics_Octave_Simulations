%
% @Author: Filipe Ernesto Siegrist Gonçalves
% @Date:   2019-05-27 14:45:58
% @Last Modified by:   filipe-ufsc
% @Last Modified time: 2019-05-27 14:45:58
%

# 
#	Calculate the efforts on the joints of the robot.
#	Efforts: Forces and Torques.
#	
#	Uses the Newton-Euler algorythm as show by Craig(2013)
#	
#	Receives the following informations:
#	Robot: N (number of links)
#	Joints:
#		Z-axis (previously calculated)
#		Relative Position (in the direction of the X axis) (previously calculated)
#		Rotation Matrix (previously calculated)
#		Angular Speed
#		Angular Acceleration
#	Links:
#		Mass
#		Inertia Tensor
#		Mass center position
#	

function [joint_forces, joint_torques] = robotDynamics(N, z_vector, relative_x_vector, rotation_matrices, joint_speeds, joint_accelerations, link_masses, link_inertia_tensors, link_mass_centers, initial_accelerations)
	links = 1:N;
	joints = N:1;

	% Initial conditions
	% The link zero has no angular velocity.
	omega_i = [0; 0; 0];

	% The same happens with the angular angular linear accelerations.
	dot_omega_i = [0; 0; 0];
	dot_v_i = initial_accelerations;

	% The tool doesn't have a force/Momentum
	F_n = 0;
	N_n = 0;

	%Vectors with the dynamic parameters
	F_i_plus_1 = [];
	N_i_plus_1 = [];

	% "Outer" iterations

	for link=links
		rot_mtrx_cols = ((link-1)*3+1):((link-1)*3+3);
		% Declaring the used parameters
		R_i_1 = transpose(rotation_matrices(:, rot_mtrx_cols))  % It needs to be transposed because we inverted the references
		dot_theta_i = joint_speeds(link)
		dot_dot_theta_i = joint_accelerations(link)
		Z_i_1 = z_vector(:, link)
		P_i_1 = relative_x_vector(:, link)
		Pc_i_1 = link_mass_centers(:, link)

		%Eq. 6,45
		omega_i_1 = R_i_1*omega_i + dot_theta_i*Z_i_1;
		omega_i_1 = simplify(omega_i_1)

		%Eq. 6,46
		dot_omega_i_1 = R_i_1*dot_omega_i + cross(R_i_1*omega_i, dot_theta_i*Z_i_1) + dot_dot_theta_i*Z_i_1;
		dot_omega_i_1 = simplify(dot_omega_i_1)
		
		%Eq. 6,47
		dot_v_i = R_i_1*(cross(dot_omega_i, P_i_1) + cross(omega_i, cross(omega_i, P_i_1)) + dot_v_i);
		dot_v_i = simplify(dot_v_i)

		%Eq. 6,48
		cross(dot_omega_i_1, Pc_i_1)
		cross(omega_i_1, cross(omega_i_1, Pc_i_1))
		dot_vc_i = cross(dot_omega_i_1, Pc_i_1) + cross(omega_i_1, cross(omega_i_1, Pc_i_1) + dot_v_i);
		dot_vc_i = simplify(dot_vc_i)

		%Eq. 6,49
		

		%Eq. 6,50
	
		%Updating the omega_i
		omega_i = omega_i_1;
		dot_omega_i = dot_omega_i_1;

	end

	% "Inner" iterations

	%Vectors with the static parameters
	f_i = []; %Take the last value at the F_i_plus_1
	n_i = []; %Take the last value at the n_i_plus_1

	for joint=joints
		%Do the stuff
		joint
	end

endfunction