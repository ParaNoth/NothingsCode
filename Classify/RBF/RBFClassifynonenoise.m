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
%生成测试集
positive_sample = [x1',y1'];
negetive_sample = [x2',y2'];
Xp = [positive_sample;negetive_sample];
Dp = [ones(sam_num,1);-ones(sam_num,1)];
[w,phi,rbfs_mean,rbfs_varible] = nothingsrbftrainer1( Xp,Dp,N );
%画出分割面
% kq = vpa(zeros(sam_num*2,1));
% syms x y;
% parfor i=1:2*sam_num                                                
%      kq(i)=exp(-((rbfs_mean(i,1)-x)^2+(rbfs_mean(i,2)-y)^2)/(2*rbfs_varible^2));       
% end
% cc=w'*kq;                                                                            
% figure,f=ezplot(cc,[-25,25],[-25,25]);
% set(f,'color','r','LineWidth',2,'Fill','on');
% hold on;
% plot(x1,y1,'r');
% plot(x2,y2,'b');
% 生成测试集
i=[1:0.05:500];
xt = (1/25).*(i+8).*cos(2*pi/25.*(i+8)-0.25*pi);
yt = (1/25).*(i+8).*sin(2*pi/25.*(i+8)-0.25*pi)-0.25;
positive_test = [xt',yt'];
xt = (-1/25).*(i+8).*sin(2*pi/25.*(i+8)+0.25*pi);
yt = (1/25).*(i+8).*cos(2*pi/25.*(i+8)+0.25*pi)-0.25;
negetive_test = [xt',yt'];
yp = sign(phi*w);
figure,plot3(Xp(1:sam_num,1),Xp(1:sam_num,2),yp(1:sam_num),'.');
hold on;
plot3(Xp(sam_num+1:end,1),Xp(sam_num+1:end,2),yp(sam_num+1:end),'.');
title('训练集结果');
%测试RBF核
yt = sign(nothingsrbftester(w,rbfs_mean,rbfs_varible,positive_test));
loss = length(find(yt==-1));
figure,plot3(positive_test(:,1),positive_test(:,2),yt,'.');
hold on;
yt = sign(nothingsrbftester(w,rbfs_mean,rbfs_varible,negetive_test));
loss = loss+length(find(yt==1));
plot3(negetive_test(:,1),negetive_test(:,2),yt,'.');
title('测试集结果');
