function f = Z_HH(theta)
    
global omega M B topt uopt Zd

  % HH PRC
    f = 0.03180471574922/2 + 0.05019405489425*cos(theta) -0.07035076076555*cos(2*theta)  -0.01118677193793*cos(3*theta) + 0.01271267929416*cos(4*theta) + 0.00177258077023*cos(5*theta) + 0.00034999803453*cos(6*theta) + 0.00028740492486*cos(7*theta) + 0.00014014870722*cos(8*theta) + 0.00004997463194*cos(9*theta) + 0.00000760582414*cos(10*theta) -0.06137283848145*sin(theta)  -0.03357254573048*sin(2*theta) + 0.04026470914117*sin(3*theta) + 0.00417856305776*sin(4*theta) -0.00160690876229*sin(5*theta) + 0.00002885309995*sin(6*theta) + 0.00010848081699*sin(7*theta) + 0.00006638680513*sin(8*theta) + 0.00002930810305*sin(9*theta) -0.00000966641232*sin(10*theta);
  
end