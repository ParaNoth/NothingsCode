clc;
clear;
%生成训练集

x1=[1,1,1,1,-1,-1,-1,-1];
x2=[1,1,-1,-1,1,1,-1,-1];
x3=[1,-1,1,-1,1,-1,1,-1];
Xp = [x1',x2',x3'];
Dp = x1'.*x2'.*x3'; %三维同或和三维异或的结果是一样的。 %三维同或和三维异或的结果是一样的。
rate = zeros(1,7);
xx = [2:8];
%开始训练SVM
for i = 1:7
d = i+1;
[b0,ap] = nothingsSVMtrainer(Xp,Dp,d);

yt = nothingsSVMtester(b0,ap,Xp,Dp,d,Xp);
rate(i) = norm(yt-Dp)^2/4/8;
end
figure,plot(xx,rate);
title('正确率')
xlabel('d');
ylabel('%');