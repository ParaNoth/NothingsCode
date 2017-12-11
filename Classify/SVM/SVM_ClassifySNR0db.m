clc;
clear;
%生成训练集
i=[1:0.5:500];
sam_num = length(i);
x1=(1/25).*(i+8).*cos(2*pi/25.*(i+8)-0.25*pi);
y1=(1/25).*(i+8).*sin(2*pi/25.*(i+8)-0.25*pi)-0.25;
x2=(-1/25).*(i+8).*sin(2*pi/25.*(i+8)+0.25*pi);
y2=(1/25).*(i+8).*cos(2*pi/25.*(i+8)+0.25*pi)-0.25;
sample_SNR=0;
%开始训练SVM
positive_sample = [x1',y1'];
positive_sample_noise = awgn(positive_sample,sample_SNR);%给正样本加高斯白噪声
negetive_sample = [x2',y2'];
negetive_sample_noise = awgn(negetive_sample,sample_SNR);%给负样本加高斯白噪声
figure,plot(positive_sample(:,1),positive_sample(:,2));
hold on;
plot(positive_sample_noise(:,1),positive_sample_noise(:,2));
Xp = [positive_sample_noise;negetive_sample_noise];
Dp = [ones(sam_num,1);-1.*ones(sam_num,1)];
sigma = 0.4;
[b0,ap] = nothingsSVMtrainer(Xp,Dp,sigma);
kq = vpa(zeros(sam_num*2,1));
syms x y;
for i=1:2*sam_num                                                
     kq(i)=exp(-((Xp(i,1)-x)^2+(Xp(i,2)-y)^2)/(2*sigma^2));       
end
cc=sum(Dp.*ap.*kq)+b0;                                                                            
figure,f=ezplot(cc,[-25,25],[-25,25]);
set(f,'color','r','LineWidth',2,'Fill','on');
hold on;
plot(positive_sample_noise(:,1),positive_sample_noise(:,2),'r');
plot(negetive_sample_noise(:,1),negetive_sample_noise(:,2),'b');
% 生成测试集
i=[1.25:0.5:500];
xt = (1/25).*(i+8).*cos(2*pi/25.*(i+8)-0.25*pi);
yt = (1/25).*(i+8).*sin(2*pi/25.*(i+8)-0.25*pi)-0.25;
positive_test = [xt',yt'];
positive_test_noise = awgn(positive_test,sample_SNR);%给正测试集加高斯白噪声
xt = (-1/25).*(i+8).*sin(2*pi/25.*(i+8)+0.25*pi);
yt = (1/25).*(i+8).*cos(2*pi/25.*(i+8)+0.25*pi)-0.25;
negetive_test = [xt',yt'];
negetive_test_noise = awgn(negetive_test,sample_SNR);%给正测试集加高斯白噪声
%测试SVM
yt = nothingsSVMtester(b0,ap,Xp,Dp,sigma,positive_test_noise);
loss = length(find(yt==-1));
figure,plot3(positive_test_noise(:,1),positive_test_noise(:,2),yt,'.');
hold on;
yt = nothingsSVMtester(b0,ap,Xp,Dp,sigma,negetive_test_noise);
loss = loss+length(find(yt==1));
plot3(negetive_test_noise(:,1),negetive_test_noise(:,2),yt,'.');
