clearvars -except list ind HWans

%F(x)=Y 푸는 것이 목표
%newton으로 x=x_k-f'(x_k)^(-1)f(x_k) 풀어야 하는데
%중간과정 : SOR로 f'(x_k) d_k=-f(x_k) 풀어서
%f'(x_k)^(-1)f(x_k)에 대입할 d_k 찾는 것.


%f_1 (x_1 , x_2) = sin(x_1 + x_2) + e^(x_1) − 1 = 0
%f_2 (x_1 , x_2) = cos(x_1 + x_2) − ln(x_2) − 1 = 0.

x_now = [-1,1];
w=1.5;
e=1e-6;
done=0;
cnt=0;
d_now=[0.2,0.2];

while done==0
    d_now=sor(J_F(x_now),d_now,-F(x_now),w,e);
    x_next=x_now+d_now;
    
    if abs(max(x_next-x_now))<e
        done=1;
        break;
    end
    
    x_now=x_next;
    cnt=cnt+1;
end

answer=join(string(x_next),",");

function y=F(x)
y=[sin(x(1) + x(2))+exp(x(1))-1;cos(x(1) + x(2))-log(x(2))-1];
end

function y=J_F(x)
y=[cos(x(1)+x(2))+exp(x(1)),cos(x(1)+x(2));-sin(x(1)+x(2)),-sin(x(1)+x(2))-1/(x(2))];
end