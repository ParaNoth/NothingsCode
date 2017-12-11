clc;
clear;
%生成训练集
i=[1:1:500];
p=randperm(500);
ptrain = p(1:400);
peval = p(401:500);
sam_num = length(ptrain);
N = 2*sam_num;
x1=(1/25).*(i+8).*cos(2*pi/25.*(i+8)-0.25*pi);
y1=(1/25).*(i+8).*sin(2*pi/25.*(i+8)-0.25*pi)-0.25;
x2=(-1/25).*(i+8).*sin(2*pi/25.*(i+8)+0.25*pi);
y2=(1/25).*(i+8).*cos(2*pi/25.*(i+8)+0.25*pi)-0.25;
positive_sample = [x1',y1'];
negetive_sample = [x2',y2'];
Xp = [positive_sample(ptrain,:);negetive_sample(ptrain,:)];
Dp = [ones(sam_num,1);-ones(sam_num,1)];
Xt = [positive_sample(peval,:);negetive_sample(peval,:)];
Dt = [ones(100,1);-ones(100,1)];
[w,phi,rbfs_mean,rbfs_varible] = nothingsrbftrainer1( Xp,Dp,N );

yp = sign(phi*w);

yt = sign(nothingsrbftester(w,rbfs_mean,rbfs_varible,Xt));
figure,plot3(Xp(1:sam_num,1),Xp(1:sam_num,2),yp(1:sam_num),'.');
hold on;
plot3(Xp(sam_num+1:end,1),Xp(sam_num+1:end,2),yp(sam_num+1:end),'.');
title('训练集结果');
figure,plot3(Xt(1:100,1),Xt(1:100,2),yt(1:100),'.');
hold on;
plot3(Xt(100+1:end,1),Xt(100+1:end,2),yt(100+1:end),'.');
title('测试集结果');

