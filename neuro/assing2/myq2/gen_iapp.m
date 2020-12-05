function [stimulus,ans] = gen_iapp(t_max,dt,lambda,io,tou, tou_s,m,wo,sig_w)
w(1:100,1)=(wo+sig_w*randn(100,1)); 


 i_app = zeros(m,100);
 for k = 1:100
     tm = [];
     threshold = lambda*dt;
     dum = rand(t_max/dt,1);
     stimulus =logical(dum<threshold);
     for i = 1:m
        if length(tm) ~= 0
            for j  = 1:length(tm)
                dum = (i*dt - tm(j));
                i_app(i,k) = i_app(i,k) + io*w(k)*(exp(-1*dum/tou) - exp (-1*dum/tou_s));
            end
        end
        if stimulus(i) == 1
            tm = cat(2,tm,[i*dt]);
        end
     end
 end
 
 ans = sum(transpose(i_app));
   
     
end

