clc;
clear;
%生成样本和教师
x = [1:5:100]';
t = 1./sqrt(x);


N = 20;
[w,phi,rbfs_mean,rbfs_varible] = nothingsrbftrainer( x,t,N );


%kmeans对t聚类，聚N类

y = phi*w;
loss = norm(t-y);


% set(gca,'YLim',[0,0.1])
xlabel('方差值');
ylabel('误差函数J');
y = phi*w;
figure,plot(x,y,'.');
hold,plot(x,t);
legend({'测试结果','y = sqrt(x)'});
title('训练集结果y = sqrt(x)');
xlabel('x');
ylabel('y');
xt = [1.25:0.5:100.25]';
tt = 1./sqrt(xt);
phi = nothingsRBFvector(xt, rbfs_mean, rbfs_varible);
yt = phi*w;
losst=norm(tt-yt);
figure,plot(xt,yt,'.');
hold,plot(xt,tt);
legend({'测试结果','y = sqrt(x)'});
title('测试集结果y = sqrt(x)');
xlabel('x');
ylabel('y');