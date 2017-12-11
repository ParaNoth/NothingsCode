clearvars;
close all;

p0=1000;
qnum=7;

fprintf("solving question No.%d\n",qnum);
if qnum>=5
    [x0,y0,p]= getsample(qnum,p0/20);
    pieces=20;
    [x,y,z,piecepos,pieces]= getp3dsample(x0,y0,pieces);
    offset=0.5;
    zp=z+offset;
    zn=z-offset;
    dp=ones(size(zp));
    dn=-ones(size(zn));
    w=rand(pieces,3)'*.5;
    b=rand(pieces,1)'*.5;
    times=5000;
    yita1=0.07;
    yita2=0.07;
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
    
    mycolor=[0 0.45 0.74;0.85 0.33 0.1;0.93 0.69 0.13;0.49 0.18 0.56;0.47 0.67 0.19;0.3 0.75 0.93;0.64 0.08 0.18];
    if(1==0)%draw ball
        hold on; 
        f = @(x0,y0,z0) (x0.^2+y0.^2+z0.^2)-10;      % 函数表达式
        [x0,y0,z0] = meshgrid(-10:.2:10,-10:.2:10,0:.2:10);       % 画图范围
        v = f(x0,y0,z0);
        h = patch(isosurface(x0,y0,z0,v,0)); 
        isonormals(x0,y0,z0,v,h)              
        set(h,'EdgeColor','none');
        alpha(0.01)   
        h.FaceColor=[0 1 0];
    end
    if(1==0)%draw meshed whole graph
        hold on;
        [xxx,yyy]=meshgrid(-sqrt(10):0.01:sqrt(10),-sqrt(10):0.01:sqrt(10));
        zzz=NaN*zeros(size(xxx));
        for i=1:1:length(xxx(1,:))
            for j=1:1:length(xxx(:,1))
                x=xxx(i,j);
                y=yyy(i,j);
                thispos=find(piecepos(:,2)<x & piecepos(:,3)>x & piecepos(:,4)<y & piecepos(:,5)>y)-1;
                if isempty(thispos)
                    continue
                end
                z=(b(thispos)-w(1,thispos)*x-w(2,thispos)*y)/w(3,thispos);
                zzz(i,j)=z;
            end
        end
        hold on; 
        h=surf(xxx,yyy,zzz);
        h.EdgeAlpha=0.02;
        h.FaceColor=mycolor(randi(7),:);
        h.FaceAlpha=0.5;
        xlim([-3.5 3.5]);
        ylim([-3.5 3.5]);
        zlim([0 3.5]);
    end
    if(1==0)%draw all points
        hold on;
        [xx0,yy0,~]= getsample(qnum,round(p0/20));
        [xx,yy,~]= getp3dtest(xx0,yy0,piecepos);
        zz=NaN*zeros(size(xx));
        for i=1:1:length(xx)
            x=xx(i);
            y=yy(i);
                thispos=find(piecepos(:,2)<x & piecepos(:,3)>x & piecepos(:,4)<y & piecepos(:,5)>y)-1;
                if isempty(thispos)
                    continue
                end
                z=(b(thispos)-w(1,thispos)*x-w(2,thispos)*y)/w(3,thispos);
            zz(i)=z;
        end
        plot3(xx,yy,zz,'r*');
        xlim([-3.5 3.5]);
        ylim([-3.5 3.5]);
        zlim([0 3.5]);
    end
    if(1==1)%standard draw
        hold on;
        [xx0,yy0,p]= getsample(qnum,round(p0/20));
        [xx,yy,pieceposx]= getp3dtest(xx0,yy0,piecepos);
        for i=1:1:pieces
            xxx1=xx(pieceposx(i)+1:pieceposx(i+1));
            yyy1=yy(pieceposx(i)+1:pieceposx(i+1));
            zzz1=(b(i)-w(1,i)*xxx1-w(2,i)*yyy1)/w(3,i);
            nowcolor=mycolor(randi(7),:);
            h=plot3(xxx1,yyy1,zzz1,'*');
            h.Color=nowcolor;
            rx=max(xxx1)-min(xxx1);ry=max(yyy1)-min(yyy1);rz=max(zzz1)-min(zzz1);n=size(length(xxx1),3);
            [xxxx,yyyy]=meshgrid(min(xxx1):rx/100:max(xxx1),min(yyy1):ry/100:max(yyy1));
            zzzz=(b(i)-w(1,i)*xxxx-w(2,i)*yyyy)/w(3,i);
            h=surf(xxxx,yyyy,zzzz);
            h.EdgeAlpha=0;
            h.FaceColor=nowcolor;
            h.FaceAlpha=0.6;
        end
    end
else
    [x0,y0,p]= getsample(qnum,p0);
    pieces=100;
    x = reshape(x0, [], pieces);
    y = reshape(y0, [], pieces);
    offset=0.1;
    yp=y+offset;
    dp=ones(size(yp));
    yn=y-offset;
    dn=-ones(size(yn));
    % hold on;
    % for i=1:1:pieces
    %     plot(x(:,i),y(:,i));
    % end
    w=rand(pieces,2)'*.5;
    b=rand(pieces,1)'*.5;
    times=4000;
    yita1=0.07;
    yita2=0.07;
    lenx=length(x(:,1));
    tic;
    offsetx=zeros(pieces,1);
    for k=1:1:pieces
        offsetx(k)=x(1,k);
        x(:,k)=x(:,k)-offsetx(k);
    end
    parfor k=1:1:pieces
        for j=1:1:times
            for i=1:1:lenx
                outp=w(:,k)'*[x(i,k);yp(i,k)]-b(k);
                errorp=(dp(i,k)-outp);
                b(k)=b(k)-errorp;
                w(:,k)=w(:,k)+((dp(i,k)-outp)*[x(i,k),yp(i,k)]*yita1)';

                outn=w(:,k)'*[x(i,k);yn(i,k)]-b(k);
                errorn=(dn(i,k)-outn);
                b(k)=b(k)-errorn;
                w(:,k)=w(:,k)+((dn(i,k)-outn)*[x(i,k),yn(i,k)]*yita2)';
            end
        end
        disp(k);
    end
    for k=1:1:pieces
        x(:,k)=x(:,k)+offsetx(k);
        b(k)=b(k)+w(1,k)*offsetx(k);
    end
    toc;
    hold on;
    plot(x,yp,'r*');
    plot(x,yn,'b*');
    for i=1:1:pieces
        xx=x(:,i);
        yy=b(i)/w(2,i)-w(1,i)/w(2,i)*xx;
        plot(xx,yy);
    end
end



