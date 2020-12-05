    function [new_w,del_tk] = training2(w,dt,stimulus,V)

     tou = 15*10^-3;
     tou_s = tou/4;
    del_tk = [];

    [dum,t_max] = max(V);
    new_w = w;

    for i = 1:100
        for j = t_max-1:-1:1
            if stimulus(j,i) == 1
                dt_k = (t_max - j)*dt ;
                del_tk = cat(1,del_tk,dt_k);
                new_w(i) = new_w(i)  + w(i)*(exp(-1*dt_k/tou) - exp(-1*dt_k/tou_s));
                new_w(i) = min(new_w(i),500);
                break;
            end

        end
        %if new_w(i) == w(i)
       %     del_tk = cat(1,del_tk,0);
       % end

    end

    end

