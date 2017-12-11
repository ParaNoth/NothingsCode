function [ X ] = nothingsRBFvector(x, rbfs_mean, rbfs_varible)
%����һ��RBFֵ������meanΪRBF��������������varibleΪRBF���ķ����xΪ����������һ������������xΪnά��ʸ�����򷵻�һ������������ɵľ���.meanΪ��ʸ��,��varibleΪ���� �˴���ʾ�йش˺�����ժҪ
%   xΪһ������,
[sizeofx,~] = size(x);
[lenofmean,~] = size(rbfs_mean);
if sizeofx >= 1
    tempx = zeros(1,lenofmean);
    X = zeros(sizeofx,lenofmean);
    for i = 1:sizeofx
        for j = 1:lenofmean
            tempx(j)=exp(-norm(x(i,:)'-rbfs_mean(j,:)')^2/rbfs_varible/2);
        end
        X(i,:)=tempx;
    end
else
    X = 0;
end
end

