function [ g ] = nothingsSVMtester(b0,ap,xp,dp,sigma,xt)
%UNTITLED16 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[xp_num,~]=size(xp);
[xt_num,~]=size(xt);

Kt = zeros(xt_num,xp_num);
for i = 1:xt_num
    for j = 1:xp_num
        Kt(i,j) = exp(-norm(xt(i,:)-xp(j,:))^2/(2*sigma*sigma));
    end
end
g = sign(Kt*(ap.*dp)+b0);
end

