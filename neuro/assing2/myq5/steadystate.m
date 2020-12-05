function [U,V] = steadystate()
neuron = ["Rs","Ib","Ch"];
potential_stable = zeros(3,1);
potential_ustable = zeros(3,1);
U_stable = zeros(3,1);
U_ustable = zeros(3,1);
i = 1
    [c,gl,el,vt,del_t,a,tw,b,vr] = getvalue(i);
    syms v
    f =  a*(v-el) +gl*(v-el) - gl*del_t* exp((v-vt)/del_t);
    potential_ustable(i) =vpasolve(f == 0,v,[-0.05 0]);
    potential_stable(i) =vpasolve(f == 0,v,[-0.1 -0.05]);
    %potential = vpa(potential)
    
    U_stable(i) = a*(potential_stable(i) - el);
    U_ustable(i) =  a*(potential_ustable(i) - el);

U = U_stable;
V = potential_stable;
end

