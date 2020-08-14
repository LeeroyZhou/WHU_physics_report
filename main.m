% a=0.5; t1=8; t2=8; t3=7.6;
min=1000000;
Ans=[];
for i=5:0.5:10 %多起点进行最小值搜索
    for j=i-2:0.1:i
        [i,j]
        [x,out]=fminsearch('func1',[i,j]);
        if out<min
            real=[x,out];
            min=out;
        end
        if out-0.1016 < 0.05
            Ans=[Ans; x,out]
        end
    end
end

%[x,out]=fminsearch('func1',[5,5]);
%[Time, Angle, Tm]=func(0.5,7.983,7.3867);
% for i=1:15
%     [Time, Angle, Tm]=func(0.5,Ans(i,1),Ans(i,2));
%     
% end