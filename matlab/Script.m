hl = 8.31;
hr = 98;

del_x = 1e-6;
del_t = 1e-2;
x4 = del_x:del_x:0.005-del_x;
x43 = 0.005;
x3 = 0.005+del_x:del_x:0.0086-del_x;
x32 = 0.0086;
x2 = 0.0086+del_x:del_x:0.0146-del_x;
x21 = 0.0146;
x1 = 0.0146+del_x:del_x:0.0152-del_x;
x0 = 0;
xend = 0.0152;
xp = [x0,x43,x32,x21,xend];
%t = 0:del_t:300;
N = 1521;
u1 = ones(N,1)*37.0;
u = ones(N,1)*37.0;
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

u_0 = 37;
u_end = 75;
%R_n * u_n+1 = R_p * u_n + b


Rp(1,1) = - k4/(2*del_x) - hl/2 + del_x*rho4*c4/del_t;
Rp(1,2) = k4/(2*del_x);

Rn(1,1) = k4/(2*del_x) + hl/2 + del_x*rho4*c4/del_t ;
Rn(1,2) = -k4/(2*del_x);

delta(1) = hl*u_0;

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
    index = index + 1;%分段位置的矩阵参�?
    % (u_{i+1} - u_{i})*k_{next} = (u_{i} - u_{i-1})*k_{pre}
    
    if region == 4
        Rp(index,index-1) = k1/(2*del_x);
        Rp(index,index) = - k1/(2*del_x) - hr/2 + rho1*c1*del_x/del_t;
        Rn(index,index) = del_x*rho1*c1/del_t + k1/(2*del_x) + hr/2;
        Rn(index,index-1) = -k1/(2*del_x);
        delta(N) = hr*u_end;
    else
        kn = k(region+1);
        kp = k(region);
        cm = 0.5*(c(region)+c(region+1));
        rhom = 0.5*(rho(region)+rho(region+1));
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


%[L,U,P] = lu(Rn);
%P*Rn = L*U
A = Rn\Rp;
b = Rn\delta;
u = (eye(N)-A)\b;
%for time = 1:del_t:3600
%    u = A*u + b;
%end
%%
x = 0:del_x:xend;
plot(x,u);

%%
u_t = ones(N,1)*37.0;
u_time = zeros(N,55);
cap_point =0;
i = 1;
for time = 0:del_t:5401
    u_t = A*u_t + b;
    if time>cap_point
        u_time(:,i) = u_t;
        cap_point = cap_point+100;
        i = i +1;
    end
end
%%
im = cell(1,55);
for i = 1:55
    h = figure();
    plot(x,u_time(:,i));
    xlim([0,0.0152]);
    ylim([37,75]);
    framenow =getframe();
    close(h);
    im{i} = frame2im(framenow);
end
filename = 'Animated.gif'; 
%%
for i = 1:55
    [FIGURE,map]= rgb2ind(im{i},128);
    if i == 1
        imwrite(FIGURE,map,filename,'gif','LoopCount',Inf,'DelayTime',0.5);
    else
        imwrite(FIGURE,map,filename,'gif','WriteMode','append','DelayTime',0.2);
    end
end