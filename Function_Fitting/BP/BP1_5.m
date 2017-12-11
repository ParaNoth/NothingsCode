clc;clear;
sam_num=30;
x1 = linspace(-sqrt(10),sqrt(10),sam_num);
x2 = linspace(-sqrt(10),sqrt(10),sam_num);
[m,n]=meshgrid(x1,x2');
[m,n]=deal(reshape(m,[],1),reshape(n,[],1));
X = [m,n];
index = find(X(:,1).^2+X(:,2).^2<=10);
sam_num = length(index);
Xp = X(index,:);
Dp = sqrt(10-(Xp(:,1).^2+Xp(:,2).^2));
Xtest = unifrnd(-4*pi,4*pi,1,30)';
nh = 40;
lr = 0.03;
e = 0.0001;
[wk,wj,bk,bj,jt] = nothingsbptrainer(Xp,Dp,nh,lr,e,100000);
h = 1./(1+exp(-Xp*wj+bj.*ones(sam_num,1)));
y = h*wk-bk.*ones(sam_num,1);
figure,plot3(Xp(:,1),Xp(:,2),y,'g*');
hold,plot3(Xp(:,1),Xp(:,2),Dp,'.');
legend({'测试结果','y=sqrt(10-x1^2-x2^2)'});
title('训练集效果y=sqrt(10-x1^2-x2^2)');
xlabel('x1');
ylabel('x2');
zlabel('y')
figure,plot(jt)
title('误差曲线');
set(gca,'YLim',[0,0.5])
xlabel('迭代次数it');
ylabel('误差函数J');
