function [ w,theta,jt ] = nothingsperceptrontrainer( Xp,Dp,lr,e,maxiter)
%��֪����Xp������������Dp�Ƕ�Ӧ��ʦ��wȨֵ��theta��ƫ�á�
%   �˴���ʾ��ϸ˵��
[xp_num, sx_num] = size(Xp);
[dp_num, sy_num] = size(Dp);
w = random('uniform',0,1,sy_num,sx_num);%Ȩ��
theta = random('uniform',0,1,sy_num,1);%ƫ��
meanXp = mean(Xp);
Xpin = Xp - meanXp;
jt = zeros(maxiter,1);
for i = 1:maxiter
    out = Xpin*w'-theta;
    y = sign(out);
    J = 1/2*norm(Dp-y)^2;
    if J<e
        break;
    end
    
    dw = lr*(Dp-y)'*Xp;
    w = w+dw;
    theta = theta - mean(Dp-y);
    jt(i) = J;
end
theta = theta+w*meanXp';
if J>e
    fprintf("out of maxiter");
end
end

