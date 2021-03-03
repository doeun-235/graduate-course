clearvars -except list ind HWans

x3 = [-3.0 -2.5 -2.0 -1.5 -1.0 -0.5 0.0 0.5 1.0];
y3 = [5.3004 4.9607 4.1761 3.4234 1.6559 0.5440 -0.7291 0.2084 1.2088];
n3 = length(x3);

% a : legendre polynomial

x31 = linspace(-1,1,50);
y310 = ones(1,50);
y311 = x31;
y312 = (3*x31.^2-1)/2;
y313 = (5*x31.^3-3*x31)/2;

% b : 

A32 = zeros(n3,4);

for i=1:n3
    A32(i,1)=1;
    A32(i,2)=x3(i);
    A32(i,3)=(3*x3(i)^2-1)/2;
    A32(i,4)=(5*x3(i)^3-3*x3(i))/2;
end

C=linsolve(A32.'*A32,A32.'*y3.');

n32=10*n3-9;
x32=zeros(1,n32);
for i=1:n3-1
    x32(10*i-9:10*i+1)=linspace(x3(i),x3(i+1),11);
end

y32=C(1)+C(2)*x32+C(3)*((3*x32.^2-1)/2)+C(4)*((5*x32.^3-3*x32)/2);

% c



%plot

f3=figure('Name','Figure : 3','NumberTitle','off');
figure(f3);


subplot (2,1,1);
hold on
plot(x31,y310)
plot(x31,y311)
plot(x31,y312)
plot(x31,y313)
hold off
title('3-a')

subplot (2,1,2);
scatter(x3,y3)
hold on
plot(x32,y32)
hold off
title('3-b')