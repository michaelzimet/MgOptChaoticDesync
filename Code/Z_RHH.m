function f = Z_RHH(theta)
    
global omega M B topt uopt a0 a b

   f= a0;
   for n = 1:200
       f = f + a(n)*cos(n*theta)+ b(n)*sin(n*theta);
   end

end