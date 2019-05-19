function out_point = rotz( in_point, angle )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
rotate_matrix = [
[cos(angle) -1*sin(angle) 0 0]
[sin(angle) cos(angle) 0 0]
[0 0 1 0]
[0 0 0 1]
];
out_point = rotate_matrix * in_point;

end

