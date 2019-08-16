%%
beta = (0.6/0.082 + 6/0.37 + 3.6/0.045 + 5/0.028)/1000;
alpha = (75-37-11.08)/11.08;
figure();
hl = 8.31:0.0025:8.325;
hr = hl./(alpha-beta*hl);
plot(hl,hr);
%%
dataNum = length(hl);
e2 = zeros(dataNum,1);
for index=1:dataNum
    h_r = hr(index);
    h_l = hl(index);
    Ut = getUt(h_l,h_r);
    e2(index) = norm(realUt-Ut,2);
end
%%
plot(e2)