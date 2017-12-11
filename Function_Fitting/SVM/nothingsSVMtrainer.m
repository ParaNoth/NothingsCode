function [ b0 ,ap ] = nothingsSVMtrainer(xp,dp,sigma)
% 此SVM训练函数输入：xp样本，dp标签，sigma高斯核的方差。返回拉格朗日乘子ap与偏置b0
%   此处显示详细说明
[xp_num,~]=size(xp);
dp_len = length(dp);
b0 = 0;
ap = 0;
if xp_num~=dp_len
    return;
end
K = zeros(xp_num,xp_num);%生成核矩阵
C = zeros(xp_num,xp_num);%生成C矩阵
for i = 1:xp_num
    for j = 1:xp_num
        K(i,j)=exp(-norm(xp(i,:)-xp(j,:))^2/(2*sigma*sigma));
        C(i,j)=dp(i)*dp(j)*K(i,j);
    end
end
%ap = pinv(C)*ones(xp_num,1);
ap = pinv(C)*ones(xp_num,1);
support_pos = find(ap>0);
b0 = 1/dp(support_pos(1))-ap'.*dp'*K(:,support_pos(1));%
end

