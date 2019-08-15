function k = k( x )
    if x<=0
        k = 0;
    elseif x>0&&x<=0.005
        k = 0.028;
    elseif x>0.005&&x<=0.0086
        k = 0.045;
    elseif x>0.0086&&x<=0.0146
        k = 0.37;
    elseif x>0.0146&&x<0.0152
        k = 0.082;
    else
        k=0;
    end
end