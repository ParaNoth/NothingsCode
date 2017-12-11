clc;
clear all;
%%%%����BP���磬����һ�������Լ�һ������㣬�������Ԫ��ĿΪ1%%%%%
%%%%������Ԫ�����ΪX������������ƫ��thita%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%������ʼ�����%%%%%%%%
error=0.001;  %�趨�����ֵ
eta=0.01;       %������
J=1;              %Ŀ�꺯����ֵ�������壬���ڽ���ѭ��
neuron_number=40;%������Ԫ����

%%%%%%%%y=sin(x)%%%%%%%%%%
xtrain=(0.04*pi:0.04*pi:4*pi);                   %ѵ����
xtest1=(0.03*pi:0.04*pi:4*pi);                   %���Լ�
expect_value=sin(xtrain);       %����ֵ��Ҳ���ǽ�ʦ
train_number=length(xtrain);         %���Լ��������� 
test1_number=length(xtest1);

wj=rand(1,neuron_number)*0.1;    %���뵽�����ʼȨ��
wk=rand(neuron_number,1)*0.1;  %���㵽�����ʼȨ��
deltawj=zeros(1,neuron_number);  %��һ���ʼ�ݶ��½�ֵ
deltawk=zeros(neuron_number,1);  %�ڶ����ʼ�ݶ��½�ֵ
thitaj=rand(1,neuron_number)';
thitak=rand(1);
iter_cnt=0;                          %��ǰ��������
iter_max_cnt=100000;                  %����������
error_iter=zeros(1,iter_max_cnt);    %ÿ�ε���������
error_iter(1)=J;                     %��ʼ���ֵ
figure;
plot(xtrain,expect_value);title('ѵ����������');
hold on;
%%%%%%%%��ʼѵ��%%%%%%%%%%%%%%
while(J>error && iter_cnt<iter_max_cnt)
    iter_cnt=iter_cnt+1;
  for j=1:train_number
    uj=wj'*xtrain(j)-thitaj;
    h=1./(1+exp(-uj));
    uk=wk'*h-thitak;
    y(j)=uk;
    
    error_out=expect_value(j)-y(j);
    deltawk=error_out*h*eta;            %��������������Ȩֵ�½���
    thitak=thitak-eta*error_out;
    deltawj=error_out*wk'.*(h.*(1-h))'*xtrain(j)*eta;%����㵽����Ȩֵ�½�ֵ
    thitaj=thitaj-eta*error_out*wk.*(h.*(1-h));
    wk=wk+deltawk;
    wj=wj+deltawj;
  end 
    J=0.5*sum((expect_value-y).^2);                              %Ŀ�꺯��
    error_iter(iter_cnt)=J;
end


plot(xtrain,y,'rx');
hold off;
legend('ԭ����','�������');

%%%%%%%%����%%%%%%%%%%%%%%%%%
for k=1:test1_number
 uj1=wj'*xtest1(k)-thitaj;                        
 hj1=1./(1+exp(-uj1));
 uk1=wk'*hj1-thitak;
 y1(k)=uk1;
end

y_func1=sin(xtest1);               %ʵ�ʺ���ֵ

figure;
plot(xtest1,y_func1);title('���Լ�������');
hold on;
plot(xtest1,y1,'rx');
hold off;
legend('ԭ����','�������');

%%%%%%%%%�������%%%%%%%%%%%%%
for i=1:length(xtest1)
    test_delta(i)=y_func1(i)-y1(i);
end

figure;
plot(xtest1,test_delta);title('�������');


