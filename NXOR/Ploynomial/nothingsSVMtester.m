function [ g ] = nothingsSVMtester(b0,ap,xp,dp,d,xt)
%UNTITLED16 此处显示有关此函数的摘要
%   此处显示详细说明
[xp_num,~]=size(xp);
[xt_num,~]=size(xt);

Kt = zeros(xt_num,xp_num);
for i = 1:xt_num
    for j = 1:xp_num
        Kt(i,j) = (xt(i,:)*xp(j,:)'+1)^d;
    end
end
g = sign(Kt*(ap.*dp)+b0);
end

