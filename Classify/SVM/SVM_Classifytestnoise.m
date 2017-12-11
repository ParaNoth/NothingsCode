clc;
clear;
%生成训练集
i=[1:0.5:500];
sam_num = length(i);
x1=(1/25).*(i+8).*cos(2*pi/25.*(i+8)-0.25*pi);
y1=(1/25).*(i+8).*sin(2*pi/25.*(i+8)-0.25*pi)-0.25;
x2=(-1/25).*(i+8).*sin(2*pi/25.*(i+8)+0.25*pi);
y2=(1/25).*(i+8).*cos(2*pi/25.*(i+8)+0.25*pi)-0.25;
%生成测试集
positive_sample = [x1',y1'];
negetive_sample = [x2',y2'];
Xp = [positive_sample;negetive_sample];
Dp = [ones(sam_num,1);-ones(sam_num,1)];
sigma = 0.4;
[b0,ap] = nothingsSVMtrainer(Xp,Dp,sigma);
%画出分割面
% kq = vpa(zeros(sam_num*2,1));
% syms x y;
% parfor i=1:2*sam_num                                                
%      kq(i)=exp(-((rbfs_mean(i,1)-x)^2+(rbfs_mean(i,2)-y)^2)/(2*rbfs_varible^2));       
% end
% cc=w'*kq;                                                                            
% figure,f=ezplot(cc,[-25,25],[-25,25]);
% set(f,'color','r','LineWidth',2,'Fill','on');
% hold on;
% plot(x1,y1,'r');
% plot(x2,y2,'b');
% 生成测试集
i=[1:1:500];
xt = (1/25).*(i+8).*cos(2*pi/25.*(i+8)-0.25*pi);
yt = (1/25).*(i+8).*sin(2*pi/25.*(i+8)-0.25*pi)-0.25;
positive_test = [xt',yt'];
xt = (-1/25).*(i+8).*sin(2*pi/25.*(i+8)+0.25*pi);
yt = (1/25).*(i+8).*cos(2*pi/25.*(i+8)+0.25*pi)-0.25;
negetive_test = [xt',yt'];
Xt = [positive_test;negetive_test];
Dt = [ones(500,1);-ones(500,1)];
SNR = 0;
Xt = awgn(Xt,SNR);
%测试RBF核
yt = nothingsSVMtester(b0,ap,Xp,Dp,sigma,Xt);

figure,plot3(Xt(1:500,1),Xt(1:500,2),yt(1:500),'.');
hold on;
plot3(Xt(500+1:end,1),Xt(500+1:end,2),yt(500+1:end),'.');
title('测试集结果');
norm(yt-Dt)^2/4