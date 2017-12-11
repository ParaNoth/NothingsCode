function [wk,wj,bk,bj,jt] = nothingsbptrainer1( Xp,Dp,nh,lr,e,maxiter )
%�˺���Ϊһ�������bp����ѵ�����������纯��Ϊsigmoid���������Ժ���������XpΪ��������DpΪ��ʦ����nhΪ�м����Ԫ������lrΪѧϰ�ʣ�eΪ����ޣ�maxiterΪ���������������wkΪ�ϲ��Ȩ�ؾ���wjΪ�²��Ȩ�ؾ���jtΪ���仯���ߡ����ݶ��½���
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

