function [ Indexofx,T,itertimes ] = nothingskmeans( x, N, maxiter )
%��maxiter�ڷ���kmean����Ľ�� �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[numofx,numofs] = size(x);
itertimes = 0;
r = randperm(numofx);
T = x(r(1:N),:);%�����ʼ��������
tempT = zeros(N,numofs);
Indexofx = zeros(numofx,1);
Ck = cell(N,1);

while itertimes < maxiter
    itertimes = itertimes + 1;
    for i = 1:N
        Ck{i}=[];
    end
    for j = 1:numofx
        min = inf;
        index = 0;
        for i = 1:N
            distanceofxi = norm(x(j,:)-T(i,:));
            if distanceofxi < min
                min = distanceofxi;
                index = i;
            end
        end
        Ck{index} = [Ck{index},j];
    end

    for i = 1:N
        n = Ck{i};
        xc = x(n,:);
        tempT(i,:) = mean(xc);
    end
    if T == tempT
        break;
    else
        T = tempT;
    end
end
for i = 1:N
    n = Ck{i};
    Indexofx(n) = i;
end

    

end

