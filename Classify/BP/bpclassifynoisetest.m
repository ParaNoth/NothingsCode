clc;clear;
ns = 500;
itrain = linspace(1,500,ns);

x1=(1/25).*(itrain+8).*cos(2*pi/25.*(itrain+8)-0.25*pi);
y1=(1/25).*(itrain+8).*sin(2*pi/25.*(itrain+8)-0.25*pi)-0.25;
x2=(-1/25).*(itrain+8).*sin(2*pi/25.*(itrain+8)+0.25*pi);
y2=(1/25).*(itrain+8).*cos(2*pi/25.*(itrain+8)+0.25*pi)-0.25;
positive_sample = [x1;y1];
negetive_sample = [x2;y2];
Xp = [x1,x2;y1,y2];
Dp = [1*ones(1,ns),-1*ones(1,ns)];
net=newff(minmax(Xp),[50,50,10,1],{'purelin','tansig','tansig','tansig'},'traingdm');
net.trainParam.lr=0.1;
net.trainParam.epochs=10000;
net = train(net,Xp,Dp);
SNRlist = [0,6,10,20,30,45,60];
for i = 1:7

SNR = SNRlist(i);
positive_sample_noise = awgn(positive_sample,SNR);
negetive_sample_noise = awgn(negetive_sample,SNR);
Xtest = awgn(Xp,SNR);%%样本加噪




y = sim(net,Xp);
yt = sim(net,Xtest);
yt = sign(yt);
y = sign(y);


J(i) = norm(yt-Dp)^2
end
truerate=1-J./2000;
figure,plot(SNRlist,J);
title('错误数')
xlabel('SNR');
ylabel('J');
figure,plot(SNRlist,truerate);
title('正确率')
xlabel('SNR');
ylabel('%');
