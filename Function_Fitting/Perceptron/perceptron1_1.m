clc;
clear;
%设定参数
sam_num=100;%采样数
num_of_perceptron = 20;%感知器分段数
lr = 0.0002;
maxiter = 500000;
e = 0.0001;
w = zeros(num_of_perceptron,2);
theta = zeros(num_of_perceptron,1);
%生成训练集
x=linspace(1,100,sam_num)';
d=1./sqrt(x);
dpositive = d+0.1;
dnegetive = d-0.1;
xp = reshape(x,sam_num/num_of_perceptron,num_of_perceptron);%将样本分为10组
dp=reshape(d,sam_num/num_of_perceptron,num_of_perceptron);
y=zeros(size(dp));
dppositve = reshape(dpositive,sam_num/num_of_perceptron,num_of_perceptron);
dpnegetive = reshape(dnegetive,sam_num/num_of_perceptron,num_of_perceptron);
Dp = [ones(sam_num/num_of_perceptron,1);-ones(sam_num/num_of_perceptron,1)];
xpin = [xp;xp];
dpin = [dppositve;dpnegetive];

figure;hold on;
plot(x,d);
plot(x,dpositive);
plot(x,dnegetive);
for i=1:num_of_perceptron
    Xp = [xpin(:,i),dpin(:,i)];
    [w(i,:),theta(i,:),jt]=nothingsperceptrontrainer(Xp,Dp,lr,e,maxiter);
end
for i=1:num_of_perceptron
    y(:,i) = -w(i,1)/w(i,2).*xp(:,i)+theta(i)/w(i,2);
    plot(xp(:,i),y(:,i));
end
legend({'原函数','正样本','负样本'});
title('y = 1/sqrt(x)');
xlabel('x');
ylabel('y');

    