clear;clc;
sam_num = 100;
%���������ͽ�ʦ
Ip = [linspace(-4*pi,4*pi,sam_num)];
X = (sin(Ip)./Ip).^2;
Xp = [X - 0.01,X + 0.01;Ip,Ip]';
Dp = [ones(1,sam_num),-1*ones(1,sam_num)]';
%���SVM�Ĳ�����
sigma = 1;
[b0,a] = nothingsSVMtrainer(Xp,Dp,sigma);
kq = vpa(zeros(sam_num*2,1));
%�����ֽ���ͼ
syms x y;
parfor i=1:2*sam_num
    kq(i)=exp(-((Xp(i,1)-y)^2+(Xp(i,2)-x)^2)/(2*sigma^2));       
end
cc=Dp'.*a'*kq+b0;                   
figure;
f=ezplot(cc,[-4*pi,4*pi],[-0.5,1]);
set(f,'color','r','LineWidth',2);
hold on;
%����ԭ����ͼ���Ա�
plot(Ip,X,'b');
legend({'���Խ��','y = (sin(x)/x)^2'});
title('SVM���Ч����y = (sin(x)/x)^2');