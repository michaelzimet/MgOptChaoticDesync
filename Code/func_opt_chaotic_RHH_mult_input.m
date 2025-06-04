function dy = func_opt_chaotic_RHH_mult_input(t,y)

global omega M B topt uopt a0 a b t1

theta = y(1);
lambda = y(2);

utest = (B*Zp_RHH(theta)-lambda*Z_RHH(theta))/2;

if utest > M
    u = M;
elseif utest < -M
    u = -M;
else
    u = utest;
end


%these change for optimal chaotic desync
%dtheta = omega + Z_RHH(theta)*((B*Zp_RHH(theta)-lambda*Z_RHH(theta))/2);
dtheta = omega + Z_RHH(theta)*u;


%these change for optimal chaotic desync
%dlambda = (B*Zpp_RHH(theta) - lambda*Zp_RHH(theta))*((B*Zp_RHH(theta)-lambda*Z_RHH(theta))/2);
dlambda = (B*Zpp_RHH(theta) - lambda*Zp_RHH(theta))*u;


dy = [dtheta;dlambda];