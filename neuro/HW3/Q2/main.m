N = 500;

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
w=3000;

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
end

%% Excitatory vs. Inhibitory spikes
interval = round(10e-3/dt);
Re = zeros(1,length(t));
Ri = zeros(1,length(t));
L = length(t)-interval;

for k = 1:L
    for j = 1:Ne
        count = 0;
        for m = 1:length(spike_time{j})
            if(spike_time{j}(m)>=t(k) && spike_time{j}(m) < t(k)+interval*dt )
                count = count+1;
            end
            if(spike_time{j}(m)>=t(k)+interval*dt)
                break
            end
         end
         Re(k) = Re(k)+count;
    end 
    for j = Ne+1:N
        count = 0;
        for m = 1:length(spike_time{j})
            if(spike_time{j}(m)>=t(k) && spike_time{j}(m) < t(k)+interval*dt )
                count = count+1;
            end
            if(spike_time{j}(m)>=t(k)+interval*dt)
                break
            end
         end
         Ri(k) = Ri(k)+count;
    end 
end

%% Plotting Results
figure(1)
hold all;
for i = 1:Ne
  scatter(spike_time{i}*1e3,ones(1,length(spike_time{i}))*i,'fill','green')
end

for i = Ne+1:N
  scatter(spike_time{i}*1e3,ones(1,length(spike_time{i}))*i,'fill','red')
end
hold off;
xlabel("Time (in milliseconds)")
ylabel("Neuron")
title("Raster plot of Spikes for N = 500 neurons")


figure(2)
plot(t(1:L)*1e3,Re(1:L),t(1:L)*1e3,Ri(1:L));
legend("Re","Ri")
xlabel("Time (in milliseconds)")
ylabel("Spikes issued")
title('$$R_e(t)$$ and $$R_i(t)$$ vs Time','interpreter','latex')