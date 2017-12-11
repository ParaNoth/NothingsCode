clc;
clear;
%生成训练集
i=[1:1:500];
sam_num = length(i);
x1=(1/25).*(i+8).*cos(2*pi/25.*(i+8)-0.25*pi);
y1=(1/25).*(i+8).*sin(2*pi/25.*(i+8)-0.25*pi)-0.25;
x2=(-1/25).*(i+8).*sin(2*pi/25.*(i+8)+0.25*pi);
y2=(1/25).*(i+8).*cos(2*pi/25.*(i+8)+0.25*pi)-0.25;
positive_sample = [x1',y1'];
negetive_sample = [x2',y2'];
Xp = [positive_sample;negetive_sample];
Dp = [ones(sam_num,1);zeros(sam_num,1)];
%开始训练
nh = 100;
e = 0.0001;
lr = 0.05;
maxiter = 500000;
[ wk,wj,bk,bj,jt ] = nothingsbptrainer( Xp,Dp,nh,lr,e,maxiter );
h = 1./(1+exp(-Xp*wj+bj.*ones(sam_num*2,1)));
y = 1./(1+exp(-h*wk+bk.*ones(sam_num*2,1)));
yy = double(y>=0.5);
plot3(Xp(1:sam_num,1),Xp(1:sam_num,2),y(1:sam_num),'.');
hold on;
plot3(Xp(sam_num+1:end,1),Xp(sam_num+1:end,2),y(sam_num+1:end),'.');