
%%

clear
L2 = 19/1000:(0.1/1000):21/1000;
U3300 = zeros(length(L2),1);
for index2 = 1:length(L2)
    U3300(index2) = getUtbyL2(L2(index2));
end
%%
plot(L2,U3300)
hold on
line([19/1000,21/1000],[44,44],'LineStyle','--','Color','r')
xlabel('L2')
ylabel('u|_{t=3300s}')
%20.8mm

%%
L_S = 20.5/1000;
L_I = 21.8/1000;

Val_S = 100;
Val_I = 0;
Val_R = 44;
region_L = 1/1000;
err = 0.001/1000;
while (Val_S-Val_I)>err
    Val_S = getUtbyL2(L_S);
    Val_I = getUtbyL2(L_I);
    if (Val_S-Val_I)<err
        break;
    end
    if (Val_S>Val_R) && (Val_I<Val_R)
        L_S = L_S-region_L/4;
        L_I = L_I+region_L/4;
    elseif Val_I>Val_R
        L_I = L_I - region_L/2;
        L_S = L_I + region_L/2;
    elseif Val_S<Val_R
        L_S = L_S + region_L/2;
        L_I = L_S - region_L/2;
    end
    region_L = region_L/2;
end

%%
%20.9mm
plot(getUt(20.9/1000))