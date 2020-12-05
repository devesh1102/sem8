clear
neuron = ["Rs","Ib","Ch"];
[u_in,v_in] = steadystate();
for k = 1:3
    [c,gl,el,vt,del_T,a,tw,b,vr] = getvalue(k);
    dt = 0.1 * 10^(-3);
    t_max= 500*10^(-3);
    iapp =[ 250* 10^(-12), 350* 10^(-12), 450* 10^(-12)];
    m = t_max/dt;
    V = zeros(m,3);
    U = zeros(m,3);
    V(1,:) = v_in(k);
    U(1,:) = u_in(k);
    
    for i = 1:3
        for j  = 2:m
            V(j,i) = V(j-1,i) + (gl*(del_T*exp((V(j-1,i)-vt)/del_T)) - gl*(V(j-1,i)-el) - U(j-1,i) + iapp(i))*(dt/c);
            U(j,i) =  U(j-1,i) +(a*(V(j-1,i)- el) - U(j-1,i))*(dt/tw);
            if(V(j-1,i)==0) 
                V(j,i) = vr;
                U(j,i) = U(j-1,i) + b;
            end
            if(V(j,i)>=0) 
                V(j,i) = 0; 
            end
        end
    end
    x = zeros(1,m);
    for i = 2:m
        x(i) = x(i-1) +dt;
    end
    figure(k)
    subplot(3,1,1)
    plot(x,V(:,1))
    title(["Neuron "+neuron(k)+" I_{app} = 250pA"])
    xlabel('Time(in s)') 
    ylabel('Voltage (in V)') 

    subplot(3,1,2)
    plot(x,V(:,2))
    title(["Neuron "+neuron(k)+" I_{app} = 350pA"])
    xlabel('Time(in s)') 
    ylabel('Voltage (in V)') 

    subplot(3,1,3)
    plot(x,V(:,3))
    title(["Neuron "+neuron(k)+" I_{app} = 450pA"])  
    xlabel('Time(in s)') 
    ylabel('Voltage (in V)') 
end