global omega M B topt uopt a0 a b

format long

B = 9;
%B=20;
%B=40;

% Reduced HH PRC
T = 11.85;
omega = 2*pi/T;
t1 = T; 
M = 1.5;
lambda0 = -10;
%lambda0 = 2;

% Reduced HH with conds from Wilson paper
%t1 = 10.34;

%Calculate Fourier Coefficients for Z
find_fourier;

%2-point boundary value problem
theta0 = 0;

target = omega*t1;

for m=0:10

dlambda = 10^(-m);

x0 = [theta0;lambda0];

options = odeset('Refine',10,'RelTol',1e-7,'AbsTol',1e-10);

%options = [];

for k=1:11

   lambda0 = x0(2);

   [t,x] = ode45('func_opt_chaotic_RHH',[0:0.01:t1],[theta0,lambda0],options);

   stsoln = size(t);
   Htheta = x(stsoln(1),1) - target;

err = Htheta^2;

   [tp,xp] = ode45('func_opt_chaotic_RHH',[0:0.01:t1],[theta0,lambda0+dlambda],options);
   [tm,xm] = ode45('func_opt_chaotic_RHH',[0:0.01:t1],[theta0,lambda0-dlambda],options);

   stp = size(tp);
   stm = size(tm);

   Hp = xp(stp(1),1) - target;
   errp = Hp^2;

   Hm = xm(stm(1),1) - target;
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
uopt = min(M,max(-M,((B*Zp_RHH(theta)-lambda.*Z_RHH(theta))/2)));

plot(t,uopt)

theta10 = 0;
theta20 = 0.1;
[tsoln,thsoln] = ode45(@func_integrate_RHH,[0:0.01:t1],[theta10,theta20]);

thsoln1 = thsoln(:,1);
thsoln2 = thsoln(:,2);

figure(2)
plot(tsoln,thsoln1,'b',tsoln,thsoln2,'r')

figure(3)
plot(tsoln,thsoln2-thsoln1)

figure(4)
plot(tsoln,log(thsoln2-thsoln1))