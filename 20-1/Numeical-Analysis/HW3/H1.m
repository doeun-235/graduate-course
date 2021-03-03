clearvars -except list ind HWans

% 4 point gaussian

x1=[(3/7-2/7*((6/5)^(1/2)))^(1/2) -(3/7-2/7*((6/5)^(1/2)))^(1/2) (3/7+2/7*((6/5)^(1/2)))^(1/2) -(3/7+2/7*((6/5)^(1/2)))^(1/2)];
A1=[(18+(30)^(1/2))/36 (18+(30)^(1/2))/36 (18-(30)^(1/2))/36 (18-(30)^(1/2))/36];

% integral f a to b = (b-a)/2 sum A_i f((b-a)/2 x_i + (a+b)/2)

a1=1/4;
b1=1/2;
c1=0;
d1=1/2;

Ans1=0;

for j=1:4
    temp=0;
    for i=1:4
        temp = temp + A1(i)*exp(((b1-a1)/2*x1(i)+(a1+b1)/2)*((d1-c1)/2*x1(j)+(d1+c1)/2));
    end
    temp = (b1-a1)*temp * A1(j)/2;
    Ans1=Ans1+temp;
end

Ans1=Ans1*(d1-c1)/2;

Ans1