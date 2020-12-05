
neuron = ["Rs","Ib","Ch"];
for i = 1:3
    display(neuron(i))
    [c,gl,el,vt,del_t,a,tw,b,vr] = getvalue(i);
    syms v
    f =  a*(v-el) +gl*(v-el) - gl*del_t* exp((v-vt)/del_t);
    potential = solve(f);
    potential = vpa(potential)
    u = a*(potential - el)
end