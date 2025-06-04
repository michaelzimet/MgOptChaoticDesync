function dy = func_integrate_sin_mult_input(t,y)

global omega M B topt uopt Zd t1

th1 = y(1);
th2 = y(2);

%u = interp(t,topt,uopt);

% multiple inputs

if t < t1
   u = interp(t,topt,uopt);
else  % beyond the length of the optimal input
   u = 0;
end

dth1 = omega + Z_sin(th1)*u;
dth2 = omega + Z_sin(th2)*u;

dy = [dth1;dth2];

end