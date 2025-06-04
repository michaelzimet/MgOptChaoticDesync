function f = Z(theta)
    
global omega M B topt uopt Zd

    f = Zd*sin(theta);     % sinusoidal PRC
    %f = Zd*(1-cos(theta));  % SNIPER PRC

  % HH PRC
    %f = 0.03180471574922/2 + 0.05019405489425*cos(theta) -0.07035076076555*cos(2*theta)  -0.01118677193793*cos(3*theta) + 0.01271267929416*cos(4*theta) + 0.00177258077023*cos(5*theta) + 0.00034999803453*cos(6*theta) + 0.00028740492486*cos(7*theta) + 0.00014014870722*cos(8*theta) + 0.00004997463194*cos(9*theta) + 0.00000760582414*cos(10*theta) -0.06137283848145*sin(theta)  -0.03357254573048*sin(2*theta) + 0.04026470914117*sin(3*theta) + 0.00417856305776*sin(4*theta) -0.00160690876229*sin(5*theta) + 0.00002885309995*sin(6*theta) + 0.00010848081699*sin(7*theta) + 0.00006638680513*sin(8*theta) + 0.00002930810305*sin(9*theta) -0.00000966641232*sin(10*theta);
  

    %Reduced HH -- run find_fourier.m first
   % f= a0;
   % for n = 1:10
   %     f = f + a(n)*cos(n*th)+ b(n)*sin(n*th);
   % end

    %f =   0.023414522420240 + 0.089329808613738*cos(theta) +  -0.029336277581269*cos(2*theta) +   -0.052519571534176*cos(3*theta) +   -0.019654561708073*cos(4*theta) +   -0.005894856122472*cos(5*theta) +   -0.002307278036320*cos(6*theta) +   -0.001269597435905*cos(7*theta) + -8.677750627462653e-04*cos(8*theta) + -6.796573029442086e-04*cos(9*theta) + -5.708606803248151e-04*cos(10*theta) + -0.054110977478019*sin(theta) + -0.092623025979316*sin(2*theta) +  -0.008669621336474*sin(3*theta) +  0.012441784784809*sin(4*theta) + 0.008370570886685*sin(5*theta) + 0.004713888729360*sin(6*theta) + 0.002994960037589*sin(7*theta) + 0.002128322832094*sin(8*theta) + 0.001595373362856*sin(9*theta) + 0.001204867801304*sin(10*theta);
    %plot(th, Z(th))


end