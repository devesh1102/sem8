%izhikevich paper - neuron code
clear all; close all;
nI=5; %I/I_crit;
% v' equation  parameters for Izhikevich
p=0.04;
q=5;
r=140;

% u' parameters
a=0.02; 
b=0.24; 
% reset parameter
c=-65;
d=8;
% c=-50;
% d=2;
Vt=30; 

N=1; %number of current levels

%finding parabola origin
v1=(-q+sqrt(q.^2-4*p*r))./2/p;
v2=(-q-sqrt(q.^2-4*p*r))./2/p;
v0=0.5*(v1+v2); % origin of v'
u0=p.*v0.^2+q.*v0+r; % origin of v'

%steady state
v_steady=(-q+b-sqrt((q-b).^2-4*p*r))./2/p;
u_steady=p.*v_steady.^2+q.*v_steady+r;


%slope match point 
v_match=(b-q)./(2*p); % v_match is where u'is tangent to v' line
I_crit=v_match.*b-(p.*v_match.^2+q.*v_match+r); % critical current is offset of U at v_match for u'and v' lines

% define the (u,v) space
v=[-120:1:50];
u=[u0:1:5];
[UU,VV]=meshgrid(u,v);

% calculating time evolution
T=400000e-3; % total time
del_T=0.01; % discretization
t=[0:del_T:T]; % vector


% use steady state to initialze I, U and V
V=v_steady.*ones(N,length(t)); % initializing the matrix
U=u_steady.*ones(N,length(t));% initializing the matrix
I=nI.*I_crit*ones(N,length(t)); %linearly increasing current above threshold

% generating 3D

for count=1:length(t)-1
    % 4th order RK method for coupled ODE
    k1= p.*(V(:,count)).^2+q.*(V(:,count))+r-U(:,count)+I(:,count);
    l1= a*(b*(V(:,count)-U(:,count)));

    k2= p.*(V(:,count)+del_T*k1./2).^2+q.*(V(:,count)+del_T*k1./2)+r-U(:,count)-+del_T*l1./2+I(:,count);
    l2= a*(b*(V(:,count)+del_T*k1./2-U(:,count)-+del_T*l1./2));

    k3= p.*(V(:,count)+del_T*k2./2).^2+q.*(V(:,count)+del_T*k2./2)+r-U(:,count)-+del_T*l2./2+I(:,count);
    l3= a*(b*(V(:,count)+del_T*k2./2-U(:,count)-+del_T*l2./2));
   
    k4= p.*(V(:,count)+del_T*k3).^2+q.*(V(:,count)+del_T*k3)+r-U(:,count)-+del_T*l3+I(:,count);
    l4= a*(b*(V(:,count)+del_T*k3-U(:,count)-+del_T*l3));

    V(:,count+1)=V(:,count)+(del_T/6)*(k1+2*k2+2*k3+k4);
    U(:,count+1)=U(:,count)+(del_T/6)*(l1+2*l2+2*l3+l4);
    
    %dwhat(count)=d;
    
U(:,count+1)= (U(:,count+1)).*(V(:,count+1)<Vt)+(U(:,count+1)+d).*(V(:,count+1)>Vt); %(U(:,count+1))*(V(:,count+1)>Vt)+
% order is critical as V(:,count+1) should not be changed before U is
% modified.
V(:,count+1)= (V(:,count+1)).*(V(:,count+1)<Vt)+c.*(V(:,count+1)>Vt); % not explicitly issueing spikes

end
figure(1); plot(t,V);
figure(5); plot(v_steady, u_steady, 'ro-'); hold on; plot(v, p.*v.^2+q.*v+r+nI*I_crit, 'r.-'); hold on; plot(v, p.*v.^2+q.*v+r, 'r*-'); hold on;plot(v, b.*v, 'k.-');  
hold on; plot(Vt.*ones(1,length(U)), U, 'r-');hold on; plot(c.*ones(1,length(U)), U, 'k-');plot(V, U, 'b.-'); xlabel('V'); ylabel('U'); title('Trajectory in U,V Space'); grid on; axis([2*v_steady 2*Vt 2*u_steady 2*max(max(U))]);hold off; 
figure(6)
plot(U)
figure(7)
plot(V)