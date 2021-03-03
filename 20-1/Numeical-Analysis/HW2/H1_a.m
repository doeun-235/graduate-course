clearvars -except list ind HWans

% f = (1+25*t^2)^(-1) on [-1,1]
% 1 monomial , 2 lagrange , 3 newton

time=zeros(2,6);
cnum=zeros(2,3);
coeff=zeros(2,3,20);

x10 = linspace(-1,1,121);
y10 = (1+25*(x10.^2)).^(-1);

x11 = linspace(-1,1,11);
y11 = (1+25*(x11.^2)).^(-1);

%monomial basis

tic
A11=zeros(11,11);

for a=0:10
    A11(:,a+1)=(x11.^a).';
end
tempt=toc;

cnum(1,1)=cond(A11);
tic
c=linsolve(A11,y11.');
time(1,1)=toc;

tic
y111=zeros(1,121);
for a=0:10
    y111=y111+c(a+1)*x10.^a;
end
tempt2=toc;
time(1,2)=tempt+time(1,1)+tempt2;

%lagrange
% l_j= prod i!=j (x-x_i)/(x_j-x_i)
cnum(1,2)=cond(eye(11));

tic
y112=zeros(1,121);
for a=1:11
    k=ones(1,121);
    for j=1:11
        if a~=j
            k=k.*(x10-x11(j))/(x11(a)-x11(j));
        end
    end
    y112=y112+y11(a)*k;
end
time(1,4)=toc;
%똑같은 그래프 나옴.

%newton

tic
A13=zeros(11,11);
B=zeros(11,11);
for i=1:11
    for j=1:11
        B(i,j)=x11(i)-x11(j); 
    end
end
%B_ij = x_i-x_j
%pi_j(x_i)=prod k=0 to j-1 (x_i-x_k)
A13(:,1)=ones(11,1);
for j=2:11
    A13(:,j)=A13(:,j-1).*B(:,j-1);
end
tempt=toc;

cnum(1,3)=cond(A13);

tic
c=linsolve(A13,y11.');
time(1,5)=toc;

tic
B=zeros(11,121);
B(1,:)=ones(1,121);
for i=1:10
    B(1+i,:)=B(i,:).*(x10-x11(i));
end
y113=zeros(1,121);
for i=1:11
    y113=y113+c(i)*B(i,:);
end
tempt2=toc;
time(1,6)=tempt+time(1,5)+tempt2;
%똑같은 그래프 나옴.

%order 20

x12 = linspace(-1,1,21);
y12 = (1+25*(x12.^2)).^(-1);

%monomial basis

tic
A21=zeros(21,21);

for a=0:20
    A21(:,a+1)=(x12.^a).';
end
tempt=toc;

cnum(2,1)=cond(A21);

tic
c=linsolve(A21,y12.');
time(2,1)=toc;

tic
y121=zeros(1,121);
for a=0:20
    y121=y121+c(a+1)*x10.^a;
end
tempt2=toc;
time(2,2)=tempt+time(2,1)+tempt2;

%lagrange
% l_j= prod i!=j (x-x_i)/(x_j-x_i)
cnum(2,2)=cond(eye(21));

tic
y122=zeros(1,121);
for a=1:21
    k=ones(1,121);
    for j=1:21
        if a~=j
            k=k.*(x10-x12(j))/(x12(a)-x12(j));
        end
    end
    y122=y122+y12(a)*k;
end
time(2,4)=toc;
%똑같은 그래프 나옴.

%newton

tic
A23=zeros(21,21);
B=zeros(21,21);
for i=1:21
    for j=1:21
        B(i,j)=x12(i)-x12(j); 
    end
end
%B_ij = x_i-x_j
%pi_j(x_i)=prod k=0 to j-1 (x_i-x_k)
A23(:,1)=ones(21,1);
for j=2:21
    A23(:,j)=A23(:,j-1).*B(:,j-1);
end
tempt=toc;

cnum(2,3)=cond(A23);

tic
c=linsolve(A23,y12.');
time(2,5)=toc;

tic
B=zeros(21,121);
B(1,:)=ones(1,121);
for i=1:20
    B(1+i,:)=B(i,:).*(x10-x12(i));
end
y123=zeros(1,121);
for i=1:21
    y123=y123+c(i)*B(i,:);
end
tempt2=toc;
time(2,6)=tempt+time(2,5)+tempt2;
%똑같은 그래프 나옴.

f1a=figure('Name','Figure : 1-a','NumberTitle','off');
figure(f1a);

subplot (2,3,1);
plot(x10,y10)
hold on
scatter(x11,y11)
plot(x10,y111)
axis ([-1 1 -0.5 3])
hold off
title('Monomial')

subplot (2,3,2);
plot(x10,y10)
hold on
scatter(x11,y11)
plot(x10,y112)
axis ([-1 1 -0.5 3])
hold off
title('Lagrange')

subplot (2,3,3);
plot(x10,y10)
hold on
scatter(x11,y11)
plot(x10,y113)
axis ([-1 1 -0.5 3])
hold off
title('Newton')


subplot (2,3,4);
plot(x10,y10)
hold on
scatter(x12,y12)
plot(x10,y121)
axis ([-1 1 -0.5 3])
hold off
title('Monomial')

subplot (2,3,5);
plot(x10,y10)
hold on
scatter(x12,y12)
plot(x10,y122)
axis ([-1 1 -0.5 3])
hold off
title('Lagrange')

subplot (2,3,6);
plot(x10,y10)
hold on
scatter(x12,y12)
plot(x10,y123)
axis ([-1 1 -0.5 3])
hold off
title('Newton')

Order=[10 20].';
SolvSysMono=time(:,1);
SolvSysLag=time(:,3);
SolvSysNew=time(:,5);
TotalMono=time(:,2);
TotalLag=time(:,4);
TotalNew=time(:,6);

T11=table(Order,SolvSysMono,SolvSysLag,SolvSysNew,TotalMono,TotalLag,TotalNew)

condMono=cnum(:,1);
condLag=cnum(:,2);
condNew=cnum(:,3);
T12=table(Order,condMono,condLag,condNew)


