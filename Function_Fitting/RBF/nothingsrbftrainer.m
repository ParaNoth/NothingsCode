function [ w,phi,rbfs_mean,rbfs_varible ] = nothingsrbftrainer( x,t,N )
%xΪ���������tΪ��ʦ��NΪRBF���ĸ�����wΪ���Ȩֵ��phiΪ�����ĺ˾���,rbfs_meanΪ������� �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[~,x_num] = size(x);
[~,len_t] = size(t);
if x_num~=len_t
    fprintf('sample numbers does not match!');
    return;
end

[Idx,T,itertimes]=nothingskmeans(x,N,1000);
itertimes
%�ɾ�������x���ֵ�ͷ���
meanofx = zeros(N,x_num);

meanoftempx = 1;
lastofmean = 1;
dmax = 0;
for i = 1:N
    %��ȡÿ��Ԫ�ص�����
    lastofmean = meanoftempx;
    meanoftempx = T(i,:);
    dmax = max(dmax, abs(meanoftempx - lastofmean));
end

rbfs_varible = dmax/sqrt(N);
%���ɺ˾���
phi = nothingsRBFvector(x, T, rbfs_varible);
%��ȡw
%w = inv(phi'*phi)*phi'*t;
rbfs_mean = T;
w = pinv(phi)*t;
end

