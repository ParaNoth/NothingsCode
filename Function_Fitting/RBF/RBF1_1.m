clc;
clear;
%���������ͽ�ʦ
x = [1:0.5:100]';
t = 1./sqrt(x);
%kmeans��t���࣬��N��
N = 50;
[w,phi,rbfs_mean,rbfs_varible] = nothingsrbftrainer( x,t,N );

y = phi*w;
loss = norm(t-y);
figure,plot(x,y,'.');
hold,plot(x,t);
legend({'���Խ��','y = sqrt(x)'});
title('ѵ�������y = sqrt(x)');
xlabel('x');
ylabel('y');
xt = [1.25:0.5:100.25]';
tt = 1./sqrt(x);
phi = nothingsRBFvector(xt, rbfs_mean, rbfs_varible);
yt = phi*w;
losst=norm(tt-yt);
figure,plot(xt,yt,'.');
hold,plot(xt,tt);
legend({'���Խ��','y = sqrt(x)'});
title('���Լ����y = sqrt(x)');
xlabel('x');
ylabel('y');