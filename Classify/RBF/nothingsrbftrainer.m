function [ w,phi,rbfs_mean,rbfs_varible ] = nothingsrbftrainer( x,t,N )
%x为输入变量，t为教师，N为RBF中心个数，w为输出权值，phi为样本的核矩阵,rbfs_mean为拟合向量 此处显示有关此函数的摘要
%   此处显示详细说明
[~,x_num] = size(x);
[~,len_t] = size(t);
if x_num~=len_t
    fprintf('sample numbers does not match!');
    return;
end

[Idx,T,itertimes]=nothingskmeans(x,N,1000);
itertimes
%由聚类结果对x求均值和方差
meanofx = zeros(N,x_num);

meanoftempx = 1;
lastofmean = 1;
dmax = 0;
for i = 1:N
    %提取每类元素的索引
    lastofmean = meanoftempx;
    meanoftempx = T(i,:);
    dmax = max(dmax, abs(meanoftempx - lastofmean));
end

rbfs_varible = dmax/sqrt(N);
%生成核矩阵
phi = nothingsRBFvector(x, T, rbfs_varible);
%求取w
%w = inv(phi'*phi)*phi'*t;
rbfs_mean = T;
w = pinv(phi)*t;
end

