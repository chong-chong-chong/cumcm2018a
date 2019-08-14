function al = alpha( x )
    if x<0
        al = 0;
    elseif x>=0&&x<=0.005
        al = 2.361075976051944e-05;
    elseif x>0.005&&x<=0.0086
        al = 3.441935316092042e-07;
    elseif x>0.0086&&x<=0.0146
        al = 2.043973041652856e-07;
    elseif x>0.0146&&x<=0.0152
        al = 1.984991527475188e-07;
    else
        al=0;
    end
        

end

