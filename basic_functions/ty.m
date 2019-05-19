function out_point = ty( in_point, y_dist )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
rotate_matrix = [
[1 0 0 0]
[0 1 0 y_dist]
[0 0 1 0]
[0 0 0 1]
];
out_point = rotate_matrix * in_point;

end

