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

function [joint_forces, joint_torques] = robotDynamics(N, z_vector, relative_x_vector, rotation_matrices, joint_speeds, joint_accelerations, link_masses, link_inertia_tensors, link_mass_centers)
	N = 3;
	links = 0:(N-1);
	joints = N:1;

	% "Outer" iterations

	% Initial conditions
	omega_i = 0;
	dot_omega_i = 0;
	v_i = 0;
	dot_v_i = 0;

	%Vectors with the dynamic parameters
	F_i_plus_1 = [];
	N_i_plus_1 = [];

	for link=links
		%Do the stuff
	end

	% "Inner" iterations

	%Vectors with the static parameters
	f_i = []; %Take the last value at the F_i_plus_1
	n_i = []; %Take the last value at the n_i_plus_1

	for joint=joints
		%Do the stuff
	end

endfunction