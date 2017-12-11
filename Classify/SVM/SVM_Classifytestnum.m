clc;
clear;
%生成训练集
i=[1:1:500];
sam_num = length(i);
x1=(1/25).*(i+8).*cos(2*pi/25.*(i+8)-0.25*pi);
y1=(1/25).*(i+8).*sin(2*pi/25.*(i+8)-0.25*pi)-0.25;
x2=(-1/25).*(i+8).*sin(2*pi/25.*(i+8)+0.25*pi);
y2=(1/25).*(i+8).*cos(2*pi/25.*(i+8)+0.25*pi)-0.25;

%开始训练SVM
positive_sample = [x1',y1'];
negetive_sample = [x2',y2'];
Xp = [positive_sample;negetive_sample];
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
plot(x1,y1,'r.');
plot(x2,y2,'b.');
title('分割面')
legend({'分割面','正样本','负样本'});