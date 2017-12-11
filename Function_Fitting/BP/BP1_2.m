clc;clear;
sam_num=100;
Xp = linspace(0,4*pi,100)';
Dp = sin(Xp);
Xtest = unifrnd(-4*pi,4*pi,1,30)';
nh = 20;
lr = 0.03;
e = 0.0001;
[wk,wj,bk,bj,jt] = nothingsbptrainer2(Xp,Dp,nh,lr,e,50000);
h = 1./(1+exp(-Xp*wj+bj.*ones(sam_num,1)));
y = h*wk-bk.*ones(sam_num,1);
plot(Xp,y,'*');
hold on
plot(Xp,Dp,'r');
legend({'���Խ��','y = sin(x)'});
title('y = sin(x)');
xlabel('x');
ylabel('y');
figure

plot(jt)
title('�������');
set(gca,'YLim',[0,0.1])
xlabel('��������it');
ylabel('����J');

Xt = linspace(0.5,4*pi,100)';
h = 1./(1+exp(-Xt*wj+bj.*ones(100,1)));
y = h*wk-bk.*ones(100,1);
figure,plot(Xt,y,'*');
hold on
plot(Xp,Dp,'r');
legend({'���Խ��','y = 1/sin(x)'});
title('���Լ�Ч����y = 1/sin(x)');
xlabel('x');
ylabel('y');
