clear
c=300*10^(-12);%F
gl =30*10^(-9);%S
vt =20*10^(-3);%v
el =-1*70*10^(-3);
del_t = 0.1*10^(-3);
alpha= 0.1;
t_max = 500*10^(-3);
m = t_max/del_t;
n = 10;
ic = gl*(vt - el);
i_app = zeros(n,m);
%%input i applied
for i = 1:n
    for j = 1:m
        i_app(i,j) = (1 + i*alpha)*ic;
    end
end
%%start
potential = zeros(n,m);
potential(:,1) = el;

for i = 2:m
    pre = potential(:,i-1);
    a1 =0.5;
    a2 = 0.5;
    k1 = (-1*gl*(pre -el) + i_app(:,i-1))/c;
    k2 = (-1*gl*(pre +(k1*del_t) -el) + i_app(:,i))/c;
    p= pre + (a1*k1 + a2*k2)*del_t;
    p(p>=vt) = el;
    potential(:,i) = p;
end
x = zeros(1,m);
for i = 2:m
    x(i) = x(i-1) +del_t;
end
%%plot
figure(1)
title("Membrane Potential")

subplot(4,1,1)
plot(x,potential(2,:))
xlabel('Time(in s)') 
ylabel('Voltage (in V)') 
title(' 2nd Neuron Membrane Potential')  

subplot(4,1,2)
plot(x,potential(4,:))
title('4th Neuron Membrane Potential') 
xlabel('Time(in s)') 
ylabel('Voltage (in V)') 

subplot(4,1,3)
plot(x,potential(6,:))
title(' 6th Neuron Membrane Potential') 
xlabel('Time(in s)') 
ylabel('Voltage (in V)') 

subplot(4,1,4)
plot(x,potential(8,:))
title(' 8th Neuron Membrane Potential')  
xlabel('Time(in s)') 
ylabel('Voltage (in V)') 

%%avgeraging
dum = potential==el;
cycle = (sum(transpose(dum)) );
period = t_max./cycle ;
i = i_app(:,1);
figure(2)
plot(i,period)
title("Average time interval wrt  Iapp")  
xlabel(' Current (in A)')
ylabel('Time in (s)')





