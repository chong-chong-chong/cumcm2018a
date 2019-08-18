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
