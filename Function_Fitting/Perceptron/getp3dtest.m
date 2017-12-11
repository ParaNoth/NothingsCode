function [x,y,pieceposnew]= getp3dtest(x0,y0,piecepos)
    minx=min(min(x0));
    delta=(min(x0(x0>minx))-minx)*1.5;
    piecedge=piecepos(:,2:5);
    pieceposnew=zeros(size(piecepos));
    pieces=length(piecepos(:,1));
    xx=[];
    piececount=1;
    x0=[x0,y0];
    for i=2:1:pieces
        tmp=x0(x0(:,1)>piecedge(i,1) & x0(:,1)<piecedge(i,2) & x0(:,2)>piecedge(i,3) & x0(:,2)<piecedge(i,4),:);

%         tmp=x0(x0(:,1)>(piecedge(i,1)-delta) & x0(:,1)<(piecedge(i,2)+delta) & x0(:,2)>(piecedge(i,3)-delta) & x0(:,2)<(piecedge(i,4)+delta),:);
        if isempty(tmp(:,1))
            disp("error!")
            continue
        end
        piececount=piececount+1;
        xx=[xx;tmp];
        pieceposnew(piececount,1)=[length(xx(:,1))];
    end
    pieces=piececount-1;
    x=[];
    y=[];
    for i=1:1:pieces
        x=[x;xx(pieceposnew(i)+1:pieceposnew(i+1),1)];
        y=[y;xx(pieceposnew(i)+1:pieceposnew(i+1),2)];
    end
end