function dy = func_opt_chaotic(t,y)

global omega M B

theta = y(1);
lambda = y(2);

utest = (B*Zp(theta)-lambda*Z(theta))/2;

if utest > M
    u = M;
elseif utest < -M
    u = -M;
else
    u = utest;
end


%these change for optimal chaotic desync
%dtheta = omega + Z(theta)*((B*Zp(theta)-lambda*Z(theta))/2);
dtheta = omega + Z(theta)*u;


%these change for optimal chaotic desync
%dlambda = (B*Zpp(theta) - lambda*Zp(theta))*((B*Zp(theta)-lambda*Z(theta))/2);
dlambda = (B*Zpp(theta) - lambda*Zp(theta))*u;


dy = [dtheta;dlambda];