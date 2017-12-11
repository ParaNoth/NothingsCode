clc;
clear;
x = 4:0.1:5;
lengthofx = length(x);
y = x;
y1 = y+0.03;
y2 = y-0.03;
Xp=[x',y1';x',y2'];
Dp=[ones(lengthofx,1);-ones(lengthofx,1)];
lr = 0.0003;
maxiter = 50000;
e = 0.0001;
[w,theta,jt]=nothingsperceptrontrainer(Xp,Dp,lr,e,maxiter);

z = -w(:,1)/w(:,2).*x+theta/w(:,2);
figure,plot(x,z);
hold on;
plot(x,y,'.');
plot(x,y1);
plot(x,y2);
legend({'��Ͻ��','ԭ����','������','������'});
title('y = x');
xlabel('x');
ylabel('y');
figure,plot(jt);