%a=0.5; t1=8; t2=8; t3=7.6;
% clear;
% min=1000000;
% Ans=[];
% for i=5:0.5:10 %多起点进行最小值搜索
%     for j=i-2:0.1:i
%         [i,j]
%         [x,out]=fminsearch('func1',[i,j]);
%         if out<min
%             real=[x,out];
%             min=out;
%         end
%         if out < 0.033
%             Ans=[Ans; x,out]
%         end
%     end
% end

%[x,out]=fminsearch('func1',[8.5,8.0001]);
[Time, Angle, Mm]=func(0.5,5.56903824698239,5.07927121029934);
grid on;

%axis equal;
% Angle=func1([8.499991605410152,8.000082689113619]);
% for i=1:length(Ans(:,1))
%     [Time, Angle, Tm]=func(0.5,Ans(i,1),Ans(i,2));
%     Ans(i,4)=Time;
% end