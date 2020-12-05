clear;
close all;
t_max = 0.5;
 dt = 0.1*10^-3;
 lambda = 10;
 io = 1*10^-12;
 we = 500;
 tou = 15*10^-3;
 tou_s = tou/4;
 m = t_max/dt;
 %iapp = ones(m,1).*250* 10^(-12);
 [stimulus,iapp] = gen_iapp(t_max,dt,lambda,io,we,tou, tou_s,m);
    [u_in,v_in] = steadystate();
    [c,gl,el,vt,del_T,a,tw,b,vr] = getvalue(1);
    %iapp =[ 250* 10^(-12), 350* 10^(-12), 450* 10^(-12)];
    
    V = zeros(m,1);
    U = zeros(m,1);
    V(1,:) = v_in(1);
    U(1,:) = u_in(1);
    i = 1;
    for j  = 2:m
        V(j,i) = V(j-1,i) + (gl*(del_T*exp((V(j-1,i)-vt)/del_T)) - gl*(V(j-1,i)-el) - U(j-1,i) + iapp(j))*(dt/c);
        U(j,i) =  U(j-1,i) +(a*(V(j-1,i)- el) - U(j-1,i))*(dt/tw);
        if(V(j-1,i)==0) 
            V(j,i) = vr;
            U(j,i) = U(j-1,i) + b;
        end
        if(V(j,i)>=0) 
            V(j,i) = 0; 
        end
    end
    
    x = zeros(1,m);
    for i = 2:m
        x(i) = x(i-1) +dt;
    end
    figure(1)
    plot(x,V(:,1))
    title(["Neuron "+"Rs"])
    xlabel('Time(in s)') 
    ylabel('Voltage (in V)') 
    figure(2)
    plot(x,stimulus)
    title("Stimulus")
    xlabel('Time(in s)') 
    figure(3)
    subplot(2,1,1)
    plot(x,V(:,1))
    title(["Voltage"])
    xlabel('Time(in s)') 
    ylabel('Voltage (in V)') 

    subplot(2,1,2)
  % figure(3)
    plot(x,iapp(:,1))
    title(["input current"])
    xlabel('Time(in s)') 
    ylabel('iapp (in A)') 

 
 
 
 