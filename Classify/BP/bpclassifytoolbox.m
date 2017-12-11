clc;clear;
ns = 500;
itrain = linspace(1,500,ns);
p=randperm(500);

x1=(1/25).*(itrain+8).*cos(2*pi/25.*(itrain+8)-0.25*pi);
y1=(1/25).*(itrain+8).*sin(2*pi/25.*(itrain+8)-0.25*pi)-0.25;
x2=(-1/25).*(itrain+8).*sin(2*pi/25.*(itrain+8)+0.25*pi);
y2=(1/25).*(itrain+8).*cos(2*pi/25.*(itrain+8)+0.25*pi)-0.25;
positive_sample = [x1;y1];
negetive_sample = [x2;y2];
Xp = [x1,x2;y1,y2];
Dp = [1*ones(1,ns),-1*ones(1,ns)];


SNR = 6;
positive_sample_noise = awgn(positive_sample,SNR);
negetive_sample_noise = awgn(negetive_sample,SNR);
Xtest = awgn(Xp,SNR);%%样本加噪
figure;
plot(positive_sample_noise(1,:),positive_sample_noise(2,:),'.')
hold on 
plot(negetive_sample_noise(1,:),negetive_sample_noise(2,:),'.')
title('测试集');
xlabel('x');
ylabel('y');

net=newff(minmax(Xp),[50,50,10,1],{'purelin','tansig','tansig','tansig'},'traingdm');
net.trainParam.lr=0.1;
net.trainParam.epochs=10000;
net = train(net,Xp,Dp);
y = sim(net,Xp);
yt = sim(net,Xtest);
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
for i=ns+1:2*ns
    if y(i) == -1;
        yes = yes + 1;
    else
        no = no + 1;
    end
end
confusion_mat(2,2) = yes;
confusion_mat(1,2) = no;
confusion_mat(3,1) = confusion_mat(1,1)/(confusion_mat(1,1)+confusion_mat(2,1));
confusion_mat(3,2) = confusion_mat(2,2)/(confusion_mat(1,2)+confusion_mat(2,2));
confusion_mat(1,3) = confusion_mat(1,1)/(confusion_mat(1,1)+confusion_mat(1,2));
confusion_mat(2,3) = confusion_mat(2,2)/(confusion_mat(2,1)+confusion_mat(2,2));
confusion_mat(3,3) = (confusion_mat(1,1)+confusion_mat(2,2))/sum(sum(confusion_mat(1:2,1:2)));
confusion_mat
figure;
plot3(Xp(1,1:ns),Xp(2,1:ns),y(1,1:ns),'.');
hold on 
grid on
plot3(Xp(1,ns+1:2*ns),Xp(2,ns+1:2*ns),y(1,ns+1:2*ns),'.');
figure;
plot3(Xtest(1,1:ns),Xtest(2,1:ns),yt(1,1:ns),'.');
hold on 
grid on
plot3(Xtest(1,ns+1:2*ns),Xtest(2,ns+1:2*ns),yt(1,ns+1:2*ns),'.');
title('测试集结果');
norm(yt-Dp)^2
