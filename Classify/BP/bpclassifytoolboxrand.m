clc;clear;
ns = 500;
itrain = linspace(1,500,ns);
p=randperm(500);
ptrain = p(1:400);
peval = p(401:500);
x1=(1/25).*(itrain+8).*cos(2*pi/25.*(itrain+8)-0.25*pi);
y1=(1/25).*(itrain+8).*sin(2*pi/25.*(itrain+8)-0.25*pi)-0.25;
x2=(-1/25).*(itrain+8).*sin(2*pi/25.*(itrain+8)+0.25*pi);
y2=(1/25).*(itrain+8).*cos(2*pi/25.*(itrain+8)+0.25*pi)-0.25;
positive_sample = [x1;y1];
negetive_sample = [x2;y2];
sam_num = length(ptrain);
Xp = [positive_sample(:,ptrain),negetive_sample(:,ptrain)];
Dp = [ones(1,sam_num),zeros(1,sam_num)];

Xt = [positive_sample(:,peval),negetive_sample(:,peval)];
Dt = [ones(1,100),zeros(1,100)];
itest = itrain;



net=newff(minmax(Xp),[50,50,10,1],{'purelin','tansig','tansig','tansig'},'traingdm');
net.trainParam.lr=0.01;
net.trainParam.epochs=10000;
net = train(net,Xp,Dp);
y = sim(net,Xp);
yt = sim(net,Xt);
yt = sign(yt);
y = sign(y);
yes =0;
no = 0;
confusion_mat = zeros(3);
for i=1:ns
    if y(i) == 1;
        yes = yes + 1;
    else
        no = no + 1;
    end
end
confusion_mat(1,1) = yes;
confusion_mat(2,1) = no;
yes =0;
no = 0;

figure;
plot3(Xp(1,1:sam_num),Xp(2,1:sam_num),y(1,1:sam_num),'.');
hold on 
grid on
plot3(Xp(1,sam_num+1:end),Xp(2,sam_num+1:end),y(1,sam_num+1:end),'.');
title('训练集结果');
figure;
plot3(Xt(1,1:100),Xt(2,1:100),yt(1,1:100),'.');
hold on 
grid on
plot3(Xt(1,100+1:end),Xt(2,100+1:end),yt(1,100+1:end),'.');
title('测试集结果');