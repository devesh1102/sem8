function [out] = runge2order(pre,pre_i,curr_i)
c=300*10^(-12);%F
gl =30*10^(-9);%S
vt =20*10^(-3);%v
el =-1*70*10^(-3);
del_t = 0.1*10^(-3);
alpha= 0.1;
t_max = 500*10^(-3);

a1 =0.5;
a2 = 0.5;
k1 = (-1*gl*(pre -el) + pre_i)/c;
k2 = (-1*gl*(pre+(k1*del_t) -el) + curr_i)/c;
p= pre + (a1*k1 + a2*k2)*del_t;
p(p>=vt) = el;
out = p
end

