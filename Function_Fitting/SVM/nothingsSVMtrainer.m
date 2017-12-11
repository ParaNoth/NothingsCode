function [ b0 ,ap ] = nothingsSVMtrainer(xp,dp,sigma)
% ��SVMѵ���������룺xp������dp��ǩ��sigma��˹�˵ķ�������������ճ���ap��ƫ��b0
%   �˴���ʾ��ϸ˵��
[xp_num,~]=size(xp);
dp_len = length(dp);
b0 = 0;
ap = 0;
if xp_num~=dp_len
    return;
end
K = zeros(xp_num,xp_num);%���ɺ˾���
C = zeros(xp_num,xp_num);%����C����
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

