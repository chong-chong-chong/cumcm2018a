function C = C( x )
    if x<0
        C = 0;
    elseif x>=0&&x<=0.005
        C = 1055;
    elseif x>0.005&&x<=0.0086
        C = 1726;
    elseif x>0.0086&&x<=0.0146
        C = 2100;
    elseif x>0.0146&&x<=0.0152
        C = 1377;
    else
        C=0;
    end
        

end