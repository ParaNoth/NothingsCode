clc;
clear;
%����ѵ����

x1=[1,1,1,1,-1,-1,-1,-1];
x2=[1,1,-1,-1,1,1,-1,-1];
x3=[1,-1,1,-1,1,-1,1,-1];
Xp = [x1',x2',x3'];
Dp = x1'.*x2'.*x3'; %��άͬ�����ά���Ľ����һ���ġ� %��άͬ�����ά���Ľ����һ���ġ�
rate = zeros(1,7);
xx = [2:8];
%��ʼѵ��SVM
for i = 1:7
d = i+1;
[b0,ap] = nothingsSVMtrainer(Xp,Dp,d);

yt = nothingsSVMtester(b0,ap,Xp,Dp,d,Xp);
rate(i) = norm(yt-Dp)^2/4/8;
end
figure,plot(xx,rate);
title('��ȷ��')
xlabel('d');
ylabel('%');