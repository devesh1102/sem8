function [stimulus,ans] = gen_iapp(t_max,dt,lambda,io,we,tou, tou_s,m)
 threshold = lambda*dt;
 dum = rand(t_max/dt,1);
 stimulus =logical(dum<threshold);

 i_app = zeros(m,1);
 tm = [];
 for i = 1:m
    if length(tm) ~= 0
        for j  = 1:length(tm)
            dum = (i*dt - tm(j));
            i_app(i) = i_app(i) + io*we*(exp(-1*dum/tou) - exp (-1*dum/tou_s));
        end
    end
    if stimulus(i) == 1
        tm = cat(2,tm,[i*dt]);
    end
 end
 ans = i_app;
   
     
end

