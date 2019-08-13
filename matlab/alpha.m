function al = alpha( x )
    a4 = 0.028/(1.18*1005);
    
    a3 = 0.045/(74.2*1762);
    a2 = 0.37/(862*2100);
    a1 = 0.082/(300*1377);
    if x<0
        al = 0;
    elseif x>=0&&x<=0.005
        al = a4;
    elseif x>0.005&&x<=0.0086
        al = a3;
    elseif x>0.0086&&x<=0.0146
        al = a2;
    elseif x>0.0146&&x<=0.0152
        al = a1;
    else
        al=0;
    end
        

end

