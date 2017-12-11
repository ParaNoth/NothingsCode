clear;clc;
sam_num = 300;
%生成样本和教师
Ip = linspace(-4*pi,4*pi,sam_num);
X= exp(-Ip.^2).*sin(Ip.^2);
Xp = [X - 0.01,X + 0.01;Ip,Ip]';
Dp = [ones(1,sam_num),-1*ones(1,sam_num)]';
%求出SVM的参数。
sigma = 1;
[b0,a] = nothingsSVMtrainer(Xp,Dp,sigma);
%kq = vpa(zeros(sam_num*2,1));
%作出分界面图
syms x y;
parfor i=1:2*sam_num                                                
     kq(i)=exp(-((Xp(i,1)-y)^2+(Xp(i,2)-x)^2)/(2*sigma^2));       
end
cc=sum(Dp.*a.*kq')+b0;                                                                            
f=ezplot(cc,[-4*pi,4*pi],[-0.1,0.5]);
set(f,'color','r','LineWidth',2);
hold on;
%作出原函数图并对比
plot(Ip,X,'b');
legend({'测试结果','y = exp(-x^2)sin(x^2)'});
title('SVM拟合效果：y = exp(-x^2)sin(x^2)');