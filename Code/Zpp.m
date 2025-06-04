function fpp = Zpp(theta)

global omega M B topt uopt Zd

    fpp = - Zd*sin(theta);
    %fpp = Zd*cos(theta);

    % HH PRC
    %fpp = -0.0501941*cos(theta) + 0.281403*cos(2*theta) + 0.100681*cos(3*theta) - 0.203403*cos(4*theta) - 0.0443145*cos(5*theta) - 0.0125999*cos(6*theta) - 0.0140828*cos(7*theta) - 0.00896952*cos(8*theta) - 0.00404795*cos(9*theta) - 0.000760582*cos(10*theta) + 0.0613728*sin(theta) + 0.13429*sin(2*theta) - 0.362382*sin(3*theta) - 0.066857*sin(4*theta) + 0.0401727*sin(5*theta) - 0.00103871*sin(6*theta) - 0.00531556*sin(7*theta) - 0.00424876*sin(8*theta) - 0.00237396*sin(9*theta) + 0.000966641*sin(10*theta);
    


    %Reduced HH
    % fpp = -0.089329808613738*cos(theta) +  2*2*0.029336277581269*cos(2*theta) +   3*3*0.052519571534176*cos(3*theta) +   4*4*0.019654561708073*cos(4*theta) +   5*5*0.005894856122472*cos(5*theta) +   6*6*0.002307278036320*cos(6*theta) +   7*7*0.001269597435905*cos(7*theta) + 8*8*8.677750627462653e-04*cos(8*theta) + 9*9*6.796573029442086e-04*cos(9*theta) + 10*10*5.708606803248151e-04*cos(10*theta) + 0.054110977478019*sin(theta) + 2*2*0.092623025979316*sin(2*theta) +  3*3*0.008669621336474*sin(3*theta) +  4*4*-0.012441784784809*sin(4*theta) + 5*5*-0.008370570886685*sin(5*theta) + 6*6*-0.004713888729360*sin(6*theta) + 7*7*-0.002994960037589*sin(7*theta) + 8*8*-0.002128322832094*sin(8*theta) + 9*9*-0.001595373362856*sin(9*theta) + 10*10*-0.001204867801304*sin(10*theta);

end