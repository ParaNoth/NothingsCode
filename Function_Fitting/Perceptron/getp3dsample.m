function [x,y,z,piecepos,pieces]= getp3dsample(x0,y0,pieces)
    piecedge=linspace(-sqrt(10),sqrt(10),pieces+1);
    delta=(piecedge(2)-piecedge(1))/5;
    piecepos=zeros(pieces*pieces,5);
    xx=[];
    piececount=1;
    x0=[x0,y0];
    for i=1:1:pieces
        for j=1:1:pieces
            suoyin=find((x0(:,1)>=piecedge(i) & x0(:,1)<piecedge(i+1) & x0(:,2)>=piecedge(j) & x0(:,2)<piecedge(j+1))>0);
            if isempty(suoyin)
                continue
            end
            if length(suoyin)<3
                suoyin=find((x0(:,1)>=(piecedge(i)-delta*5) & x0(:,1)<(piecedge(i+1)+delta*5) & x0(:,2)>=(piecedge(j)-delta*5) & x0(:,2)<(piecedge(j+1)+delta*5)) >0);
            elseif length(suoyin)<7
                suoyin=find((x0(:,1)>=(piecedge(i)-delta*2) & x0(:,1)<(piecedge(i+1)+delta*2) & x0(:,2)>=(piecedge(j)-delta*2) & x0(:,2)<(piecedge(j+1)+delta*2)) >0);
            else
                suoyin=find((x0(:,1)>=(piecedge(i)-delta) & x0(:,1)<(piecedge(i+1)+delta) & x0(:,2)>=(piecedge(j)-delta) & x0(:,2)<(piecedge(j+1)+delta)) >0);
            end
            tmp=x0(suoyin,:);
            
            piececount=piececount+1;
            xx=[xx;tmp];
            piecepos(piececount,:)=[length(xx(:,1)) piecedge(i) piecedge(i+1) piecedge(j) piecedge(j+1)];
        end
    end
    piecepos=piecepos(1:piececount,:);
    pieces=piececount-1;
    x=[];
    y=[];
    z=[];
    for i=1:1:pieces
        x=[x;xx(piecepos(i)+1:piecepos(i+1),1)];
        y=[y;xx(piecepos(i)+1:piecepos(i+1),2)];
        z=[z;xx(piecepos(i)+1:piecepos(i+1),3)];
    end
end