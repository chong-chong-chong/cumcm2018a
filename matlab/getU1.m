function u1 = getU1(hl,hr)


    del_x = 1e-4;
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
    N = 153;
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


    Rp(1,1) = - k4/del_x - hl + rho4*c4/del_t;
    Rp(1,2) = k4/del_x;

    Rn(1,1) = rho4*c4/del_t ;


    delta(1) = hl*u_0;

    for region = 1:4
        a = 2 + xp(region)/del_x;
        b = xp(region+1)/del_x;
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
            Rp(index,index-1) = k1/del_x;
            Rp(index,index) = -(k1/del_x+hr)+rho1*c1/del_t;

            Rn(index,index) = rho1*c1/del_t;

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



    A = Rn\Rp;
    b = Rn\delta;
    u = (eye(N)-A)\b;
    u1 = u(1);
end