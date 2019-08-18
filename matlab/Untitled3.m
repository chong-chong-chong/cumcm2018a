%%
clear
L2 = 0.6/1000:(0.4/1000):25/1000;
L4 = 0.6/1000:0.2/1000:6.4/1000;
U1800 = zeros(length(L2),length(L4));
U1500 = zeros(length(L2),length(L4));
for index2 = 1:length(L2)
    for index4 = 1:length(L4)
    U1800(index2,index4) = getUt_t(L2(index2),L4(index4),1800);
    U1500(index2,index4) = getUt_t(L2(index2),L4(index4),1500);
    end
end

%%
%figure();
[L2_x,L4_y] = meshgrid(L2,L4);
%imagesc(L2,L4,U1500-44);
%figure()
%imagesc(L2,L4,U1200-47);
figure()
hold on 
imagesc(L2,L4,U1500');

[zeros1,h1] = contour(L2_x,L4_y,U1800',[47,47],'Color','y','Linestyle','-','LineWidth',1,'DisplayName','47℃ 安全线');
[zeros2,h2] = contour(L2_x,L4_y,U1500',[44,44],'Color','g','Linestyle','-','LineWidth',1,'DisplayName','44℃ 安全线');
c = colorbar('Location','southoutside');
colormap hot
c.Label.String = '在1500s时的温度';
caxis([39,64])
xlabel('L2/m')
ylabel('L4/m')

%,[0,0],'Color','r'
%%
L2addL4 = L2_x+L4_y;
[val,ind] = min(L2addL4);
%%

clear
L2 = 20.6/1000:(0.02/1000):21/1000;
U3300 = zeros(length(L2),1);
for index2 = 1:length(L2)
    U3300(index2) = getUtbyL2(L2(index2));
end
%%
plot(L2,U3300-44)
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