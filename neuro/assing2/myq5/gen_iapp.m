function [ans] = gen_iapp(stimulus,t_max,dt,lambda,io,tou, tou_s,m,w)


 %stimulus = zeros(m,100);
 i_app = zeros(m,100);
 for k = 1:100
     tm = [];
     for i = 1:m
        if length(tm) ~= 0
            for j  = 1:length(tm)
                dum = (i*dt - tm(j));
                i_app(i,k) = i_app(i,k) + io*w(k)*(exp(-1*dum/tou) - exp (-1*dum/tou_s));
            end
        end
        if stimulus(i,k) == 1
            tm = cat(2,tm,[i*dt]);
        end
     end
 end
 
 ans = sum(transpose(i_app));
   
     
end

