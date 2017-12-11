clc;
clear;
%���������ͽ�ʦ
x = [-4*pi:0.1:4*pi]';
t = exp(-x.^2).*sin(x.^2);
%kmeans��t���࣬��N��
N = 200;
[w,phi,rbfs_mean,rbfs_varible] = nothingsrbftrainer( x,t,N );

y = phi*w;
figure,plot(x,y,'.');
hold,plot(x,t);
legend({'���Խ��','y = exp(-x^2)*sin(x^2)'});
title('ѵ�������y = exp(-x^2)*sin(x^2)');
xlabel('x');
ylabel('y');
loss=norm(t-y);
xt = [-4*pi+0.05:0.1:4*pi]';
tt = exp(-xt.^2).*sin(xt.^2);
phi = nothingsRBFvector(xt, rbfs_mean, rbfs_varible);
yt = phi*w;
losst=norm(tt-yt);
figure,plot(xt,yt,'.');
hold,plot(xt,tt);
legend({'���Խ��','y = exp(-x^2)*sin(x^2)'});
title('���Լ����y = exp(-x^2)*sin(x^2)');
xlabel('x');
ylabel('y');