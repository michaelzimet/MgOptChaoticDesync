global omega M B topt uopt Zd

format long

omega = 1;
Zd = 0.5;
B=2;
%B=5;
%B=20;

T = 2*pi;
% M = 20;
M = 0.5;
lambda0 = -9;

% SNIPER PRC, with constraint
%B=10;
%T = 3;
%M = 3;
%lambda0 = -10;

% SNIPER PRC, never hit constraint
%T = 3;
%M = 10;  % large enough that never hit constraint
%lambda0 = -10;

% SNIPER PRC, with constraint
%T = 9.8;
%M = 0.3;
%M = 0.6;
%lambda0 = -10;

% SNIPER PRC, never hit constraint
%T = 9.8;
%M = 10;  % large enough that never hit constraint
%lambda0 = 1;

theta0 = 0;

for m=0:10

dlambda = 10^(-m);


x0 = [theta0;lambda0];

options = odeset('Refine',10,'RelTol',1e-7,'AbsTol',1e-10);

%options = [];

for k=1:11

   lambda0 = x0(2);

   [t,x] = ode45('func_opt_chaotic_snip',[0:0.01:T],[theta0,lambda0],options);

   stsoln = size(t);
   Htheta = x(stsoln(1),1) - 2*pi;

err = Htheta^2;

   [tp,xp] = ode45('func_opt_chaotic_snip',[0:0.01:T],[theta0,lambda0+dlambda],options);
   [tm,xm] = ode45('func_opt_chaotic_snip',[0:0.01:T],[theta0,lambda0-dlambda],options);

   stp = size(tp);
   stm = size(tm);

   Hp = xp(stp(1),1) - 2*pi;
   errp = Hp^2;

   Hm = xm(stm(1),1) - 2*pi;
   errm = Hm^2;

   ee = [errp,errm];

   if (min(ee)==errp)
      x0 = [theta0;lambda0+dlambda];
   else 
      x0 = [theta0;lambda0-dlambda];
   end
   
end

end

err
lambda0

theta = x(:,1);
lambda = x(:,2);

topt = t;
%exp for u
uopt = min(M,max(-M,((B*Zp_snip(theta)-lambda.*Z_snip(theta))/2)));

plot(t,uopt)


theta10 = 0;
theta20 = 0.1;


[tsoln,thsoln] = ode45(@func_integrate_snip,[0:0.01:T],[theta10,theta20]);

thsoln1 = thsoln(:,1);
thsoln2 = thsoln(:,2);


figure(2)
plot(tsoln,thsoln1,'b',tsoln,thsoln2,'r')

figure(3)
plot(tsoln,thsoln2-thsoln1)


figure(4)
plot(tsoln,log(thsoln2-thsoln1))


