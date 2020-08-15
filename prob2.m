thetamin=min(Ans(:,3)); thetamax=max(Ans(:,3));
tmin=min(Ans(:,4)); tmax=max(Ans(:,4));
a=zeros(30,5);
for i=1:30
    a(i,1)=(Ans(i,3)-thetamin)/(thetamax-thetamin);
    a(i,2)=(Ans(i,4)-tmin)/(tmax-tmin);
end
abest=[min(a(:,1)), min(a(:,2))];
aworst=[max(a(:,1)), max(a(:,2))];
w1=0.6; w2=0.4;
for i=1:30
    a(i,3)=(w1*(a(i,1)-abest(1))^2 + w2*(a(i,2)-abest(2))^2)^0.5;
    a(i,4)=(w1*(a(i,1)-aworst(1))^2 + w2*(a(i,2)-aworst(2))^2)^0.5;
    a(i,5)=a(i,3)/(a(i,3)+a(i,4));
end

for i=1:30
    Ans(i,3)=Ans(i,3)*180/pi;
end