function [ wk,wj,bk,bj,jt ] = nothingsbptrainer( Xp,Dp,nh,lr,e,maxiter )
%�˺���Ϊһ�������bp����ѵ�����������纯����Ϊsigmoid����������XpΪ��������DpΪ��ʦ����nhΪ�м����Ԫ������lrΪѧϰ�ʣ�eΪ����ޣ�maxiterΪ���������������wkΪ�ϲ��Ȩ�ؾ���wjΪ�²��Ȩ�ؾ���jtΪ���仯���ߡ�����ݶ��½���
%   �˴���ʾ��ϸ˵��
[x_num, sx_num] = size(Xp);
[y_num, sd_num] = size(Dp);
if x_num ~= y_num
    fprintf('sample numbers do not match!');
    wk=NaN;
    wj=NaN;
    jt=NaN;
    return;
end

wj=random('uniform',0,1,sx_num,nh);%�²�Ȩ��
bj = random('uniform',0,1,1,nh);%�²�ƫ����
wk=random('uniform',0,1,nh,sd_num);%�ϲ�Ȩ��
bk=random('uniform',0,1,1,sd_num);%�ϲ�ƫ����

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

