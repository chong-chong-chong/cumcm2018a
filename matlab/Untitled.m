del_x = 1e-4;
x = 0:del_x:0.0152;
del_t = 0.005;
t = 0:del_t:300;
%u = 75+2500*(x-0.0152);
N = length(x);
u1 = ones(N,1)*37.0;
u = ones(N,1)*37.0;
Rp = zeros(N,N);
Rn = zeros(N,N);
delta = zeros(N,1);
u_0 = 37;
u_end = 75;
%R_n * u_n+1 = R_p * u_n + b
r = del_t*alpha(del_x)/(2*del_x^2);
Rp(1,1) = 1-2*r;
Rp(1,2) = r;

Rn(1,2) = -r;
Rn(1,1) = 1+2*r;


delta(1) = 2*r*u_0;


for index = 2:N-1
    x_h = index*del_x;
    r = del_t*alpha(x_h)/(2*del_x^2);
    Rp(index,index-1) = r;
    Rp(index,index) = 1-2*r;
    Rp(index,index+1) = r;

    Rn(index,index-1) = -r;
    Rn(index,index) = 1+2*r;
    Rn(index,index+1) = -r;
end

Rp(N,N-1) = r;
Rp(N,N) = 1-2*r;

Rn(N,N-1) = 1+2*r;
Rn(N,N-1) = -r;

delta(N) = 2*r*u_end;

A = Rn\Rp;
b = Rn\delta;

for time = 1:del_t:5400
    u = A*u + b;
end