clc;
clear;
%生成样本和教师

%生成x的可行域
x1 = [-sqrt(10):0.05:sqrt(10)];
x2 = [-sqrt(10):0.05:sqrt(10)];
[m,n]=meshgrid(x1,x2');
[m,n]=deal(reshape(m,[],1),reshape(n,[],1));
x = [m,n];
index = find(x(:,1).^2+x(:,2).^2<=10);
x = x(index,:);
t = sqrt(10-(x(:,1).^2+x(:,2).^2));
%kmeans对t聚类，聚N类
N = 400;
[w,phi,rbfs_mean,rbfs_varible] = nothingsrbftrainer1( x,t,N );

y = phi*w;
figure,plot3(x(:,1),x(:,2),y,'g*');
hold,plot3(x(:,1),x(:,2),t,'.');
legend({'测试结果','y = sqrt(10-(x1^2+x2^2))'});
title('训练集结果y = sqrt(10-(x1^2+x2^2))');
xlabel('x1');
ylabel('x2');
zlabel('y');
loss=norm(t-y);