function dy = func_integrate_snip(t,y)

global omega M B topt uopt Zd

th1 = y(1);
th2 = y(2);

u = interp(t,topt,uopt);

% multiple inputs
%u = interp(mod(t,2*pi/omega),topt,uopt);

dth1 = omega + Z_snip(th1)*u;
dth2 = omega + Z_snip(th2)*u;

dy = [dth1;dth2];

end