function [x,y,p]= getsample(qnum,p)

if qnum==1
    x=linspace(1,100,p)';
    y=1./sqrt(x);
elseif qnum==2
    x=linspace(0,4*pi,p)';
    y=sin(x);
elseif qnum==3
	x=linspace(-4*pi,4*pi,p)';
    y=(sin(x)./x).^2;
elseif qnum==4
    x=linspace(-4*pi,4*pi,p)';
    y=exp(-x.^2).*sin(x.^2);
elseif qnum==5
    p=round(p/20);
    r=sqrt(10);
    Theta=linspace(0,0.5*pi,p)';
    Phi=linspace(0,2*pi,4*p)';
    x=r*sin(Theta)*cos(Phi)';
    y=r*sin(Theta)*sin(Phi)';
    z=sqrt(abs(10-x.^2-y.^2));
    x=[x(:) y(:)];
    y=z(:);
    p=length(x);
elseif qnum==6
    p=round(p/20);
    offset=0.1;
    Theta=linspace(0,0.5*pi,2*p)';
    Phi=linspace(0,2*pi,2*p)';
    
    r=sqrt(10-offset);
    x0=r*sin(Theta)*cos(Phi)';
    y0=r*sin(Theta)*sin(Phi)';
    z0=sqrt(abs(10-x0.^2-y0.^2));
    
    r=sqrt(10+offset);
    x1=r*sin(Theta)*cos(Phi)';
    y1=r*sin(Theta)*sin(Phi)';
    z1=sqrt(abs(10-x0.^2-y0.^2));
    
    x=[x0(:) y0(:);x1(:) y1(:)];
    y=[z0(:);z1(:)];
    
    p=length(x);
elseif qnum==7
    x1=linspace(-sqrt(10),sqrt(10),p)';
    x2=linspace(-sqrt(10),sqrt(10),p)';
    x=zeros(p*p,2);
    y=zeros(p*p,1);
    count=0;
    for i=1:1:length(x1)
        for j=1:1:length(x2)
            if(x1(i)^2+x2(j)^2<=10)
                count=count+1;
                x(count,:)=[x1(i) x2(j)];
                y(count)=sqrt(10-(x1(i)^2+x2(j)^2));
            end
        end
    end
    x=x(1:count,:);
    y=y(1:count);
    p=length(x);
%     x1ap=linspace(-sqrt(10),sqrt(10),p)';
%     x2ap=abs(sqrt(10-(x1ap.^2)));
%     x=[x;x1ap x2ap;x1ap -x2ap;0 0];
%     y=[y;zeros(2*length(x1ap),1);sqrt(10)];
elseif qnum==-1
	x=linspace(-4*pi,4*pi,p)';
    y=repmat([1;0],p/2,1);
end
end