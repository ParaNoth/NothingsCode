clearvars;
close all;

p0=16000;
qnum=6;

fprintf("solving question No.%d\n",qnum);
if qnum>=5
    [x0,y0,p]= getsample(qnum,p0/20);
    pieces=18;
    [xp,yp,zp,xn,yn,zn,piecepos,pieces]= getp3dsample2(x0,y0,pieces);
    offset=0.5;
%     hold on;
%     plot3(xp,yp,zp,'*');
%     plot3(xn,yn,zn,'*');
%     zp=z+offset;
%     zn=z-offset;
    dp=ones(size(zp));
    dn=-ones(size(zn));
    w=rand(pieces,3)'*.5;
    b=rand(pieces,1)'*.5;
    times=10000;
    yita1=0.17;
    yita2=0.17;
    offsetx=zeros(pieces,1);
    offsety=zeros(pieces,1);
    offsetz=zeros(pieces,1);
    for k=1:1:pieces
        offsetx(k)=xp(piecepos(k)+1);
        offsety(k)=yp(piecepos(k)+1);
        offsetz(k)=zp(piecepos(k)+1);
        xp(piecepos(k)+1:piecepos(k+1))=xp(piecepos(k)+1:piecepos(k+1))-offsetx(k);
        yp(piecepos(k)+1:piecepos(k+1))=yp(piecepos(k)+1:piecepos(k+1))-offsety(k);
        zp(piecepos(k)+1:piecepos(k+1))=zp(piecepos(k)+1:piecepos(k+1))-offsetz(k);
        xn(piecepos(k)+1:piecepos(k+1))=xn(piecepos(k)+1:piecepos(k+1))-offsetx(k);
        yn(piecepos(k)+1:piecepos(k+1))=yn(piecepos(k)+1:piecepos(k+1))-offsety(k);
        zn(piecepos(k)+1:piecepos(k+1))=zn(piecepos(k)+1:piecepos(k+1))-offsetz(k);
    end
    parfor k=1:1:pieces
        for j=1:1:times
            for i=piecepos(k)+1:1:piecepos(k+1)
                outp=w(:,k)'*[xp(i);yp(i);zp(i)]-b(k);
                errorp=(dp(i)-outp);
                b(k)=b(k)-errorp;
                w(:,k)=w(:,k)+((dp(i)-outp)*[xp(i);yp(i);zp(i)]*yita1);

                outn=w(:,k)'*[xn(i);yn(i);zn(i)]-b(k);
                errorn=(dn(i)-outn);
                b(k)=b(k)-errorn;
                w(:,k)=w(:,k)+((dn(i)-outn)*[xn(i);yn(i);zn(i)]*yita2);
            end
        end
        disp(k);
    end
    for k=1:1:pieces
        xp(piecepos(k)+1:piecepos(k+1))=xp(piecepos(k)+1:piecepos(k+1))+offsetx(k);
        yp(piecepos(k)+1:piecepos(k+1))=yp(piecepos(k)+1:piecepos(k+1))+offsety(k);
        zp(piecepos(k)+1:piecepos(k+1))=zp(piecepos(k)+1:piecepos(k+1))+offsetz(k);
        xn(piecepos(k)+1:piecepos(k+1))=xn(piecepos(k)+1:piecepos(k+1))+offsetx(k);
        yn(piecepos(k)+1:piecepos(k+1))=yn(piecepos(k)+1:piecepos(k+1))+offsety(k);
        zn(piecepos(k)+1:piecepos(k+1))=zn(piecepos(k)+1:piecepos(k+1))+offsetz(k);
        b(k)=b(k)+w(1,k)*offsetx(k)+w(2,k)*offsety(k)+w(3,k)*offsetz(k);
    end
    
    hold on; 
    [xx0,yy0,p]= getsample(qnum,round(p0/5));
    [xx,yy,pieceposx]= getp3dtest(xx0,yy0,piecepos);
    mycolor=[0 0.45 0.74;0.85 0.33 0.1;0.93 0.69 0.13;0.49 0.18 0.56;0.47 0.67 0.19;0.3 0.75 0.93;0.64 0.08 0.18];
    for i=1:1:pieces
%         plot3(xx(piecepos(i)+1:piecepos(i+1),1),xx(piecepos(i)+1:piecepos(i+1),2),xx(piecepos(i)+1:piecepos(i+1),3),'go');
        xxx1=xx(pieceposx(i)+1:pieceposx(i+1));
        yyy1=yy(pieceposx(i)+1:pieceposx(i+1));
        zzz1=(b(i)-w(1,i)*xxx1-w(2,i)*yyy1)/w(3,i);
        nowcolor=mycolor(randi(7),:);
        h=plot3(xxx1,yyy1,zzz1,'*');
        h.Color=nowcolor;
%         stem3(xxx1,yyy1,zzz1,'filled')
%         patch3(xxx1,yyy1,zzz1);
        rx=max(xxx1)-min(xxx1);ry=max(yyy1)-min(yyy1);rz=max(zzz1)-min(zzz1);n=size(length(xxx1),3);
        [xxxx,yyyy]=meshgrid(min(xxx1):rx/100:max(xxx1),min(yyy1):ry/100:max(yyy1));
        zzzz=(b(i)-w(1,i)*xxxx-w(2,i)*yyyy)/w(3,i);
        h=surf(xxxx,yyyy,zzzz);
        h.EdgeAlpha=0;
        h.FaceColor=nowcolor;
        h.FaceAlpha=0.5;
    end
    xlim([-3.5 3.5]);
    ylim([-3.5 3.5]);
    zlim([0 3.5]);
%         hold on;
%     plot3(xp,yp,zp,'r*');
%     plot3(xn,yn,zn,'b*');

    
%     for i=1:1:pieces
% %         plot3(xx(piecepos(i)+1:piecepos(i+1),1),xx(piecepos(i)+1:piecepos(i+1),2),xx(piecepos(i)+1:piecepos(i+1),3),'go');
%         xx1=x(piecepos(i)+1:piecepos(i+1));
%         yy1=y(piecepos(i)+1:piecepos(i+1));
%         zz1=(b(i)-w(1,i)*xx1-w(2,i)*yy1)/w(3,i);
%         h=plot3(xx1,yy1,zz1,'*');
%     end

    
    
    
    
else
    [x0,y0,p]= getsample(qnum,p0);
    pieces=50;
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



