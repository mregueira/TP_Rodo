function [d] = distancia(a, b)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x = [a; b];
p1 = [0; 2];
p2 = [2; 0];

% checkeo de que lado de la pared esta el punto
% https://stackoverflow.com/questions/3838319/how-can-i-check-if-a-point-is-below-a-line-or-not
v1 = p2-p1;  % v1 = [2, -2] siempre
v2 = p2-x;   % v2 = [2-x, -y]
cross_prod = v1(1)*v2(2)-v1(2)*v2(1);
% ejemplo: si (x,y) = (0, 0), v2=[2, 0] y cross_prod=2*0+2*2=+4 > 0
% entonces el lado en el que estoy "adentro de la pared"
% es el que corresponde a cross(v1, v2) < 0
if cross_prod < 0
    % calculo del punto mas cercano a x sobre la recta ax+by+c=0
    % nuestra recta es x+y-2=0
    a = 1;
    b = 1;
    c = -2;
    x0 = x(1); y0 = x(2);
    xp1 = (b*(b*x0-a*y0)-a*c) / (a^2+b^2);
    xp2 = (a*(-b*x0+a*y0)-b*c) / (a^2+b^2);
    xp = [xp1; xp2];

    d = norm(x - xp);
else
    d = [-1; -1];
end

end

