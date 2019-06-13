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
	joints =  N:-1:1;


	% Initial conditions
	% The link zero has no angular velocity.
	omega_i = [0; 0; 0];

	% The same happens with the angular angular linear accelerations.
	dot_omega_i = [0; 0; 0];
	dot_v_i = initial_accelerations;

	% The tool doesn't have a force/Momentum
	f_i_1 = [0; 0; 0];
	n_i_1 = [0; 0; 0];

	%Vectors with the dynamic parameters
	F_i_plus_1 = [];
	N_i_plus_1 = [];

	% "Outer" iterations

	for link=links
		rot_mtrx_cols = ((link-1)*3+1):((link-1)*3+3);
		inertia_tensor_cols = ((link-1)*3+1):((link-1)*3+3);
		% Declaring the used parameters
		R_i_1 = transpose(rotation_matrices(:, rot_mtrx_cols));  % It needs to be transposed because we inverted the references
		dot_theta_i = joint_speeds(link);
		dot_dot_theta_i = joint_accelerations(link);
		Z_i_1 = z_vector(:, link);
		P_i_1 = relative_x_vector(:, link);
		Pc_i_1 = link_mass_centers(:, link);
		m_i_1 = link_masses(link);
		I_i_1 = link_inertia_tensors(:, inertia_tensor_cols);

		%Eq. 6.45
		omega_i_1 = R_i_1*omega_i + dot_theta_i*Z_i_1;
		omega_i_1 = simplify(omega_i_1);

		%Eq. 6.46
		dot_omega_i_1 = R_i_1*dot_omega_i + cross(R_i_1*omega_i, dot_theta_i*Z_i_1) + dot_dot_theta_i*Z_i_1;
		dot_omega_i_1 = simplify(dot_omega_i_1);
		
		%Eq. 6.47
		dot_v_i = R_i_1*(cross(dot_omega_i, P_i_1) + cross(omega_i, cross(omega_i, P_i_1)) + dot_v_i);
		dot_v_i = simplify(dot_v_i);

		%Eq. 6.48
		dot_vc_i = cross(dot_omega_i_1, Pc_i_1) + cross(omega_i_1, cross(omega_i_1, Pc_i_1)) + dot_v_i;
		dot_vc_i = simplify(dot_vc_i);

		%Eq. 6.49
		F_i_1 = m_i_1*dot_vc_i;
		F_i_1 = simplify(F_i_1);

		%Eq. 6.50
		N_i_1 = I_i_1*dot_omega_i_1 + cross(omega_i_1, (I_i_1*omega_i_1));
		N_i_1 = simplify(N_i_1);

		% Adding the forces and the torques to the vector 
		F_i_plus_1 = [F_i_plus_1 F_i_1];
		N_i_plus_1 = [N_i_plus_1 N_i_1];

		%Updating the omega_i
		omega_i = omega_i_1;
		dot_omega_i = dot_omega_i_1;

	end

	% "Inner" iterations
	F_i_plus_1;
	N_i_plus_1;

	%Vectors with the static parameters
	f_i_vector = []; %Take the last value at the F_i_plus_1
	f_i_vector = []; %Take the last value at the n_i_plus_1

	% Adding a 3x3 zeros matrix to the rotatio matrices vector
	zeros_mtrx = zeros(3,3);
	rotation_matrices = [rotation_matrices zeros_mtrx]; % CONSERTAR OS INDICES!

	joint_forces  = [];
	joint_torques = [];

	for joint=joints
		%Do the stuff
		rot_mtrx_cols = ((joint)*3+1):((joint)*3+3);
		R_i_1 = rotation_matrices(:, rot_mtrx_cols); %tenho que pegar o anterior.
		dot_theta_i = joint_speeds(joint);
		Z_i = z_vector(:, joint);
		P_i = relative_x_vector(:, joint); % são negativos??? So falta isso, aplicar para os robos e ai gg.
		Pc_i = link_mass_centers(:, joint);% são negativos???
		F_i = F_i_plus_1(:, joint);
		N_i = N_i_plus_1(:, joint);
		% Achar o Pi e o Pci
		f_i = R_i_1*f_i_1 + F_i;
		f_i = simplify(f_i);
		n_i_1 = N_i + R_i_1*n_i_1 + cross(Pc_i, F_i) + cross(P_i, (R_i_1*f_i_1));
		n_i_1 = simplify(n_i_1);

		torque_i = transpose(n_i_1)*Z_i;
		torque_i = simplify(torque_i);

		joint_forces  = [joint_forces  f_i];
		joint_torques = [joint_torques  n_i_1];

		% declara a forca para a proxima iteracao
		f_i_1 = f_i;

	end

endfunction