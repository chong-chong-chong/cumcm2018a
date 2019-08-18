%%
beta = (0.6/0.082 + 6/0.37 + 3.6/0.045 + 5/0.028)/1000;
alpha = (75-37-11.08)/11.08;
%figure();
%hl = 8.32:0.0005:8.4000000;
%hr = hl./(alpha-beta*hl);
hr = 100.62:0.001:100.63;
hl = alpha*hr./(1+beta*hr);
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
%%
[val,ind] = min(e2);
%8.319346761353728,1.006260000000000e+02