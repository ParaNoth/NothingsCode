function [ wk,wj,bk,bj,jt ] = nothingsbptrainer( Xp,Dp,nh,lr,e,maxiter )
%此函数为一层隐层的bp网络训练函数，网络函数均为sigmoid函数。输入Xp为样本矩阵，Dp为教师矩阵，nh为中间层神经元个数，lr为学习率，e为误差限，maxiter为最大迭代次数。输出wk为上层的权重矩阵，wj为下层的权重矩阵，jt为误差变化曲线。随机梯度下降。
%   此处显示详细说明
[x_num, sx_num] = size(Xp);
[y_num, sd_num] = size(Dp);
if x_num ~= y_num
    fprintf('sample numbers do not match!');
    wk=NaN;
    wj=NaN;
    jt=NaN;
    return;
end

wj=random('uniform',0,1,sx_num,nh);%下层权重
bj = random('uniform',0,1,1,nh);%下层偏置量
wk=random('uniform',0,1,nh,sd_num);%上层权重
bk=random('uniform',0,1,1,sd_num);%上层偏置量

jt = zeros(maxiter,1);
for i = 1:maxiter
    e1=0;
    for j = 1:x_num
        in1 = Xp(j,:)*wj-bj;
        out1 = 1./(1+exp(-in1));
        in2 = out1*wk-bk;
        out2 = in2;
        errorOut = Dp(j,:)-out2;
        errorYin=errorOut*wk'.*out1.*(1-out1);
        wk=wk+errorOut*out1'*lr;
        bk=bk-errorOut;
        wj=wj+Xp(j,:)'*errorYin*lr;
        bj=bj-errorYin;
        e1=e1+errorOut^2/2;
        
    end
    jt(i) = e1;
    if e1<e
        break;
    end
        
end
if e1 >= e
    fprintf('over max times');
end

end

