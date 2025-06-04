function fp = Zp_RHH(theta)

global omega M B topt uopt a0 a b

   fp= 0;
   for n = 1:200
       fp = fp - n* a(n)*sin(n*theta)+ n*b(n)*cos(n*theta);
   end

end