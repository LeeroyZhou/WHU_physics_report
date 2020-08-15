%% Description

% 1. This function returns the objective functions f1, and f2 in the vector 'fit' and
%    constraints in the vector 'c' for the chromosome 'x'. 
% 2. 'V' is the number of optimization variables. 
% 3. All the constraints 'c' are converted to the form h(x)<=0. 
% 4. Nine unconstrained test probems are used (p=1 to p=9)
% 5. Five constrained test problems are used   (p=10 to p=14)
% 6. Refer above references for the details of each test problem: number of objectives, number of design variabes, their lower and upper limits, 
%    number of constraints, type of constraints etc,.

%% reference
% 1. BINH, Thanh. "A multiobjective evolutionary algorithm. The study cases".
%    Technical report. Barleben, Germany. 1999.
% 2. DEB, Kalyanmoy. "Multi-Objective optimization using evolutionary
%    algorithms". John Wiley & Sons, LTD. Kanpur, India. 2004.

function [fit err]=test_case(x)
global p V
%% Unconstrained Test functions (for p=1 to p=9)
if p==1     % Test case problem 1
    f1=(4*x(1)^2)+(4*x(2)^2);                       
    f2=((x(1)-5)^2)+((x(2)-5)^2);               
end

if p==2     % ZDT1 from Deb paper NSGA2
    cons=[0];
    f1 = x(1);
       g=1+(9*sum(x(2:V),2)/(V-1));            
       f2 = g*(1-sqrt(x(1)/g));                  
end

if p==3     % kUR from Deb
    f1=(-10*exp(-0.2*(sqrt(x(1)^2+x(2)^2))))+(-10*exp(-0.2*(sqrt(x(2)^2+x(3)^2))));
    f2=((abs(x(1))^0.8) + (5*sin(x(1))^3))+((abs(x(2))^0.8) + (5*sin(x(2))^3))+((abs(x(3))^0.8) + (5*sin(x(3))^3));
end


if p==4    % SCH frm Deb paper
    f1=x.*x;
    f2=(x-2).^2;
end

if p==5     % ZDT2
    f1 = (x(1));
    g=1+(9*sum(x(2:V),2)/(V-1));             
    f2 =((1-(x(1)/g)^2));                
end   

if p==6     % Test case problem 2
    f1=1-exp(-sum((x-1/sqrt(V)).^2,2));
    f2=1-exp(-sum((x+1/sqrt(V)).^2,2));
end

if p==7     % ZDT3
    f1 = x(1);                                 
    g=1+(9*sum(x(2:V),2)/(V-1));               
    f2 = (1-(sqrt(x(1)/g)) - ((x(1)/g)*sin(10*pi*x(1))));               
end  

if p==8     % ZDT4       
    f1 = x(1);  temp=0;
    for ii = 2: V
        temp=temp+((x(ii))^2)-(10*cos(4*pi*x(ii)));
    end
    g= 1 + (10*(V-1)) + temp;           
    f2 = (1-sqrt(x(1)/g));                 
end  

if p==9     % ZDT6       
    f1 = 1-(exp(-4*x(1)))*(sin(6*pi*x(1)))^6; 
    g=1+(9*(sum(x(2:V),2)/(V-1))^0.25);        
    f2 = (1-(f1/g)^2);                     
end  
err= zeros(1,1);

%% Constrained Test functions (for p=10 to p=14)

if p==10     %BNH 
    f1=4*(x(1)^2)+4*(x(2)^2);
    f2=(x(1)-5)^2+(x(2)-5)^2;
    c(1,1)=(x(1)-5)^2 + x(2)^2 -25;
    c(1,2)=-(x(1)-8)^2-(x(2)+3)^2+7.7;
    err=(c>0).*c;
end
if p==11     %SRN  
    f1=(x(1)-2)^2+(x(2)-1)^2+2;
    f2=9*x(1)-(x(2)-1)^2;
    c(1,1)=x(1)^2+x(2)^2-225;
    c(1,2)=x(1)-(3*x(2))+10;
    err=(c>0).*c;
end
if p==12     %TNK
    f1=x(1);
    f2=x(2);
    c(1,1)=-x(1)^2-x(2)^2+1+(0.1*cos(16*atan((x(1)/x(2))))); 
    c(1,2)=(x(1)-0.5)^2+(x(2)-0.5)^2-0.5;
    err=(c>0).*c;
end

if p==13     % OSY 
    f1=-((25*(x(1)-2)^2)+((x(2)-2)^2)+((x(3)-1)^2)+((x(4)-4)^2)+((x(5)-1)^2));
    f2=(x(1)^2)+(x(2)^2)+(x(3)^2)+(x(4)^2)+(x(5)^2)+(x(6)^2);
    c(1,1)=-x(1)-x(2)+2;
    c(1,2)=-6+x(1)+x(2);
    c(1,3)=-2+x(2)-x(1);
    c(1,4)=-2+x(1)-3*x(2);
    c(1,5)=-4+((x(3)-3)^2)+x(4);
    c(1,6)=-((x(5)-3)^2)-x(6)+4;
    err=(c>0).*c;
end

if p==14    % CONSTR
    f1=x(1);
    f2=(1+x(2))/(x(1));
    c(1,1)=-x(2)-(9*x(1))+6;
    c(1,2)=+x(2)-9*x(1)+1;
    err=(c>0).*c;
end

