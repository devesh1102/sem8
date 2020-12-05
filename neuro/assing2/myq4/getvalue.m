function [c,gl,el,vt,del_t,a,tw,b,vr] = getvalue(i)
Ac = [200,130,200];
c=Ac(i)*10^(-12);% F

Agl = [10,18,10];
gl=Agl(i)*10^(-9);%s

Ael = [-70,-58,-58];
el=Ael(i)*(10^(-3));%V 

Avt =[ -50,-50,-50];
vt=Avt(i)*(10^(-3));%V

Adel_t = [2,2,2];
del_t=Adel_t(i)*10^(-3);%V

Aa = [2,4,2];
a=Aa(i)*10^(-9);%S

Atw = [30,150,120];
tw=Atw(i)*10^(-3);%s

Ab = [0,120,100];
b=Ab(i)*10^(-12);%A

Avr = [-58,-50,-46];
vr=Avr(i)*10^(-3);%V
end

