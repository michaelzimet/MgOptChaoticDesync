global omega M B topt uopt t1

format long

%omega = 1;
%Zd = 0.1;
B = 2;
%B=5;
%B = 20;

% HH PRC
omega = 0.4315;
T = 2*pi/omega;
t1=T;
M = 0.4;  % hits constraint
lambda0 = -2;

% HH PRC
%T = 15;
%M = 10;  % large enough that never hit constraint
%lambda0 = 2;
%omega = 0.4315;

% HH PRC
%T = 11.85;
%M = 10;  % large enough that never hit constraint
%lambda0 = 2;
%omega = 2*pi/T;

theta0 = 0;

theta10 = 0;
theta20 = 0.1;


theta0 = 0;

target = omega*t1;

for m=0:10

dlambda = 10^(-m);

x0 = [theta0;lambda0];

options = odeset('Refine',10,'RelTol',1e-7,'AbsTol',1e-10);

%options = [];

for k=1:11

   lambda0 = x0(2);

   [t,x] = ode45('func_opt_chaotic_HH_mult_input',[0:0.01:t1],[theta0,lambda0],options);

   stsoln = size(t);
   Htheta = x(stsoln(1),1) - target;

err = Htheta^2;

   [tp,xp] = ode45('func_opt_chaotic_HH_mult_input',[0:0.01:t1],[theta0,lambda0+dlambda],options);
   [tm,xm] = ode45('func_opt_chaotic_HH_mult_input',[0:0.01:t1],[theta0,lambda0-dlambda],options);

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
   
   %disp([lambda0,dlambda,min(ee)])
   
end

end

err
lambda0

theta = x(:,1);
lambda = x(:,2);

topt = t;
%exp for u
uopt = min(M,max(-M,((B*Zp_HH(theta)-lambda.*Z_HH(theta))/2)));

plot(t,uopt)

% for every call to ode45, we reset the
% intial time to 0.  t_offset keeps track
% of the shift back to the actual time.
t_offset = 0;  
tsoln = [];  % initially empty
theta1_soln = [];  % initially empty
theta2_soln = [];  % initially empty

theta10 = 0;  % initial theta1 
theta20 = 0.1; %0.01  % inital theta2

% This will be used to integrate the 
% equations until theta1 = 2*pi 
opt = odeset('Events',@EventsFunction);

num_inputs = 5;  % number of inputs
for i = 1:num_inputs
   % integrate until theta1 = 2*pi
    [tsoln_new,theta_soln_new] = ode45(@func_integrate_HH_mult_input,[0:0.01:20],[theta10,theta20],opt);

   len = length(tsoln_new);
   
   % initial conditions for next iteration
   % note: subtract 2*pi because the 
   % integration stops when theta1 hits 2*pi
   theta10 = theta_soln_new(len,1)-2*pi;
   theta20 = theta_soln_new(len,2)-2*pi;
   
   % concatenate latest solution to the
   % solution vectors
   tsoln = cat(1,tsoln,t_offset + tsoln_new);
   theta1_soln = cat(1,theta1_soln,theta_soln_new(:,1));
   theta2_soln = cat(1,theta2_soln,theta_soln_new(:,2));

   % update t_offset
   t_offset = t_offset + tsoln_new(len);

end

figure(2)
plot(tsoln,theta1_soln,'b',tsoln,theta2_soln,'r')

figure(3)
plot(tsoln,theta2_soln-theta1_soln)

figure(4)
plot(tsoln,log(theta2_soln-theta1_soln))

