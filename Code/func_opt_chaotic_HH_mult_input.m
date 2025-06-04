function dy = func_opt_chaotic_HH_mult_input(t,y)

global omega M B


theta = y(1);
lambda = y(2);

utest = (B*Zp_HH(theta)-lambda*Z_HH(theta))/2;

if utest > M
    u = M;
elseif utest < -M
    u = -M;
else
    u = utest;
end


%these change for optimal chaotic desync
%dtheta = omega + Z_HH(theta)*((B*Zp_HH(theta)-lambda*Z_HH(theta))/2);
dtheta = omega + Z_HH(theta)*u;


%these change for optimal chaotic desync
%dlambda = (B*Zpp_HH(theta) - lambda*Zp_HH(theta))*((B*Zp_HH(theta)-lambda*Z_HH(theta))/2);
dlambda = (B*Zpp_HH(theta) - lambda*Zp_HH(theta))*u;


dy = [dtheta;dlambda];