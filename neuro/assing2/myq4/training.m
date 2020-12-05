function [new_w,del_tk]= training(w,dt,stimulus,V)

 tou = 15*10^-3;
 tou_s = tou/4;
del_tk = [];

peaks = find(V==0);
new_w = w;
    figure(4)
    title(["∆wk vs ∆tk"])
    xlabel('delta Weights') 
    ylabel('delta tk') 
    hold on
     
for k = 1:length(peaks)
    t_max = peaks(k);
    del_w = [];
    del_tk = [];
    for i = 1:100
        for j = t_max-1:-1:1
            if stimulus(j,i) == 1
                dt_k = (t_max - j)*dt ;
                del_tk = cat(1,del_tk,dt_k);
                new_w(i) = new_w(i)  - w(i)*(exp(-1*dt_k/tou) - exp(-1*dt_k/tou_s));
                new_w(i) = max(new_w(i),10);
                del_w = cat(1,del_w,(new_w(i) - w(i)));
                w(i) = new_w(i);
                break;
            end
        end
        
    end
   % if mod(k,2) ==0
        scatter(del_w,del_tk,'filled') 
    %end
end
legend("1","2","3","4","5","6")
 hold off
end

