function dy = func_opt_chaotic_snip(t,y)

global omega M B

theta = y(1);
lambda = y(2);

utest = (B*Zp_snip(theta)-lambda*Z_snip(theta))/2;

if utest > M
    u = M;
elseif utest < -M
    u = -M;
else
    u = utest;
end


%these change for optimal chaotic desync
%dtheta = omega + Z_snip(theta)*((B*Zp_snip(theta)-lambda*Z_snip(theta))/2);
dtheta = omega + Z_snip(theta)*u;


%these change for optimal chaotic desync
%dlambda = (B*Zpp_snip(theta) - lambda*Zp_snip(theta))*((B*Zp_snip(theta)-lambda*Z_snip(theta))/2);
dlambda = (B*Zpp_snip(theta) - lambda*Zp_snip(theta))*u;


dy = [dtheta;dlambda];