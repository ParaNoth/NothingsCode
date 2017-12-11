clc;
clear;
%����ѵ����
SNR = [-50:1:20];
loss = [-50:1:20];
l = length(SNR);
    x1=[1,1,1,1,-1,-1,-1,-1];
    x2=[1,1,-1,-1,1,1,-1,-1];
    x3=[1,-1,1,-1,1,-1,1,-1];
    Xp = [x1',x2',x3'];
    Dp = x1'.*x2'.*x3'; %��άͬ�����ά���Ľ����һ���ġ�
for i = 1:l
    %��ʼѵ��SVM
    d = 8;
    [b0,ap] = nothingsSVMtrainer(Xp,Dp,d);
    Xp_noise = [Xp;Xp;Xp;Xp;Xp;Xp];
    Xp_noise = awgn(Xp_noise,SNR(i));
    yt = nothingsSVMtester(b0,ap,Xp,Dp,d,Xp_noise);
    Dpt = [Dp;Dp;Dp;Dp;Dp;Dp];
    loss(i) = sum(Dpt-yt~=0);
end
plot(SNR,loss);
title('SNR��Ӱ��')
xlabel('SNR')
ylabel('�������')