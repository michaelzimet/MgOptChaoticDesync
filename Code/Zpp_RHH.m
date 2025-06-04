function fpp = Zpp_RHH(theta)

global omega M B topt uopt a0 a b
   
   fpp= 0;
   for n = 1:200
       fpp = fpp - n^2 * a(n)*cos(n*theta) - n^2*b(n)*sin(n*theta);
   end

end