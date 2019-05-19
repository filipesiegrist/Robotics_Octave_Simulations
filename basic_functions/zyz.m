function out_point = zyz( in_point, alfa, beta, gama )
%Rotaciona o in_point gama em torno de x, beta em torno de y e alfa em
%torno de x. ÂNGULOS EM RADIANOS!
out_point = rotz(in_point,gama)
out_point = roty(out_point,beta)
out_point = rotz(out_point,alfa)

end

