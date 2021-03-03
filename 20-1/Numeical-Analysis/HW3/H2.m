clearvars -except list ind HWans

R2=zeros(9,25);
Ra=zeros(8);
Re=zeros(8);
Rr=zeros(8);

% integral (x^5-x+1) from 0 to 2

b2=2;
a2=0;

Ra(1,1)=(b2-a2)/2*(f(a2)+f(b2)); % actually, it is R(0,0)

for n=2:8
    h=(b2-a2)*2^(-n+1);
    temp=0;
    for i=1:(2^(n-2))
        temp=temp+f(a2+(2*i-1)*h);
    end
    Ra(n,1)=1/2*Ra(n-1,1)+h*temp;
    
    for m=2:n
        Ra(n,m)=Ra(n,m-1)+1/(4^(m-1)-1)*(Ra(n,m-1)-Ra(n-1,m-1));
    end    
end

for i=1:8
    for j=1:i
        Re(i,j)=Ra(i,j)-Ra(8,j);
    end
end

for i=2:8
    for j=1:i
        Rr(i,j)=Re(i,j)/Re(i-1,j);
    end
end


        
R2(:,1)=[0 0 1 2 3 4 5 6 7].';
for n=1:8
    for j=1:8
        R2(n+1,3*(j-1)+2)=Ra(n,j);
        R2(n+1,3*(j-1)+3)=Re(n,j);
        R2(n+1,3*(j-1)+4)=Rr(n,j);
    end
end

R2

function y=f(x)
y=x^5-x+1;
end
