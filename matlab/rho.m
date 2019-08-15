function rho = rho( x )
    if x<0
        rho = 0;
    elseif x>=0&&x<=0.005
        rho = 1.18;
    elseif x>0.005&&x<=0.0086
        rho = 74.2;
    elseif x>0.0086&&x<=0.0146
        rho = 862;
    elseif x>0.0146&&x<=0.0152
        rho = 300;
    else
        rho=0;
    end
        

end

