function res = getUtbyL2(L2)
u_0 = 37;
u_end = 65;
hl = 8.319346761353728;
hr = 1.006260000000000e+02;
total_time = 3300;
del_x = 1e-4;
del_t = 0.01;
L1 = 0.6/1000;
%L2 = 0.6/1000;
L3 = 3.6/1000;
L4 = 5.5/1000;
x43 = L4;

x32 = L4+L3;

x21 = L4+L3+L2;

x0 = 0;
xend = L4+L3+L2+L1;
xp = [x0,x43,x32,x21,xend];
%t = 0:del_t:300;
N = round(xend/del_x+1);
Rp = zeros(N,N);
Rn = zeros(N,N);
delta = zeros(N,1);
r4 = del_t*2.361075976051944e-05/(2*del_x^2);
r3 = del_t*3.441935316092042e-07/(2*del_x^2);
r2 = del_t*2.043973041652856e-07/(2*del_x^2);
r1 = del_t*1.984991527475188e-07/(2*del_x^2);
rs = [r1,r2,r3,r4];

k4 = 0.028;
k3 = 0.045;
k2 = 0.37;
k1 = 0.082;
k = [k4,k3,k2,k1];

rho4 = 1.18;
rho3 = 74.2;
rho2 = 862;
rho1 = 300;
rho = [rho4,rho3,rho2,rho1];

c4 = 1055;
c3 = 1726;
c2 = 2100;
c1 = 1377;
c = [c4,c3,c2,c1];


%R_n * u_n+1 = R_p * u_n + b


%Rp(1,1) = k4/del_x + hl;
%Rp(1,2) = -k4/(del_x);

%Rn(1,1) = -hl-k4/del_x;
%Rn(1,2) = -k4/(del_x);

Rp(1,1) = - k4/(2*del_x^2) - hl/(2*del_x) + rho4*c4/del_t;
Rp(1,2) = k4/(2*del_x^2);

Rn(1,1) = k4/(2*del_x^2) + hl/(2*del_x) +  rho4*c4/del_t;
Rn(1,2) = -k4/(2*del_x^2);

delta(1) = hl*u_0/del_x;



for region = 1:4
    a = round(2 + xp(region)/del_x);
    b = round(xp(region+1)/del_x);
    r = rs(region);
    for index = a:b

        Rp(index,index-1) = r;   
        Rp(index,index) = 1-2*r;
        Rp(index,index+1) = r;
    
        Rn(index,index-1) = -r;
        Rn(index,index) = 1 + 2*r;
        Rn(index,index+1) = -r ;
    end
    index = index + 1;
    % (u_{i+1} - u_{i})*k_{next} = (u_{i} - u_{i-1})*k_{pre}
    
    if region == 4
        Rp(index,index-1) = k1/(2*del_x^2);
        Rp(index,index) = - k1/(2*del_x^2) - hr/(2*del_x) + rho1*c1/del_t;
        Rn(index,index) = rho1*c1/del_t + k1/(2*del_x^2) + hr/(2*del_x);
        Rn(index,index-1) = -k1/(2*del_x^2);
        delta(N) = hr*u_end/(del_x);
    else
        kn = k(region+1);
        kp = k(region);
        alpha____ = 0.5;
        beta____ = 1-alpha____;
        cm = alpha____*c(region)+beta____*c(region+1);
        rhom = alpha____*rho(region)+beta____*rho(region+1);
        rn = del_t*kn/(rhom*cm*2*del_x^2);
        rp = del_t*kp/(rhom*cm*2*del_x^2);
        Rp(index,index-1) = rp;   
        Rp(index,index) = 1-rn-rp;
        Rp(index,index+1) = rn;

        Rn(index,index-1) = -rp;
        Rn(index,index) = 1+rn+rp;
        Rn(index,index+1) = -rn;
    end
end



    A = Rn\Rp;
    b = Rn\delta;
    u_s = (eye(N)-A)\b;%²»¶¯µã
    u_t = ones(N,1)*37.0;
    u_t = A^(100*total_time)*(u_t - u_s) + u_s;
    res = u_t(1);
    
end