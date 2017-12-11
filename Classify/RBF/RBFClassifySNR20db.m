clc;
clear;
%生成训练集
i=[1:0.25:500];
sam_num = length(i);
x1=(1/25).*(i+8).*cos(2*pi/25.*(i+8)-0.25*pi);
y1=(1/25).*(i+8).*sin(2*pi/25.*(i+8)-0.25*pi)-0.25;
x2=(-1/25).*(i+8).*sin(2*pi/25.*(i+8)+0.25*pi);
y2=(1/25).*(i+8).*cos(2*pi/25.*(i+8)+0.25*pi)-0.25;
N = sam_num*2;
sample_SNR=20;
%开始训练rbf
positive_sample = [x1',y1'];
positive_sample_noise = awgn(positive_sample,sample_SNR);%给正样本加高斯白噪声
negetive_sample = [x2',y2'];
negetive_sample_noise = awgn(negetive_sample,sample_SNR);%给负样本加高斯白噪声
figure,plot(positive_sample(:,1),positive_sample(:,2));
Xp = [positive_sample_noise;negetive_sample_noise];
Dp = [ones(sam_num,1);-1.*ones(sam_num,1)];
hold on;
plot(positive_sample_noise(:,1),positive_sample_noise(:,2));
[w,phi,rbfs_mean,rbfs_varible] = nothingsrbftrainer1( Xp,Dp,N );
%画出分割面
% kq = vpa(zeros(sam_num*2,1));
% syms x y;
% for i=1:2*sam_num                                                
%      kq(i)=exp(-((rbfs_mean(i,1)-x)^2+(rbfs_mean(i,2)-y)^2)/(2*rbfs_varible^2));       
% end
% cc=w'*kq;                                                                            
% figure,f=ezplot(cc,[-25,25],[-25,25]);
% set(f,'color','r','LineWidth',2,'Fill','on');
% hold on;
% plot(x1,y1,'r');
% plot(x2,y2,'b');
%生成测试集
i=[1.25:0.05:500];
xt = (1/25).*(i+8).*cos(2*pi/25.*(i+8)-0.25*pi);
yt = (1/25).*(i+8).*sin(2*pi/25.*(i+8)-0.25*pi)-0.25;
positive_test = [xt',yt'];
positive_test_noise = awgn(positive_test,sample_SNR);%给正测试集加高斯白噪声
xt = (-1/25).*(i+8).*sin(2*pi/25.*(i+8)+0.25*pi);
yt = (1/25).*(i+8).*cos(2*pi/25.*(i+8)+0.25*pi)-0.25;
negetive_test = [xt',yt'];
negetive_test_noise = awgn(negetive_test,sample_SNR);%给负测试集加高斯白噪声
%测试RBF核
yt = sign(nothingsrbftester(w,rbfs_mean,rbfs_varible,positive_test_noise));
loss = length(find(yt==-1));
figure,plot3(positive_test_noise(:,1),positive_test_noise(:,2),yt,'.');
hold on;
yt = sign(nothingsrbftester(w,rbfs_mean,rbfs_varible,negetive_test_noise));
loss = loss+length(find(yt==1));
plot3(negetive_test_noise(:,1),negetive_test_noise(:,2),yt,'.');