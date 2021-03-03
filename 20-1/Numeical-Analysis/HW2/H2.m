clearvars -except list ind HWans

t2 = [0 1 3 4 6 7 9 10];
y2 = [8 6 5.5 1.5 1.2 1.1 1 1];

n2 = length(t2);
n22=10*n2-9; %각 t 사이에 점 9개 씩

x2=zeros(1,n22);
for i=1:n2-1
    x2(10*i-9:10*i+1)=linspace(t2(i),t2(i+1),11);
end

% 2.a natural cubic spline
% s''(x_0) = s''(x_n) = 0

h2=t2(2:n2)-t2(1:n2-1);
D2 = (y2(3:n2)-y2(2:n2-1))./h2(2:n2-1)-(y2(2:n2-1)-y2(1:n2-2))./h2(1:n2-2);

A2=zeros(n2-2);
M2=zeros(1,n2);
A2(1,1)=(h2(1)+h2(2))/3;
A2(1,2)=h2(2)/6;
for i=2:n2-3
    A2(i,i-1)=h2(i)/6;
    A2(i,i)=(h2(i)+h2(i+1))/3;
    A2(i,i+1)=h2(i+1)/6;
end
A2(n2-2,n2-3)=h2(n2-2)/6;
A2(n2-2,n2-2)=(h2(n2-2)+h2(n2-1))/3;

M2(2:n2-1)=linsolve(A2,D2.');

for i=1:n2-1
    y21(10*i-9:10*i+1)=((t2(i+1)-x2(10*i-9:10*i+1)).^3*M2(i)+(x2(10*i-9:10*i+1)-t2(i)).^3*M2(i+1))/(6*h2(i));
    y21(10*i-9:10*i+1)=y21(10*i-9:10*i+1)+(y2(i)/h2(i)-h2(i).*M2(i)/6)*(t2(i+1)-x2(10*i-9:10*i+1));
    y21(10*i-9:10*i+1)=y21(10*i-9:10*i+1)+(y2(i+1)/h2(i)-h2(i).*M2(i+1)/6)*(x2(10*i-9:10*i+1)-t2(i));
end

% 2.b interpolation of least degree

%lagrange
% l_j= prod i!=j (x-x_i)/(x_j-x_i)

y22=zeros(1,n22);
for a=1:n2
    k=ones(1,n22);
    for j=1:n2
        if a~=j
            k=k.*(x2-t2(j))/(t2(a)-t2(j));
        end
    end
    y22=y22+y2(a)*k;
end

%plot

f2=figure('Name','Figure : 2','NumberTitle','off');
figure(f2);


subplot (2,1,1);
scatter(t2,y2)
hold on
plot(x2,y21)
hold off
title('2-a')

subplot (2,1,2);
scatter(t2,y2)
hold on
plot(x2,y22)
hold off
title('2-b')
