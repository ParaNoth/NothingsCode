clearvars;
close all;

p=1200;
qnum=7;
knotNum=200;

fprintf("solving question No.%d\n",qnum);
if qnum>=5
    disp("i don't know how to solve this fucking shit quesition. exit.")
    [x0,y0,p]= getsample(qnum,p/20);
    pieces=18;
    piecedge=linspace(-sqrt(10),sqrt(10),pieces+1);
    piecepos=zeros(pieces*pieces,1);
    xx=[];
    piececount=1;
    x0=[x0,y0];
    for i=1:1:pieces
        for j=1:1:pieces
            tmp=x0(x0(:,1)>piecedge(i) & x0(:,1)<piecedge(i+1) & x0(:,2)>piecedge(j) & x0(:,2)<piecedge(j+1),:);
            if isempty(tmp(:,1))
                continue
            end
            piececount=piececount+1;
            xx=[xx;tmp];
            piecepos(piececount)=length(xx(:,1));
        end
    end
    pieces=piececount-1;
    x=[];
    y=[];
    z=[];
    hold on;
    for i=1:1:pieces
        x=[x;xx(piecepos(i)+1:piecepos(i+1),1)];
        y=[y;xx(piecepos(i)+1:piecepos(i+1),2)];
        z=[z;xx(piecepos(i)+1:piecepos(i+1),3)];
    end
    offset=0.5;
    zp=z+offset;
    zn=z-offset;
    dp=ones(size(zp));
    dn=-ones(size(zn));
    w=rand(pieces,3)'*.5;
    b=rand(pieces,1)'*.5;
    times=5000;
    yita1=0.02;
    yita2=0.02;
    offsetx=zeros(pieces,1);
    offsety=zeros(pieces,1);
    for k=1:1:pieces
        offsetx(k)=x(piecepos(k)+1);
        offsety(k)=y(piecepos(k)+1);
        x(piecepos(k)+1:piecepos(k+1))=x(piecepos(k)+1:piecepos(k+1))-offsetx(k);
        y(piecepos(k)+1:piecepos(k+1))=y(piecepos(k)+1:piecepos(k+1))-offsety(k);
    end
    parfor k=1:1:pieces
        for j=1:1:times
            for i=piecepos(k)+1:1:piecepos(k+1)
                outp=w(:,k)'*[x(i);y(i);zp(i)]-b(k);
                errorp=(dp(i)-outp);
                b(k)=b(k)-errorp;
                w(:,k)=w(:,k)+((dp(i)-outp)*[x(i);y(i);zp(i)]*yita1);

                outn=w(:,k)'*[x(i);y(i);zn(i)]-b(k);
                errorn=(dn(i)-outn);
                b(k)=b(k)-errorn;
                w(:,k)=w(:,k)+((dn(i)-outn)*[x(i);y(i);zn(i)]*yita2);
            end
        end
        disp(k);
    end
    for k=1:1:pieces
        x(piecepos(k)+1:piecepos(k+1))=x(piecepos(k)+1:piecepos(k+1))+offsetx(k);
        y(piecepos(k)+1:piecepos(k+1))=y(piecepos(k)+1:piecepos(k+1))+offsety(k);
        b(k)=b(k)+w(1,k)*offsetx(k)+w(2,k)*offsety(k);
    end
    
    hold on;
    for i=1:1:pieces
%         plot3(xx(piecepos(i)+1:piecepos(i+1),1),xx(piecepos(i)+1:piecepos(i+1),2),xx(piecepos(i)+1:piecepos(i+1),3),'go');
        xx1=x(piecepos(i)+1:piecepos(i+1));
        yy1=y(piecepos(i)+1:piecepos(i+1));
        zz1=(b(i)-w(1,i)*xx1-w(2,i)*yy1)/w(3,i);
        h=plot3(xx1,yy1,zz1,'*');
        
%         lenxx=length(xx1);
%         if lenxx<=1
%             plot3(xx1,yy1,zz1,'*');
%             continue
%         end
%         xxnew=interp1(1:1:lenxx,xx1,1:0.02:lenxx);
%         yynew=interp1(1:1:lenxx,yy1,1:0.02:lenxx);
%         zznew=(b(i)-w(1,i)*xxnew-w(2,i)*yynew)/w(3,i);
%         h=plot3(xxnew,yynew,zznew,'*');
%         
%         lenxx=length(xx1);
%         xxnew=linspace(min(xx1),max(xx1),10*lenxx);
%         yynew=linspace(min(yy1),max(yy1),10*lenxx);
%         zznew=(b(i)-w(1,i)*xxnew-w(2,i)*yynew)/w(3,i);
%         h=plot3(xxnew,yynew,zznew,'*');
    end
    
end
    
