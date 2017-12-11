clear;clc;
sam_num = 100;
%���������ͽ�ʦ
Ip = linspace(1,100,sam_num);
X=1./sqrt(Ip);
Xp = [X - 0.01,X + 0.01;Ip,Ip]';
Dp = [ones(1,sam_num),-1*ones(1,sam_num)]';
%���SVM�Ĳ�����
sigma = 2;
[b0,a] = nothingsSVMtrainer(Xp,Dp,sigma);
%kq = vpa(zeros(sam_num*2,1));
%�����ֽ���ͼ
syms x y;
parfor i=1:2*sam_num                                                
     kq(i)=exp(-((Xp(i,1)-y)^2+(Xp(i,2)-x)^2)/(2*sigma^2));       
end
cc=sum(Dp.*a.*kq')+b0;                                                                            
f=ezplot(cc,[1,100],[-0.1,1]);
set(f,'color','r','LineWidth',2);
hold on;
%����ԭ����ͼ���Ա�
plot(Ip,X,'b');
legend({'���Խ��','y = 1/sqrt(x)'});
title('SVM���Ч����y = 1/sqrt(x)');
clear;clc;
sam_num = 100;
%���������ͽ�ʦ
Ip = linspace(1,100,sam_num);
X=1./sqrt(Ip);
Xp = [X - 0.01,X + 0.01;Ip,Ip]';
Dp = [ones(1,sam_num),-1*ones(1,sam_num)]';
%���SVM�Ĳ�����
sigma = 2;
[b0,a] = nothingsSVMtrainer(Xp,Dp,sigma);
%kq = vpa(zeros(sam_num*2,1));
%�����ֽ���ͼ
syms x y;
parfor i=1:2*sam_num                                                
     kq(i)=exp(-((Xp(i,1)-y)^2+(Xp(i,2)-x)^2)/(2*sigma^2));       
end
cc=sum(Dp.*a.*kq')+b0;                                                                            
f=ezplot(cc,[1,100],[-0.1,1]);
set(f,'color','r','LineWidth',2);
hold on;
%����ԭ����ͼ���Ա�
plot(Ip,X,'b');
legend({'���Խ��','y = 1/sqrt(x)'});
title('SVM���Ч����y = 1/sqrt(x)');
