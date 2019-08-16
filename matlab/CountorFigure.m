%%
uuu = zeros(100,100);

for h1=1:100
    for h2 = 1:100
        uuu(h2,h1) = getU1(h1/5,h2/2.5+80);
    end
end

%%
x = 1:100;
y = 1:100;
hl = x/5;
hr = y+50;
[HL,HR] = meshgrid(hl,hr);
%%
figure()
contour(HL,HR,uuu,'ShowText','on');
hold on
C =contour(HL,HR,uuu,[48.08,48.08],'Color','r','ShowText','on');
hold off
%%
h_40_l = C(1,:);
h_40_r = C(2,:);
%%
dataNum = length(h_40_r);
e2 = zeros(1,dataNum);
for index=1:dataNum
    h_r = h_40_r(index);
    h_l = h_40_l(index);
    Ut = getUt(h_l,h_r);
    e2(index) = norm(realUt-Ut,2);
end