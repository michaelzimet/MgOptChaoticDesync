function fpp = Zpp_HH(theta)

global omega M B topt uopt Zd

    % HH PRC
    fpp = -0.0501941*cos(theta) + 0.281403*cos(2*theta) + 0.100681*cos(3*theta) - 0.203403*cos(4*theta) - 0.0443145*cos(5*theta) - 0.0125999*cos(6*theta) - 0.0140828*cos(7*theta) - 0.00896952*cos(8*theta) - 0.00404795*cos(9*theta) - 0.000760582*cos(10*theta) + 0.0613728*sin(theta) + 0.13429*sin(2*theta) - 0.362382*sin(3*theta) - 0.066857*sin(4*theta) + 0.0401727*sin(5*theta) - 0.00103871*sin(6*theta) - 0.00531556*sin(7*theta) - 0.00424876*sin(8*theta) - 0.00237396*sin(9*theta) + 0.000966641*sin(10*theta);

end