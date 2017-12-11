clc;
clear;
%生成训练集
i=[1:1:500];
p=randperm(500);
ptrain = p(1:400);
peval = p(401:500);
sam_num = length(ptrain);
x1=(1/25).*(i+8).*cos(2*pi/25.*(i+8)-0.25*pi);
y1=(1/25).*(i+8).*sin(2*pi/25.*(i+8)-0.25*pi)-0.25;
x2=(-1/25).*(i+8).*sin(2*pi/25.*(i+8)+0.25*pi);
y2=(1/25).*(i+8).*cos(2*pi/25.*(i+8)+0.25*pi)-0.25;
positive_sample = [x1',y1',y1'./x1'];
negetive_sample = [x2',y2',y2'./x2'];
Xp = [positive_sample(ptrain,:);negetive_sample(ptrain,:)];
Dp = [ones(sam_num,1);zeros(sam_num,1)];
%开始训练
nh = 100;
e = 0.0001;
lr = 0.05;
maxiter = 500000;

[ wk,wj,bk,bj,jt ] = nothingsbptrainer( Xp,Dp,nh,lr,e,maxiter );

Xt = [positive_sample(peval,:);negetive_sample(peval,:)];
Dt = [ones(100,1);zeros(100,1)];
h = 1./(1+exp(-Xt*wj+bj.*ones(100*2,1)));
y = 1./(1+exp(-h*wk+bk.*ones(100*2,1)));
hp = 1./(1+exp(-Xp*wj+bj.*ones(sam_num*2,1)));
yp = 1./(1+exp(-hp*wk+bk.*ones(sam_num*2,1)));
yyp=double(yp>=0.5);
yy = double(y>=0.5);
figure,plot3(Xp(1:sam_num,1),Xp(1:sam_num,2),yyp(1:sam_num),'.');
hold on;
plot3(Xp(sam_num+1:end,1),Xp(sam_num+1:end,2),yyp(sam_num+1:end),'.');
title('训练集结果');
figure,plot3(Xt(1:100,1),Xt(1:100,2),yy(1:100),'.');
hold on;
plot3(Xt(100+1:end,1),Xt(100+1:end,2),yy(100+1:end),'.');
title('测试集结果');