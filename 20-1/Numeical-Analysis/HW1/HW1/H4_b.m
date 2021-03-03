clearvars -except list ind HWans

%F(x)=Y 푸는 것이 목표
%f_i eq 풀때는 x_i만 모른다고 놓고 x_i 구하기 근데 그 과정에서 newton.


%newton으로 x=x_k-f'(x_k)^(-1)f(x_k) 풀어야 하는데
%중간과정 : SOR로 f'(x_k) d_k=-f(x_k) 풀어서
%f'(x_k)^(-1)f(x_k)에 대입할 d_k 찾는 것.

x_now = [-1,1];
x_next_J = [0,0];
x_next_GS = [0,0];
x_next=[0,0];
x_temp=[0,0];

w=1.5;
e=1e-6;
done=0;
cnt_4b=0;

F=@f;
J_F=@J_f;

while done==0
    
    x_next_J=newtonforSOR(J_F,F,x_now,1,e);
    x_next_J=newtonforSOR(J_F,F,x_now,2,e);
    
    x_next_GS=x_now;    
    x_next_GS=newtonforSOR(J_F,F,x_next_GS,1,e);
    x_next_GS=newtonforSOR(J_F,F,x_next_GS,2,e);
    
    x_next=(1-w)*x_next_J+w*x_next_GS;
    
    if abs(max(x_next-x_now))<e
        done=1;
        break;
    end
    
    x_now=x_next;
    cnt_4b=cnt_4b+1;
end


answer=join(string(x_next),",");

function y=f(x,ind)
if ind==1
    y=sin(x(1) + x(2))+exp(x(1))-1;
else
    y=cos(x(1) + x(2))-log(x(2))-1;
end
end

function y=J_f(x,ind)

if ind==1 
    y=cos(x(1)+x(2))+exp(x(1));
else
    y=-sin(x(1)+x(2))-1/(x(2));
end
end
