clc;
clear;
%生成训练集
SNR = [-50:1:20];
loss = [-50:1:20];
l = length(SNR);
    x1=[1,1,1,1,-1,-1,-1,-1];
    x2=[1,1,-1,-1,1,1,-1,-1];
    x3=[1,-1,1,-1,1,-1,1,-1];
    Xp = [x1',x2',x3'];
    Dp = x1'.*x2'.*x3'; %三维同或和三维异或的结果是一样的。
for i = 1:l
    %开始训练SVM
    d = 8;
    [b0,ap] = nothingsSVMtrainer(Xp,Dp,d);
    Xp_noise = [Xp;Xp;Xp;Xp;Xp;Xp];
    Xp_noise = awgn(Xp_noise,SNR(i));
    yt = nothingsSVMtester(b0,ap,Xp,Dp,d,Xp_noise);
    Dpt = [Dp;Dp;Dp;Dp;Dp;Dp];
    loss(i) = sum(Dpt-yt~=0);
end
plot(SNR,loss);
title('SNR的影响')
xlabel('SNR')
ylabel('错误个数')