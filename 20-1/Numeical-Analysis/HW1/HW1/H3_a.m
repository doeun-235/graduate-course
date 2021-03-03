clearvars -except list ind HWans


%f1=(x_1+3)(x_2^3-7)+18
%f2=sin(x_2 e^(x_1)-1)

%f1_1=(x_2)^3-7, f1_2=(x_1+3)*(3(x_2)^2)
%f2_1=cos(x_2 e^(x_1)-1) (x_2 e^(x_1)), f2_2=cos(x_2 e^(x_1)-1)*e^(x_1)

x_now=[-0.5;1.4];
done=0;
cnt=0;

cnvr_a=0; %convergence rate

while done==0
    e=exp(x_now(1));
    f=[(x_now(1)+3)*(x_now(2)^3-7)+18;sin(x_now(2)*e -1)];
    J=[(x_now(2))^3-7 (x_now(1)+3)*(3*(x_now(2))^2);cos(x_now(2)*e-1)*x_now(2)*e cos(x_now(2)*e-1)*e];
    x_next=x_now-J^(-1)*f;
    
    if abs(max(x_next-x_now))<1e-6
        done=1;
        break;
    end
    
    cnt=cnt+1;
    cnvr_a(cnt)=norm(x_next-[0;1])*(norm(x_now-[0;1]))^(-2);
    x_now=x_next;
    
end

cnvr_a_f=max(cnvr_a);

%fprintf('final itt: %d\n',cnt);
%fprintf('convergence rate: %d\n',cnvr_a_f);
%fprintf('Hw1-3_a answer: %f\n',x_next); 

answer=join(string(x_next),",");

    