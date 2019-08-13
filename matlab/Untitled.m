dec_x = 5e-4;
x = 0:dec_x:0.0152;
dec_t = 0.005;
t = 0:dec_t:300;
%u = 75+2500*(x-0.0152);
u = ones(1,length(x))*37.0;
du = zeros(1,length(x));
for index_t = 1:length(t)
    for index_x = 1:length(x)
        ut = u(index_x);
        if index_x == 1
            up = 37;
            un = u(index_x+1);
        elseif index_x == length(x)
            up = u(index_x-1);
            un = 75;
        else
            up = u(index_x-1);
            un = u(index_x+1);
        end
        du(index_x) = alpha(x(index_x))*(up+un-2*ut)/(dec_x*dec_x);
    end
    u = u+du.*dec_t;
end