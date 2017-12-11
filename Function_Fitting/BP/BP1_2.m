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
legend({'测试结果','y = sin(x)'});
title('y = sin(x)');
xlabel('x');
ylabel('y');
figure

plot(jt)
title('误差曲线');
set(gca,'YLim',[0,0.1])
xlabel('迭代次数it');
ylabel('误差函数J');

Xt = linspace(0.5,4*pi,100)';
h = 1./(1+exp(-Xt*wj+bj.*ones(100,1)));
y = h*wk-bk.*ones(100,1);
figure,plot(Xt,y,'*');
hold on
plot(Xp,Dp,'r');
legend({'测试结果','y = 1/sin(x)'});
title('测试集效果：y = 1/sin(x)');
xlabel('x');
ylabel('y');
