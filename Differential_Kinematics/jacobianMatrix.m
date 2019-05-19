#
# @Author: Filipe Ernesto Siegrist Gonçalves
# @Date:   2019-05-17 17:55:16
# @Last Modified by:   filipe-ufsc
# @Last Modified time: 2019-05-17 17:55:16
#

function J = jacobianMatrix(z_vector, pos_vector, prismatic_joints_indexes)
	% Receives the positions and the axis of a mechanism joints, along with a vector with flags indicating the position of the prismatic joints and returns the jacobian matrix of the system
	assert(nargin == 2 || nargin == 3, "Error. Invalid number of arguments passed.");

	is_pure_rotational_mechanism = (nargin == 2);

	%
	% Format of the matrix with the parameters:
	%  _                  _
	% |   Z0, Z1, ... Zn   | (first 3 columns)
	% |_  P0, P1, ... Pn  _| (last 3 columns)
	%
	% 

	z_pos = 1:3;
	p_pos = 4:6;
	% Starts with the first joint, with Z1 and Z2
	init_pos = 2;

	joint_parameters = [z_vector ; pos_vector];
	last_joint = size(transpose(joint_parameters),1);

	objective_point = pos_vector(:, last_joint);

	if is_pure_rotational_mechanism
		% Arrumar isso aqui, colocar pra retornar muitos zeros
		prismatic_joints_indexes = zeros(last_joint, 1);
	end

	J = []
	
	for i = init_pos:last_joint
		% Analyzes Z(i-1) and P(i-1)
		Zi_1 = joint_parameters(z_pos, i-1);
		Pi_1 = joint_parameters(p_pos, i-1);

		is_prismatic = prismatic_joints_indexes(i) > 0;
		if is_prismatic
			JPi = Zi_1;
			JOi = [0; 0; 0];
		else
			JPi = cross(Zi_1, (objective_point - Pi_1));
			JOi = Zi_1;
		end
		J = [J [JPi; JOi]];
	end
	J = simplify(J);

endfunction