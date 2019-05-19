function out_point = tx( in_point, x_dist )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
rotate_matrix = [
[1 0 0 x_dist]
[0 1 0 0]
[0 0 1 0]
[0 0 0 1]
];
out_point = rotate_matrix * in_point;

end

