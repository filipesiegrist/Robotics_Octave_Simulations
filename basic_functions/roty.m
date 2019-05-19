function out_point = roty( in_point, angle )

rotate_matrix = [
[cos(angle) 0 sin(angle) 0]
[0 1 0 0]
[-1*sin(angle) 0 cos(angle) 0]
[0 0 0 1]
];
out_point = rotate_matrix * in_point;

end