if p==15
% function [Time, Angle, Tm]=func(a,t1,t3)
t1=x(1);t3=x(2);
inf=10000000;
a=0.5;
D1=60; D2=15; l=15; m=6000;
g=9.8; Tmax=20000*g;
%a=0.5; t1=5; t2=20; t3=4;%此时t为每段的时间间隔
xa1=a*t1*t1/2; xa3=D1; xa4=D1+D2; xa2=xa3-0.5*a*t3*(2*t1-t3);
t2=(xa2-xa1)/(a*t1); t4=(xa4-xa3)/(a*(t1-t3)); %xai为第i段结束后吊车的位移
t2=t2+t1; t3=t2+t3; t4=t3+t4;%此时t为每段结束的时刻
t=cell(4,1); theta=cell(4,1); s=cell(4,1); %时间，角度，横坐标
va=cell(4,1); va{2}=a*t1; va{4}=a*(t1+t2-t3);%吊车速度
v=cell(4,1); Tx=cell(4,1); Ty=cell(4,1); T=cell(4,1); %水平速度，拉力,
ax=cell(4,1); ay=cell(4,1);%水平竖直加速度
thetamax=0; Tm=0; %实际最大的角度，拉力

if t2<0 || (t3-t2)>=t1 || (t2-t1)<0.1 || t4>120
    Time=inf; Angle=inf; Tm=inf;
    fit=[Time Angle];
    err=inf;
    return;
end

%第一段加速
dydt=@(t,y)[ y(2) ; (-a*y(2)*t*sin(y(1))+a*cos(y(1))-g*sin(y(1)))/l ];
options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
tspan1=[0:0.05:t1];
if length(tspan1)<2
    tspan1=[0 t1]
end
[t{1},theta{1}] = ode45(dydt,tspan1,[0 0],options);
s{1}=0.5*a*t{1}.^2-l*sin(theta{1}(:,1));
v{1}=a*t{1}-l*theta{1}(:,2).*cos(theta{1}(:,1));

%第二段匀速
dydt=@(t,y)[ y(2) ; (1/l)*(va{2}*y(2)*sin(y(1))-(va{2}+g)*sin(y(1))) ];
options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
tspan2=[t1:0.05:t2]
if length(tspan2)<2
    tspan2=[t1 t2];
end
[t{2},theta{2}] = ode45(dydt,tspan2,[theta{1}(length(theta{1}(:,1)),1) theta{1}(length(theta{1}(:,2)),2)],options);
s{2}=xa1+a*t1*(t{2}-t1)-l*sin(theta{2}(:,1));
v{2}=a*t1-l*theta{2}(:,2).*cos(theta{2}(:,1));

%第三段减速
dydt=@(t,y)[ y(2) ; (-a*y(2)*(t1+t2-t)*sin(y(1))-a*cos(y(1))-g*sin(y(1)))/l ];
options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
tspan3=[t2:0.05:t3]
if length(tspan3)<2
    tspan3=[t2 t3];
end
[t{3},theta{3}] = ode45(dydt,tspan3,[theta{2}(length(theta{2}(:,1)),1) theta{2}(length(theta{2}(:,2)),2)],options);
s{3}=xa2+a*t1*(t{3}-t2)-0.5*a*(t{3}-t2).^2-l*sin(theta{3}(:,1));
v{3}=a*(t1+t2-t{3})-l*theta{3}(:,2).*cos(theta{3}(:,1));

%第四段匀速
dydt=@(t,y)[ y(2) ; (1/l)*(va{4}*y(2)*sin(y(1))-(va{4}+g)*sin(y(1))) ];
options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
tspan4=[t3:0.05:t4]
if length(tspan4)<2
    tspan4=[t3 t4];
end
[t{4},theta{4}] = ode45(dydt,tspan4,[theta{3}(length(theta{3}(:,1)),1) theta{3}(length(theta{3}(:,2)),2)],options);
s{4}=xa3+a*(t1+t2-t3)*(t{4}-t3)-l*sin(theta{4}(:,1));
v{4}=a*(t1+t2-t3)-l*theta{4}(:,2).*cos(theta{4}(:,1));
thetamax=max(theta{4}(:,1));

for i=1:4
    ax{i}=gradient(v{i},0.05);
    Tx{i}=m*ax{i};
    ay{i}=-1*(gradient(theta{i}(:,2),0.05).*sin(theta{i}(:,1)) + cos(theta{i}(:,1)).*theta{i}(:,2).^2);
    Ty{i}=m*(g-l*ay{i});
    T{i}=(Tx{i}.^2 + Ty{i}.^2).^0.5;
    Tm=max(Tm,max(T{i}));
    plot(t{i},v{i});
    hold on;
end

%E4 = 0.5*m*(v{4}(length(v{4}))^2 + (l*theta{4}(length(theta{4}(:,2)),2)*sin(theta{4}(length(theta{4}(:,1)),1)))^2);
%vcx=(2*E4/m + 2*g*l*cos(theta{4}(length(theta{4}(:,1)),1)))^0.5;
%thetamax=max(thetamax,acos(E4/(m*g*l)));

E4 = 0.5*m*(v{4}(length(v{4}))^2 + (l*theta{4}(length(theta{4}(:,2)),2)*sin(theta{4}(length(theta{4}(:,1)),1)))^2);
vcx=(2*E4/m + 2*g*l*cos(theta{4}(length(theta{4}(:,1)),1)))^0.5;
thetamax=max(thetamax,acos(1-E4/(m*g*l)));

vcx=max(abs(v{4}));
%c(1,1)=t3-t1;%t3>t1则不符合
%c(1,2)=vcx-0.5;%vcx>0.5则不符合
err=max(vcx-0.5,0);
%if Tm>Tmax || vcx>0.5 %若拉力超限，最终速度超限
%    Time=inf; Angle=inf;
%    return;
%end

%if t4>120 %做第一问用的
%    Angle=inf; Time=t4;
%    return;
%end

Time=t4; Angle=thetamax;
 end
if p==15
fit=[Time Angle];
else
fit=[f1 f2];
end

