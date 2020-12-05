%% Specifying all constants in SI units

N=5;

C=300e-12;
gL=30e-9;
V_T=20e-3;
E_L=-70e-3;
Rp=2e-3;

Io=1e-12;
Ip=50e-9;
tau=15e-3;
tau_s=tau/4;
w=3000;

%% Specifying the network
%a->1 b->2 c->3 d->4 e->5

for i = 1:N
	fanout{i} = [];
	weight{i} = [];
	delay{i} = [];
end

fanout{2} = [1,5];
weight{2} = [3000,3000];
delay{2} = [1e-3,8e-3];

fanout{3} = [1,5];
weight{3} = [3000,3000];
delay{3} = [5e-3,5e-3];

fanout{4} = [1,5];
weight{4} = [3000,3000];
delay{4} = [9e-3,1e-3];

%% Initialising cell arrays to store spiking information

for i = 1:N
	spike_time{i} = [];
	arrival_time{i} = [];
	strength{i} = [];
	pre_neuron{i} = [];
end

%% Specifying total duration and time step

tf = 100e-3;   % final time(stop time).
dt = 0.01e-3;  % time step(delta t).
t=0:dt:tf;

%% Initialising Membrane Voltage, Applied Current and Synaptic Current

V=zeros(N,length(t));
Iapp=zeros(N,length(t));
Isyn=zeros(N,length(t));

V(:,1)=E_L; % at t = 1, all neurons are resting (V = E_L)

for i=1:length(t)
    if(t(i)>=7e-3 && t(i)<8e-3)
        Iapp(2,i)=Ip;
    end
    if(t(i)>=3e-3 && t(i)<4e-3)
        Iapp(3,i)=Ip;
    end
    if(t(i)>=0e-3 && t(i)<1e-3)
        Iapp(4,i)=Ip;
    end
end

%% Voltage dynamics for neuron 2 3 4

for j=2:4
    count = 0;
    for k=1:length(t)-1
    
        if V(j,k)>= V_T %spike occured at t(k)

            V(j,k+1)=E_L; %reset membrane potential to E_L
            
            %update spike information cell arrrays for the jth neuron
            spike_time{j}=[spike_time{j},t(k)];

            count=round(Rp/dt); %for 2ms (20 x dt)

            post_neuron = fanout{j}; 

            %update post-neuron data
            for i=1:length(post_neuron)
                arrival_time{post_neuron(i)}=[arrival_time{post_neuron(i)},t(k)+delay{j}(i)];
                pre_neuron{post_neuron(i)}=[pre_neuron{post_neuron(i)},j];
                strength{post_neuron(i)}=[strength{post_neuron(i)}, weight{j}(i)];
            end

        else
            if count~=0
                V(j,k+1)=E_L; %refractory period
                count=count-1;
            else
            	f=-gL*V(j,k)/C + gL*E_L/C + Iapp(j,k)/C + Isyn(j,k)/C;
            	V(j,k+1) = V(j,k) + dt*f;
            end
        end
    end
end

%% Calculate the current flowing into the post-synaptic neurons 1 5

for i = 1:4:5
    for j = 1:length(arrival_time{i}) 
        I_temp = zeros(1,length(t));

        for k = round(arrival_time{i}(j)/dt):length(t)
            %current corresponding to jth spike for ith neuron
            I_temp(k) = Io*w*(exp(-(t(k)-arrival_time{i}(j))/tau) - exp(-(t(k)-arrival_time{i}(j))/tau_s));
        end

        Isyn(i,:) = Isyn(i,:) + I_temp;
    end
end

%% Voltage dynamics for neuron 1 5

for j=1:4:5
    count = 0;
    for k=1:length(t)-1
    
        if V(j,k)>= V_T %spike occured at t(k)

            V(j,k+1)=E_L; %reset membrane potential to E_L
            
            %update spike information cell arrrays for the jth neuron
            spike_time{j}=[spike_time{j},t(k)];

            count=round(Rp/dt); %for 2ms 

        else
            if count~=0
                V(j,k+1)=E_L;%refractory period
                count=count-1;
            else
                f=-gL*V(j,k)/C + gL*E_L/C + Iapp(j,k)/C + Isyn(j,k)/C;
                V(j,k+1) = V(j,k) + dt*f;
            end
        end
    end
end

%% Plotting synaptic current and membrane voltages

figure(1)

subplot(5,1,1)
plot(t*1000,V(1,:)*1000,"r","LineWidth",2);
title("Neuron A")
xlabel("Time (in milliseconds)")
ylabel("Voltage (in mV)")

subplot(5,1,2)
plot(t*1000,V(2,:)*1000,"g","LineWidth",2);
title("Neuron B")
xlabel("Time (in milliseconds)")
ylabel("Voltage (in mV)")

subplot(5,1,3)
plot(t*1000,V(3,:)*1000,"b","LineWidth",2);
title("Neuron C")
xlabel("Time (in milliseconds)")
ylabel("Voltage (in mV)")


subplot(5,1,4)
plot(t*1000,V(4,:)*1000,"k","LineWidth",2);
title("Neuron D")
xlabel("Time (in milliseconds)")
ylabel("Voltage (in mV)")

subplot(5,1,5)
plot(t*1000,V(5,:)*1000,"y","LineWidth",2);
title("Neuron E")
xlabel("Time (in milliseconds)")
ylabel("Voltage (in mV)")

figure(2)

subplot(2,1,1)
plot(t*1000,Isyn(1,:)*1e9,"r","LineWidth",2);
title("Neuron A")
xlabel("Time (in milliseconds)")
ylabel("Current (in nA)")

subplot(2,1,2)
plot(t*1000,Isyn(5,:)*1e9,"g","LineWidth",2);
title("Neuron E")
xlabel("Time (in milliseconds)")
ylabel("Current (in nA)")

