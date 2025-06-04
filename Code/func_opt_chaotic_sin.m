function dy = func_opt_chaotic_sin(t,y)

global omega M B

theta = y(1);
lambda = y(2);

utest = (B*Zp_sin(theta)-lambda*Z_sin(theta))/2;

if utest > M
    u = M;
elseif utest < -M
    u = -M;
else
    u = utest;
end


%these change for optimal chaotic desync
%dtheta = omega + Z_sin(theta)*((B*Zp_sin(theta)-lambda*Z_sin(theta))/2);
dtheta = omega + Z_sin(theta)*u;

%these change for optimal chaotic desync
%dlambda = (B*Zpp_sin(theta) - lambda*Zp_sin(theta))*((B*Zp_sin(theta)-lambda*Z_sin(theta))/2);
dlambda = (B*Zpp_sin(theta) - lambda*Zp_sin(theta))*u;


dy = [dtheta;dlambda];