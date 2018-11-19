function [ Y ] = FFT( x )
z = length(x);
m= log2(z);
p = ceil(m)-1;
Y = x;
N = 2^p;
N2=N/2; 
WW = exp(-pi*j/N2);  
J = 0 : N2-1;  
W=WW.^J;
for L = 1 : p-1
    u=Y(:,[1:N2]);
    v=Y(:,[N2+1:N]);
    t=u+v;
    S=W.*(u-v);
    Y=[t ; S];
    U=W(:,1:2:N2);
    W=[U ;U];
    N=N2;
    N2=N2/2;
 end;
u=Y(:,1);
v=Y(:,2);
Y=[u+v;u-v];
end

