function out = f_2(scale,params)

x1 = params.parameter1(1);
x2 = params.parameter2(1);
%val = x.^2 + y.^2 + z.^2;
out = 100 * (x1^2 - x2)^2 + (1 - x1)^2;
pause(0.1);