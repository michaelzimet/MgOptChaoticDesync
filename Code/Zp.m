function fp = Zp(theta)

global omega M B topt uopt Zd

    fp = Zd*cos(theta);  % for sinusoidal PRC
    %fp = Zd*sin(theta);   % for SNIPER PRC

 % HH PRC
     %fp = -0.05019405489425*sin(theta)  + 2*0.07035076076555*sin(2*theta)  + 3*0.01118677193793*sin(3*theta) - 4*0.01271267929416*sin(4*theta) - 5*0.00177258077023*sin(5*theta) - 6*0.00034999803453*sin(6*theta) - 7*0.00028740492486*sin(7*theta) - 8*0.00014014870722*sin(8*theta) - 9*0.00004997463194*sin(9*theta) - 10*0.00000760582414*sin(10*theta) -0.06137283848145*cos(theta)  -2*0.03357254573048*cos(2*theta) + 3*0.04026470914117*cos(3*theta) + 4*0.00417856305776*cos(4*theta) -5*0.00160690876229*cos(5*theta) + 6*0.00002885309995*cos(6*theta) + 7*0.00010848081699*cos(7*theta) + 8*0.00006638680513*cos(8*theta) + 9*0.00002930810305*cos(9*theta) -10*0.00000966641232*cos(10*theta);


    %Reduced HH (old)
   % fp = -0.089329808613738*sin(theta) +  2*0.029336277581269*sin(2*theta) +   3*0.052519571534176*sin(3*theta) +   4*0.019654561708073*sin(4*theta) +   5*0.005894856122472*sin(5*theta) +   6*0.002307278036320*sin(6*theta) +   7*0.001269597435905*sin(7*theta) + 8*8.677750627462653e-04*sin(8*theta) + 9*6.796573029442086e-04*sin(9*theta) + 10*5.708606803248151e-04*sin(10*theta) + -0.054110977478019*cos(theta) + 2*-0.092623025979316*cos(2*theta) +  3*-0.008669621336474*cos(3*theta) +  4*0.012441784784809*cos(4*theta) + 5*0.008370570886685*cos(5*theta) + 6*0.004713888729360*cos(6*theta) + 7*0.002994960037589*cos(7*theta) + 8*0.002128322832094*cos(8*theta) + 9*0.001595373362856*cos(9*theta) + 10*0.001204867801304*cos(10*theta);

    
    
end