function [wk,wj,bk,bj,jt] = nothingsbptrainer1( Xp,Dp,nh,lr,e,maxiter )
%此函数为一层隐层的bp网络训练函数，网络函数为sigmoid函数和线性函数。输入Xp为样本矩阵，Dp为教师矩阵，nh为中间层神经元个数，lr为学习率，e为误差限，maxiter为最大迭代次数。输出wk为上层的权重矩阵，wj为下层的权重矩阵，jt为误差变化曲线。批梯度下降。
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
    in1 = Xp*wj-bj.*ones(x_num,1);
    h = logsig(in1);
    in2 = h*wk-bk;
    y = in2;
    errorOut = Dp-y;
    errorYin=errorOut*wk'.*h.*(1-h);
    wk=wk+h'*errorOut*lr;
    bk=bk-mean(errorOut);
    wj=wj+Xp'*errorYin*lr;
    bj=bj-mean(errorYin);
    e1=0.5*norm(Dp-y)^2;
    jt(i)=e1;
    if e1<e
        break;
    end
end
if e1 >= e
    fprintf('over max times');
end


end

