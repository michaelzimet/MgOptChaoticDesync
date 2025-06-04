function fp = Zp_HH(theta)

global omega M B topt uopt Zd

 % HH PRC
     fp = -0.05019405489425*sin(theta)  + 2*0.07035076076555*sin(2*theta)  + 3*0.01118677193793*sin(3*theta) - 4*0.01271267929416*sin(4*theta) - 5*0.00177258077023*sin(5*theta) - 6*0.00034999803453*sin(6*theta) - 7*0.00028740492486*sin(7*theta) - 8*0.00014014870722*sin(8*theta) - 9*0.00004997463194*sin(9*theta) - 10*0.00000760582414*sin(10*theta) -0.06137283848145*cos(theta)  -2*0.03357254573048*cos(2*theta) + 3*0.04026470914117*cos(3*theta) + 4*0.00417856305776*cos(4*theta) -5*0.00160690876229*cos(5*theta) + 6*0.00002885309995*cos(6*theta) + 7*0.00010848081699*cos(7*theta) + 8*0.00006638680513*cos(8*theta) + 9*0.00002930810305*cos(9*theta) -10*0.00000966641232*cos(10*theta);
  
end