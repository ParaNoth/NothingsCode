clc;clear;
sam_num=200;
Xp = linspace(1,100,200);
Xp = Xp';
Dp = 1./sqrt(Xp);
Xtest = unifrnd(1,100,1,30)';
nh = 13;
lr = 0.05;
e = 0.0001;
[wk,wj,bk,bj,jt] = nothingsbptrainer(Xp,Dp,nh,lr,e,100000);
h = 1./(1+exp(-Xp*wj+bj.*ones(sam_num,1)));
y = h*wk-bk.*ones(sam_num,1);
figure,plot(Xp,y,'*');
hold on
plot(Xp,Dp,'r');
legend({'测试结果','y = 1/sqrt(x)'});
title('训练集效果：y = 1/sqrt(x)');
xlabel('x');
ylabel('y');
figure
plot(jt)
title('误差曲线');
set(gca,'YLim',[0,0.1])
xlabel('迭代次数it');
ylabel('误差函数J');
Xt = linspace(1.25,100,199)';
h = 1./(1+exp(-Xt*wj+bj.*ones(199,1)));
y = h*wk-bk.*ones(199,1);
figure,plot(Xt,y,'*');
hold on
plot(Xp,Dp,'r');
legend({'测试结果','y = 1/sqrt(x)'});
title('测试集效果：y = 1/sqrt(x)');
xlabel('x');
ylabel('y');
