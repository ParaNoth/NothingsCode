function [ w,theta,jt ] = nothingsperceptrontrainer( Xp,Dp,lr,e,maxiter)
%感知器，Xp是输入样本，Dp是对应教师。w权值，theta是偏置。
%   此处显示详细说明
[xp_num, sx_num] = size(Xp);
[dp_num, sy_num] = size(Dp);
w = random('uniform',0,1,sy_num,sx_num);%权重
theta = random('uniform',0,1,sy_num,1);%偏置
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

