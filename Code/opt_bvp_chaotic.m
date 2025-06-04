global omega M B topt uopt Zd

format long

omega = 1;
Zd = 0.1;
%B=0.1;
B = 2;
%B=10;
%B = 0.2;

% sinusoidal PRC, with constraint
T = 2*pi;
% M = 20;
M = 0.4;
lambda0 = 2;

% sinusoidal PRC, never hit constraint
% T = 2.8;
% M = 10;  % large enough that never hit constraint
% lambda0 = -20;

% sinusoidal PRC, with constraint
% T = 10; 
% M = 0.55;
% lambda0 = -5;

% sinusoidal PRC, never hit constraint
%T = 10;%
%M = 10;  % large enough that never hit constraint
%lambda0 = -5;

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

% HH PRC
%omega = 0.4315;
%T = 2*pi/omega;
%M = 1.0;  % hits constraint
%lambda0 = -2;

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

for m=0:10

dlambda = 10^(-m);


x0 = [theta0;lambda0];

options = odeset('Refine',10,'RelTol',1e-7,'AbsTol',1e-10);

%options = [];

for k=1:11

   lambda0 = x0(2);

   [t,x] = ode45('func_opt_chaotic',[0:0.01:T],[theta0,lambda0],options);

   stsoln = size(t);
   Htheta = x(stsoln(1),1) - 2*pi;

err = Htheta^2;

   [tp,xp] = ode45('func_opt_chaotic',[0:0.01:T],[theta0,lambda0+dlambda],options);
   [tm,xm] = ode45('func_opt_chaotic',[0:0.01:T],[theta0,lambda0-dlambda],options);

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
uopt = min(M,max(-M,((B*Zp(theta)-lambda.*Z(theta))/2)));

%plot(2*pi*t/T,uopt)
plot(t,uopt)

%th=0:0.01:2*pi;
%figure(2)
%plot(th,Zp(th))


theta10 = 0;
theta20 = 0.1;

%{
t1(1) = 0;
th1(1) = theta10;
th2(1) = theta20;


for i = 1:628
    th1(i+1) = th1(i) + (omega + Z(th1(i))*uopt(i))*0.01;
    th2(i+1) = th2(i) + (omega + Z(th2(i))*uopt(i))*0.01;
    t1(i+1) = t1(i) + 0.01;
end

tsoln = t1;
thsoln1 = th1;
thsoln2 = th2;
%}

%check this carefully
[tsoln,thsoln] = ode45(@func_integrate,[0:0.01:T],[theta10,theta20]);

thsoln1 = thsoln(:,1);
thsoln2 = thsoln(:,2);

% multiple inputs
%plot(tsoln,mod(thsoln1,2*pi),'b',tsoln,mod(thsoln2,2*pi),'r')

%stop



%[t1,th] = ode45('func_dynamics',[0:0.01:T],[theta10,theta20],options);

%th1 = th(:,1);
%th2 = th(:,2);

%next step: approximate integral from ode45
%Liap = sum(uopt'.*Zp(th1))*0.01 / (2*pi)

%a = polyfit(t1, log(th2-th1),1);
%Liap_fit = a(1)

figure(2)
plot(tsoln,thsoln1,'b',tsoln,thsoln2,'r')

figure(3)
plot(tsoln,thsoln2-thsoln1)


figure(4)
plot(tsoln,log(thsoln2-thsoln1))

% toy examples -- systematically go through range of M values (and B)

% checking integral more carefully -- trapezoid rule

% Analytical discussion of why it looks like Zp
