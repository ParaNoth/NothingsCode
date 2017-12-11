clc;
clear;
%����ѵ����

x1=[1,1,1,1,-1,-1,-1,-1];
x2=[1,1,-1,-1,1,1,-1,-1];
x3=[1,-1,1,-1,1,-1,1,-1];
Xp = [x1',x2',x3'];
Dp = x1'.*x2'.*x3'; %��άͬ�����ά���Ľ����һ���ġ�
%��ʼѵ��SVM
sigma = 1;
[b0,ap] = nothingsSVMtrainer(Xp,Dp,sigma);

yt = nothingsSVMtester(b0,ap,Xp,Dp,sigma,Xp);

syms x y z;
for i=1:8                                                
     kq(i)=exp(-((Xp(i,1)-z)^2+(Xp(i,2)-x)^2+(Xp(i,3)-y)^2)/(2*sigma^2));       
end
cc=sum(Dp.*ap.*kq')+b0;      
figure;
f=ezimplot3(cc,[-2,2,-2,2,-2,2]);
set(f,'LineWidth',2);
hold on;
grid on;
plot3(x1,x2,x3,'o');
