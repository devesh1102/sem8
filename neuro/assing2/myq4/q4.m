close all;
clear;
t_max = 0.5;
 dt = 0.1*10^-3;
 lambda = 1;
 io = 1*10^-12;
 tou = 15*10^-3;
 tou_s = tou/4;
 m = t_max/dt;
 wo = 250;
 sig_w = 50;
 w(1:100,1)=(wo+sig_w*randn(100,1)); 
 stimulus = zeros(m,100);
 for k = 1:100
     threshold = lambda*dt;
     dum = rand(t_max/dt,1);
     stimulus(:,k) =logical(dum<threshold);
 end

[pre_iapp] = gen_iapp(stimulus,t_max,dt,lambda,io,tou, tou_s,m,w);
[V,x] = aef(pre_iapp);
itr = 1;
pre_V = V;
pre_w = w;

    %figure(4)
    %title(["∆wk vs ∆tk"])
    %legend("Pre Training","Post training")
    %xlabel('delta Weights') 
    %ylabel('delta tk') 
    
while(1)
    
    [post_w ,del_tk] = training(w,dt,stimulus,V);
    [post_iapp] = gen_iapp(stimulus,t_max,dt,lambda,io,tou, tou_s,m,post_w);
    [post_V,x] = aef(post_iapp);
    %del_w = post_w - pre_w;
    %del_w = nonzeros(del_w);
    %scattter(del_w,del_tk,'filled') 
    if max(post_V) ~= 0
        break
    end
    w = post_w;
    V = post_V;
    itr = itr +1
end
%legend("1","2","3","4","5","6")
%hold off
    figure(1)
    plot(x,pre_V(:,1))
    title(["Pre training Sigma"+sig_w+"; Mean" + wo])
    xlabel('Time(in s)') 
    ylabel('Voltage (in V)') 
    figure(2)
    plot(x,post_V(:,1))
    title(["Post training Sigma"+sig_w+"; Mean" + wo])
    xlabel('Time(in s)') 
    ylabel('Voltage (in V)') 
    
    y = [1:100] ;
    figure(33)
    plot(y,pre_w,y,post_w)
    title(["Post training Sigma"+sig_w+"; Mean" + wo])
    legend("Pre Training","Post training")
    xlabel('Time(in s)') 
    ylabel('Voltage (in V)') 
  

 
 
 
 