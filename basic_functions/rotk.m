function out_point = rotk( in_point, k_vector, angle )
%Rotaciona o in_point angle graus em torno do vetor k_vector
kx = k_vector(1);
ky = k_vector(2);
kz = k_vector(3);

ct = cos(angle);
st = sin(angle);
vt = 1 - cos(angle);

rotate_matrix = [
[kx*kx*vt+ct kx*ky*vt-kz*st kx*kz*vt+ky*st 0]
[kx*ky*vt+kz*st ky*ky*vt+ct ky*kz*vt-kx*st 0]
[kx*kz*vt-ky*st ky*kz*vt+kx*st kz*kz*vt+ct 0]
[0 0 0 1]
];

out_point = rotate_matrix * in_point;

end

