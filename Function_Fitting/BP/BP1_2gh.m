clc;
clear all;
%%%%两层BP网络，包含一层隐层以及一层输出层，输出层神经元数目为1%%%%%
%%%%隐层神经元输入均为X变量，均考虑偏差thita%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%变量初始化语句%%%%%%%%
error=0.001;  %设定误差阈值
eta=0.01;       %步长η
J=1;              %目标函数初值，无意义，用于进入循环
neuron_number=40;%隐层神经元数量

%%%%%%%%y=sin(x)%%%%%%%%%%
xtrain=(0.04*pi:0.04*pi:4*pi);                   %训练集
xtest1=(0.03*pi:0.04*pi:4*pi);                   %测试集
expect_value=sin(xtrain);       %期望值，也就是教师
train_number=length(xtrain);         %测试集数据数量 
test1_number=length(xtest1);

wj=rand(1,neuron_number)*0.1;    %输入到隐层初始权重
wk=rand(neuron_number,1)*0.1;  %隐层到输出初始权重
deltawj=zeros(1,neuron_number);  %第一层初始梯度下降值
deltawk=zeros(neuron_number,1);  %第二层初始梯度下降值
thitaj=rand(1,neuron_number)';
thitak=rand(1);
iter_cnt=0;                          %当前迭代次数
iter_max_cnt=100000;                  %最大迭代次数
error_iter=zeros(1,iter_max_cnt);    %每次迭代后的误差
error_iter(1)=J;                     %初始误差值
figure;
plot(xtrain,expect_value);title('训练集输出结果');
hold on;
%%%%%%%%开始训练%%%%%%%%%%%%%%
while(J>error && iter_cnt<iter_max_cnt)
    iter_cnt=iter_cnt+1;
  for j=1:train_number
    uj=wj'*xtrain(j)-thitaj;
    h=1./(1+exp(-uj));
    uk=wk'*h-thitak;
    y(j)=uk;
    
    error_out=expect_value(j)-y(j);
    deltawk=error_out*h*eta;            %隐层输出到输出层权值下降量
    thitak=thitak-eta*error_out;
    deltawj=error_out*wk'.*(h.*(1-h))'*xtrain(j)*eta;%输入层到隐层权值下降值
    thitaj=thitaj-eta*error_out*wk.*(h.*(1-h));
    wk=wk+deltawk;
    wj=wj+deltawj;
  end 
    J=0.5*sum((expect_value-y).^2);                              %目标函数
    error_iter(iter_cnt)=J;
end


plot(xtrain,y,'rx');
hold off;
legend('原函数','网络输出');

%%%%%%%%测试%%%%%%%%%%%%%%%%%
for k=1:test1_number
 uj1=wj'*xtest1(k)-thitaj;                        
 hj1=1./(1+exp(-uj1));
 uk1=wk'*hj1-thitak;
 y1(k)=uk1;
end

y_func1=sin(xtest1);               %实际函数值

figure;
plot(xtest1,y_func1);title('测试集输出结果');
hold on;
plot(xtest1,y1,'rx');
hold off;
legend('原函数','网络输出');

%%%%%%%%%计算误差%%%%%%%%%%%%%
for i=1:length(xtest1)
    test_delta(i)=y_func1(i)-y1(i);
end

figure;
plot(xtest1,test_delta);title('测试误差');


