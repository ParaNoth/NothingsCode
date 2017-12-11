clc;clear;
xx = [10:10:200];
J = [10:10:200];
for i=1:20
sam_num=10;
Xt = linspace(0.5,4*pi,100)';
Xp = linspace(0,4*pi,sam_num)';
Dp = sin(Xp);
nh = 20;
lr = 0.03;
e = 0.0001;
[wk,wj,bk,bj,jt] = nothingsbptrainer(Xp,Dp,nh,lr,e,100000);
h = 1./(1+exp(-Xp*wj+bj.*ones(sam_num,1)));
y = h*wk-bk.*ones(sam_num,1);
% plot(Xp,y,'*');
% hold on
% Dp = sin(Xt);
% plot(Xt,Dp,'r');
% legend({'测试结果','y = sin(x)'});
% title('y = sin(x)');
% xlabel('x');
% ylabel('y');
% figure



Xt = linspace(0.5,4*pi,100)';
h = 1./(1+exp(-Xt*wj+bj.*ones(100,1)));
y = h*wk-bk.*ones(100,1);
Dp = sin(Xt);
loss = norm(Dp-y);
J(i)=loss;
end
plot(J)
title('误差曲线');
set(gca,'YLim',[0,0.1])
xlabel('样本数量');
ylabel('误差函数J');
% figure,plot(Xt,y,'*');
% hold on
% plot(Xt,Dp,'r');
% legend({'测试结果','y = 1/sin(x)'});
% title('测试集效果：y = 1/sin(x)');
% xlabel('x');
% ylabel('y');
