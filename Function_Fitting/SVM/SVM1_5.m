clear;clc;
sam_num = 30;
x1 = linspace(-sqrt(10),sqrt(10),sam_num);
x2 = linspace(-sqrt(10),sqrt(10),sam_num);
%���������ͽ�ʦ
[m,n]=meshgrid(x1,x2');
[m,n]=deal(reshape(m,[],1),reshape(n,[],1));
X = [m,n];
index = find(X(:,1).^2+X(:,2).^2<=10);
sam_num = length(index);
X = X(index,:);
Y = sqrt(10-(X(:,1).^2+X(:,2).^2));
Xp1 = [X;X];
Xp2 = [Y - 0.01;Y + 0.01];
Xp = [Xp2,Xp1];
Dp = [ones(1,sam_num),-1*ones(1,sam_num)]';
%���SVM�Ĳ�����
sigma = 1.5;
[b0,a] = nothingsSVMtrainer(Xp,Dp,sigma);
%kq = vpa(zeros(sam_num*2,1));
%�����ֽ���ͼ
syms x y z;
parfor i=1:2*sam_num                                                
     kq(i)=exp(-((Xp(i,1)-z)^2+(Xp(i,2)-x)^2+(Xp(i,3)-y)^2)/(2*sigma^2));       
end
cc=sum(Dp.*a.*kq')+b0;                                                                            
f=ezimplot3(cc,[-sqrt(10),sqrt(10),-sqrt(10),sqrt(10),0,4]);
set(f,'LineWidth',2);
hold on;
%����ԭ����ͼ���Ա�
plot3(X(:,1),X(:,2),Y,'g*');
legend({'���Խ��','y = sqrt(10-x1^2-x2^2)'});
title('SVM���Ч����y = sqrt(10-x1^2-x2^2)');