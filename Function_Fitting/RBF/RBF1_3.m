clc;
clear;
%生成样本和教师
x = [-4*pi:0.1:4*pi]';
t = sin(x).^2./x.^2;
%kmeans对t聚类，聚N类
N = 50;
[w,phi,rbfs_mean,rbfs_varible] = nothingsrbftrainer1( x,t,N );

y = phi*w;
figure,plot(x,y,'.');
hold,plot(x,t);
legend({'测试结果','y = sin(x)^2./x^2'});
title('训练集结果y = sin(x)^2./x^2');
xlabel('x');
ylabel('y');
loss=norm(t-y);
xt = [-4*pi+0.05:0.1:4*pi]';
tt = sin(xt).^2./xt.^2;
phi = nothingsRBFvector(xt, rbfs_mean, rbfs_varible);
yt = phi*w;
losst=norm(tt-yt);
figure,plot(xt,yt,'.');
hold,plot(xt,tt);
legend({'测试结果','y = sin(x)^2./x^2'});
title('测试集结果y = sin(x)^2./x^2');
xlabel('x');
ylabel('y');