%a=0.5; t1=8; t2=8; t3=7.6;
min=1000000;
for i=2:1:8 %多起点进行最小值搜索
    for j=5:5:60
        [i,j]
        [x,out]=fminsearch('func1',[i,j,i-1]);
        if out<min
            real=[x,out];
            min=out;
        end
    end
end

%[x,out]=fminsearch('func1',[8,5,7]);

%[Time, Angle, Tm]=func(0.5,8.2,10,7);