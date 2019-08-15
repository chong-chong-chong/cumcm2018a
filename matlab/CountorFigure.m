%%
uuu = zeros(100,100);

for h1=1:100
    for h2 = 1:100
        uuu(h1,h2) = getU1(h1*0.1+3,h2*0.1+3);
    end
end

%%
x = 1:100;
y = 1:100;
hl = x*0.1+3;
hr = y*0.1+3;
[HL,HR] = meshgrid(hl,hr);
%%
contour(HL,HR,uuu);
hold on
contour(HL,HR,uuu,[48.08,40.08],'Color','r');