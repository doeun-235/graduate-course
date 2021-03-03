clearvars -except list ind HWans

% f = (1+25*t^2)^(-1) on [-1,1]
% 1 monomial , 2 lagrange , 3 newton

time=zeros(2,3);
cnum=zeros(2,3);
coeff=zeros(2,3,20);

x10 = linspace(-1,1,61);
y10 = (1+25*(x10.^2)).^(-1);

i13 = linspace(0,10,11);
x13 = cos((2*i13+1)/22*pi);
y13 = (1+25*(x13.^2)).^(-1);

%lagrange
% l_j= prod i!=j (x-x_i)/(x_j-x_i)
cnum(1,2)=cond(eye(11));
y131=zeros(1,61);
for a=1:11
    k=ones(1,61);
    for j=1:11
        if a~=j
            k=k.*(x10-x13(j))/(x13(a)-x13(j));
        end
    end
    y131=y131+y13(a)*k;
end

%order 20

i14 = linspace(0,20,21);
x14 = cos((2*i14+1)/42*pi);
y14 = (1+25*(x14.^2)).^(-1);

%lagrange
% l_j= prod i!=j (x-x_i)/(x_j-x_i)
cnum(2,2)=cond(eye(21));
y141=zeros(1,61);
for a=1:21
    k=ones(1,61);
    for j=1:21
        if a~=j
            k=k.*(x10-x14(j))/(x14(a)-x14(j));
        end
    end
    y141=y141+y14(a)*k;
end
%똑같은 그래프 나옴.

f1b=figure('Name','Figure : 1-b','NumberTitle','off');
figure(f1b);

subplot (2,1,1);
plot(x10,y10)
hold on
scatter(x13,y13)
plot(x10,y131)
axis ([-1 1 -0.2 1.2])
hold off

subplot (2,1,2);
plot(x10,y10)
hold on
scatter(x14,y14)
plot(x10,y141)
axis ([-1 1 -0.2 1.2])
hold off