clc;
clear;
%����ѵ����

x1=[1,1,1,1,-1,-1,-1,-1];
x2=[1,1,-1,-1,1,1,-1,-1];
x3=[1,-1,1,-1,1,-1,1,-1];
Xp = [x1',x2',x3'];
Dp = x1'.*x2'.*x3'; %��άͬ�����ά���Ľ����һ���ġ�
Dp(find(Dp==0)) =-1;
%��ʼѵ��SVM
d = 3;
[b0,ap] = nothingsSVMtrainer(Xp,Dp,d);

yt = nothingsSVMtester(b0,ap,Xp,Dp,d,Xp);

syms x y z;
for i=1:8                                                
     kq(i)=((Xp(i,1)*x)+(Xp(i,2)*y)+(Xp(i,3)-z))^d;       
end
cc=sum(Dp.*ap.*kq')+b0;      
figure;
f=ezimplot3(cc,[-2,2,-2,2,-2,2]);
set(f,'LineWidth',2);
hold on;
grid on;
plot3(x1,x2,x3,'o');