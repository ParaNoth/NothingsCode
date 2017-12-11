clc;
clear;
%生成训练集
SNR = [-50:1:20];
loss = [-50:1:20];
l = length(SNR);
for i = 1:l
    x1=[1,1,1,1,-1,-1,-1,-1];
    x2=[1,1,-1,-1,1,1,-1,-1];
    x3=[1,-1,1,-1,1,-1,1,-1];
    Xp = [x1',x2',x3'];
    Xp_noise = [Xp;Xp;Xp;Xp;Xp;Xp];
    Xp_noise = awgn(Xp_noise,SNR(i));
    Dp = x1'.*x2'.*x3'; %三维同或和三维异或的结果是一样的。
    Dp_noise = [Dp;Dp;Dp;Dp;Dp;Dp];
    Dp_noise = awgn(Dp_noise,SNR(i));
    %开始训练SVM
    sigma = 4;
    [b0,ap] = nothingsSVMtrainer(Xp,Dp,sigma);
    Xp_noise = [Xp;Xp;Xp;Xp;Xp;Xp];
    Xp_noise = awgn(Xp_noise,SNR(i));
    yt = nothingsSVMtester(b0,ap,Xp,Dp,sigma,Xp_noise);
    Dpt = [Dp;Dp;Dp;Dp;Dp;Dp];
    loss(i) = sum(Dpt-yt~=0);
end
figure,plot(SNR,loss);
title('SNR的影响')
xlabel('SNR')
ylabel('错误个数')