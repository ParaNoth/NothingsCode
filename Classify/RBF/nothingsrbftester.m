function [ y ] = nothingsrbftester( w,rbfs_mean,rbfs_varible,xt )
%����Ϊw��Ȩ��ϵ����rbfs_meanΪ��rbf�����ģ�rbfs_varibleΪrbf�ķ��xtΪ���Լ��������Ϊy
%   �˴���ʾ��ϸ˵��
phi = nothingsRBFvector(xt, rbfs_mean, rbfs_varible);
y = phi*w;
end

