% a=0.5; t1=8; t2=8; t3=7.6;
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
%         if out-0.0080 < 0.001
%             Ans=[Ans; x,out]
%         end
%     end
% end

%[x,out]=fminsearch('func1',[5,5]);
[Time, Angle, Tm]=func(0.5,5.5975,5.2713);
%Angle=func1([7.9838 7.6002]);
% for i=1:15
%     [Time, Angle, Tm]=func(0.5,Ans(i,1),Ans(i,2));
%     
% end