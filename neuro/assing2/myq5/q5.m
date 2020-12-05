close all;
clear;
t_max = 0.5;
dt = 0.1*10^-3;
lambda = 1;
io = 1*10^-12;
tou = 15*10^-3;
tou_s = tou/4;
m = t_max/dt;
wo = 200;
sig_w = 20;
w1(1:100,1)=(wo+sig_w*randn(100,1)); 
w2(1:100,1)=(wo+sig_w*randn(100,1)); 
w1 = w2;
w1_d = w1;
stimulus1 = zeros(m,100);
stimulus2 = zeros(m,100);
stimulus1_d = zeros(m,100);
stimulus2_d = zeros(m,100);
 for k = 1:100
     threshold = lambda*dt;
     dum1 = rand(t_max/dt,1);
     dum2 = rand(t_max/dt,1);
     stimulus1(:,k) =logical(dum1<threshold);
     stimulus2(:,k) =logical(dum2<threshold);
     stimulus1_d = stimulus1(:,k);
     stimulus2_d = stimulus2(:,k);
 end

[pre_iapp1] = gen_iapp(stimulus1,t_max,dt,lambda,io,tou, tou_s,m,w1);
[V1,x1] = aef(pre_iapp1);
[pre_iapp2] = gen_iapp(stimulus2,t_max,dt,lambda,io,tou, tou_s,m,w2);
[V2,x2] = aef(pre_iapp2);
V1_d = V1;
V2_d = V2;
    figure(1)
    plot(x1,V1(:,1))
    title(["Part a S1"])
    xlabel('Time(in s)') 
    ylabel('Voltage (in V)')
        figure(2)
    plot(x2,V2(:,1))
    title(["Part a S2"])
    xlabel('Time(in s)') 
    ylabel('Voltage (in V)') 
%%%%%%%end part a(weights same)


%%%%%%start partb
itr = 1;
pre_V = V2;
pre_w = w2;
while(1)
    while(1)
        [post_w ,del_tk] = training(w2,dt,stimulus2,V2);
        [post_iapp] = gen_iapp(stimulus2,t_max,dt,lambda,io,tou, tou_s,m,post_w);
        [post_V,x] = aef(post_iapp);
        w2 = post_w;
        V2 = post_V;
        if max(post_V) ~= 0
            break
        end

        itr = itr +1;
    end
    [pre_iapp_c] = gen_iapp(stimulus1,t_max,dt,lambda,io,tou, tou_s,m,post_w);
    [V1_c,x1] = aef(pre_iapp_c);
    if max(V1_c) >= 0
        break
    end
    V = V1_c;
    w = post_w;
    while(1)
        [post_w,del_tk] = training2(w,dt,stimulus1,V);
        [post_iapp] = gen_iapp(stimulus,t_max,dt,lambda,io,tou, tou_s,m,post_w);
        [post_V,x] = aef(post_iapp);
        del_w = post_w - pre_w;
        del_w = nonzeros(del_w);
        if max(post_V) == 0
            break
        end
        w = post_w;
        V = post_V;
        itr = itr +1
end
w2 = post_w;

end
w2_partb =  post_w;
V2_partb =  post_V;
figure(3)
plot(x1,V1(:,1))
title(["Part b S1"])
xlabel('Time(in s)') 
ylabel('Voltage (in V)')
figure(4)
plot(x2,post_V(:,1))
title(["Part b S2"])
xlabel('Time(in s)') 
ylabel('Voltage (in V)') 
    
  %%%%%part c

figure(5)
plot(x1,V1_c(:,1))
title(["Part c S1"])
xlabel('Time(in s)') 
ylabel('Voltage (in V)')
     y = [1:100] ;
    figure(6)
    plot(y,w2_partb )
    title(["Weights part b "])

    xlabel('Weights') 
    ylabel('Value of weights') 



    %%%%%partd

itr = 1;
pre_V = V1_d;
pre_w = w1_d;
while(1)
    while(1)
        [post_w ,del_tk] = training(w1_d,dt,stimulus1,V1_d);
        [post_iapp] = gen_iapp(stimulus1,t_max,dt,lambda,io,tou, tou_s,m,post_w);
        [post_V,x] = aef(post_iapp);
        w2 = post_w;
        V2 = post_V;
        if max(post_V) ~= 0
            break
        end

        itr = itr +1;
    end
    [pre_iapp_c] = gen_iapp(stimulus2,t_max,dt,lambda,io,tou, tou_s,m,post_w);
    [V2_c,x1] = aef(pre_iapp_c);
    if max(V2_c) >= 0
        break
    end
    V = V2_c;
    w = post_w;
    while(1)
        [post_w,del_tk] = training2(w,dt,stimulus2,V);
        [post_iapp] = gen_iapp(stimulus,t_max,dt,lambda,io,tou, tou_s,m,post_w);
        [post_V,x] = aef(post_iapp);
        del_w = post_w - pre_w;
        del_w = nonzeros(del_w);
        if max(post_V) == 0
            break
        end
        w = post_w;
        V = post_V;
        itr = itr +1
end
w2 = post_w;

end
w2_partd =  post_w;
V2_partd=  post_V;

figure(7)
plot(x1,post_V(:,1))
title(["Part d S1"])
xlabel('Time(in s)') 
ylabel('Voltage (in V)')
figure(8)
plot(x2,V2_d(:,1))
title(["Part d S2"])
xlabel('Time(in s)') 
ylabel('Voltage (in V)') 


    figure(9)
    plot(y,w2_partd )
    title(["Weights part d "])

    xlabel('Weights') 
    ylabel('Value of weights') 

