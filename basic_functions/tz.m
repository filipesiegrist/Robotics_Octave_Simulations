function out_point = tz( in_point, z_dist )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
rotate_matrix = [
[1 0 0 0]
[0 1 0 0]
[0 0 1 z_dist]
[0 0 0 1]
];
out_point = rotate_matrix * in_point;

end

