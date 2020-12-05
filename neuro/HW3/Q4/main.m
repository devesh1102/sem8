N = 200;

Ne = round(0.8*N);

Nspike = 25;  %number of neurons receiving poisson stimulus
lambda = 100; %poisson spike arrival rate 100 spikes/s 

%% Specifying total duration and time step

tf = 1000e-3;   % final time(stop time).
dt = 0.2e-3;     % time step(delta t).
t=0:dt:tf;


%% Specifying all constants in SI units

C=300e-12;
gL=30e-9;
V_T=20e-3;
E_L=-70e-3;
Rp= 2e-3;

Io=1e-12;

tau=15e-3;
tau_s=tau/4;
tau_l=20e-3;
w=3000;

Aup = 0.01;
Adown = -0.02;
%% Specifying the network

for i = 1:Ne
     Fanout{i} = randperm(N,N/10);
     Weight{i} = w*ones(1,N/10);
     Delay{i} = randi([1 20],1,N/10)*1e-3;
 end
 
 for i = Ne+1:N
     Fanout{i} = randperm(Ne,N/10);
     Weight{i} = (-w)*ones(1,N/10);
     Delay{i} = ones(1,N/10)*1e-3;
 end
%% Specifying Upstream Neurons

for i = 1:N
    Upstream{i} = [];
end

for i = 1:N
    for j = 1:length(Fanout{i})
        post_neuron = Fanout{i}(j);
        Upstream{post_neuron} = [Upstream{post_neuron},i]; 
    end
end

%% Initialising cell arrays to store spiking information

for i = 1:N
	spike_time{i} = [];
end

 

%% Poisson stimulus : generating Nspike spike trains

threshold = lambda*dt;

spikes = zeros(Nspike,length(t));

for i = 1:Nspike

	spikes(i,:) = logical(rand(length(t),1)<threshold);

end


%% Input current corresponding to the poisson stimulus
Iext = zeros(Nspike,length(t));
for i = 1:Nspike
  for j = 1:length(t)
    I_temp = zeros(1,length(t));
    if(spikes(i,j)==1)
      for k = j:length(t)
        I_temp(k) = Io*w*(exp(-(t(k)-t(j))/tau) - exp(-(t(k)-t(j))/tau_s));
      end
      Iext(i,:) = Iext(i,:) + I_temp;
    end
  end
end

%% Initialising Membrane Voltage, Applied Current and Synaptic Current
V=zeros(N,length(t));
Iapp=zeros(N,length(t));
Isyn=zeros(N,length(t));
total_weight = zeros(1,length(t));
V(:,1)=E_L; %at t = 1, all neurons are resting (V = E_L)
Iapp(1:Nspike,:) = Iext;

%% Voltage and current dynamics for ALL neurons 
count = zeros(N,1);
for k = 1:length(t)
  for j = 1:N
  	
    if(V(j,k)>= V_T) % spike occured at t(k)
    
    	V(j,k+1)=E_L;%reset
      
    	count(j) = round(Rp/dt);%no of cycles the neuron is in refractory period
      
    	spike_time{j}=[spike_time{j},t(k)];
        %only for excitatory neurons
        if(j<=Ne)
            %----------------------STDP---------------
            %---Upstream
            for i = 1:length(Upstream{j})
                %find most recent spike
                pre_neuron = Upstream{j}(i);%index of the pre_neuron
                index = Fanout{pre_neuron} == j; %index of current neuron
                dly = Delay{pre_neuron}(index);
                for m = length(spike_time{pre_neuron}):-1:1  %start loop from the last element
                    if(spike_time{pre_neuron}(m)+dly<t(k))
                        Weight{pre_neuron}(index) = Weight{pre_neuron}(index) + Weight{pre_neuron}(index)*Aup*exp(-(t(k)-(spike_time{pre_neuron}(m)+dly))/tau_l);
                        break;
                    end
                end
            end
            %-----------
            %-Downstream
            for i = 1:length(Fanout{j})
                post_neuron = Fanout{j}(i);%index of the post_neuron
                dly = Delay{j}(i);
                if(~isempty(spike_time{post_neuron}))
                    Weight{j}(i) = Weight{j}(i) + Weight{j}(i)*Adown*exp(-(t(k)-(t(k)+dly-spike_time{post_neuron}(end)))/tau_l);
                end
             end
            %-----------
            %-----------------------------------------
        end
    	%%initiate synaptic current for post-neuron
    	for i=1:length(Fanout{j})
    		I_temp = zeros(1,length(t));
    		t_arrival = t(k) + Delay{j}(i);
        
    		for l = round(t_arrival/dt):length(t)
    			I_temp(l) = Io*Weight{j}(i)*(exp(-(t(l)-t_arrival)/tau) - exp(-(t(l)-t_arrival)/tau_s));
    		end
        
    		Isyn(Fanout{j}(i),:) = Isyn(Fanout{j}(i),:) + I_temp;
        
    	end
        
    else
        if count(j)~=0
            V(j,k+1)=E_L; % refractory period

            count(j)=count(j)-1;

        else
            f = -gL*V(j,k)/C + gL*E_L/C + Iapp(j,k)/C + Isyn(j,k)/C;
            V(j,k+1) = V(j,k) + dt*f;
        end
    end	
  end
  
  for s = 1:Ne
      total_weight(k) = total_weight(k) + sum(Weight{s});
  end

end

%% Scatter plot of spikes vs time
figure(1)
hold all;
for i = 1:Ne
  scatter(spike_time{i},ones(1,length(spike_time{i}))*i,'filled','green')
end

for i = Ne+1:N
  scatter(spike_time{i},ones(1,length(spike_time{i}))*i,'filled','red')
end
hold off;

%% Excitatory vs. Inhibitory spikes
interval = 10e-3;
Re = zeros(1,length(t));
Ri = zeros(1,length(t));
for k = 1:length(t)-round(interval/dt)
    for j = 1:Ne
        count = 0;
        for m = 1:length(spike_time{j})
            if(spike_time{j}(m)>=t(k))
                count = count+1;
            end
            if(spike_time{j}(m)>=t(k)+10e-3)
                break
            end
         end
         Re(k) = Re(k)+count;
    end 
    for j = Ne+1:N
        count = 0;
        for m = 1:length(spike_time{j})
            if(spike_time{j}(m)>=t(k))
                count = count+1;
            end
            if(spike_time{j}(m)>=t(k)+10e-3)
                break
            end
         end
         Ri(k) = Ri(k)+count;
    end 
end

%% Calculating total synpases and plotting average Synaptic weight

total_E_synapses = Ne*(N/10) ;
figure(1)
plot(t*1000,total_weight/total_E_synapses);
xlabel("Time (in milliseconds)")
ylabel("Average Excitatory Synaptic Strength")
title("Average Excitatory Synaptic Strength as a function of time")
