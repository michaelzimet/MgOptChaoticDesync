numpts = 1185;

theta_data;
Z_data;

a0 = sum(Zdata(1:numpts-1).*(theta(2:numpts)-theta(1:numpts-1)))/(2*pi);

ff=a0;
ffp=0;
ffpp=0;

th = 0:0.01:2*pi;

for n = 1:200

   a(n) = sum(Zdata(1:numpts-1).*cos(n*theta(1:numpts-1)).*(theta(2:numpts)-theta(1:numpts-1)))/pi;

   b(n) = sum(Zdata(1:numpts-1).*sin(n*theta(1:numpts-1)).*(theta(2:numpts)-theta(1:numpts-1)))/pi;
    
   ff = ff + a(n)*cos(n*th)+ b(n)*sin(n*th);
   ffp = ffp - n*a(n)*sin(n*th)+ n*b(n)*cos(n*th);
   ffpp = ffpp - n*n*a(n)*cos(n*th)+ -n*n*b(n)*sin(n*th);
end


%th = 0:0.01:2*pi;

%ff = a0 + a(1)*cos(th) + a(2)*cos(2*th) + a(3)*cos(3*th) +a(4)*cos(4*th) + a(5)*cos(5*th) + a(6)*cos(6*th) + a(7)*cos(7*th) + a(8)*cos(8*th) + a(9)*cos(9*th) + a(10)*cos(10*th) + b(1)*sin(th) + b(2)*sin(2*th) + b(3)*sin(3*th) + b(4)*sin(4*th) + b(5)*sin(5*th) + b(6)*sin(6*th) + b(7)*sin(7*th) + b(8)*sin(8*th) + b(9)*sin(9*th) + b(10)*sin(10*th)

%figure(1)
%plot(th,ff)
  
%ffp = a0 + -a(1)*sin(th) + -2*a(2)*sin(2*th) + -3*a(3)*sin(3*th) +-4*a(4)*sin(4*th) + -5*a(5)*sin(5*th) + -6*a(6)*sin(6*th) + -7*a(7)*sin(7*th) + -8*a(8)*sin(8*th) + -9*a(9)*sin(9*th) + -10*a(10)*sin(10*th) + b(1)*cos(th) + 2*b(2)*cos(2*th) + 3*b(3)*cos(3*th) + 4*b(4)*cos(4*th) + 5*b(5)*cos(5*th) + 6*b(6)*cos(6*th) + 7*b(7)*cos(7*th) + 8*b(8)*cos(8*th) + 9*b(9)*cos(9*th) + 10*b(10)*cos(10*th)

%save the a's and b's, pass to function

%figure(2)
%   plot(th,ffp)
%figure(3)
%   plot(th,ffpp)