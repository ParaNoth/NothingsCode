function [ w,phi,rbfs_mean,rbfs_varible ] = nothingsrbftrainer1( x,t,N )
%xΪ���������tΪ��ʦ��NΪRBF���ĸ�����wΪ���Ȩֵ��phiΪ�����ĺ˾���,rbfs_meanΪ�������,����ʹ��matlab�ڽ�������
%   �˴���ʾ��ϸ˵��
[x_num,s_num] = size(x);
[len_t,~] = size(t);
if x_num~=len_t
    fprintf('sample numbers does not match!');
    return;
end

[Idx,C]=kmeans(x,N);
%�ɾ�������x���ֵ�ͷ���
rbfs_mean = zeros(N,s_num);
meanoftempx = C(1,:);
dmax = 0;
for i = 1:N
    %��ȡÿ��Ԫ�ص�����
    lastofmean = meanoftempx;
    meanoftempx = C(i,:);
    dmax = max(dmax, norm(meanoftempx'-lastofmean'));
    %�����Ӧλ��
    rbfs_mean(i,:) = meanoftempx;
end

rbfs_varible = dmax/sqrt(N);
%���ɺ˾���
phi = nothingsRBFvector(x, rbfs_mean, rbfs_varible);
%��ȡw
%w = inv(phi'*phi)*phi'*t;
w = pinv(phi)*t;
end


