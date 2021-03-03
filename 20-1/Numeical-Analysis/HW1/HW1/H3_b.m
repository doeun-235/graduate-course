clearvars -except list ind HWans cnvr_a_f


%broyden method

%x_next=x_now-H_now*f(x_now)
%s_now=x_next-x_now
%y_now=f(x_next)-f(x_now)
%H_next=H_now-(H_now*y_now-s_now)*transpose(s_now)*H_now/(transpose(s_now)*H_now*y_now)


%f1=(x_1+3)(x_2^3-7)+18
%f2=sin(x_2 e^(x_1)-1)

%f1_1=(x_2)^3-7, f1_2=(x_1+3)*(3(x_2)^2)
%f2_1=cos(x_2 e^(x_1)-1) (x_2 e^(x_1)), f2_2=cos(x_2 e^(x_1)-1)*e^(x_1)

x_now=[-0.5;1.4];
done=0;
cnt=0;

cnvr_b=0; %convergence rate

e=exp(x_now(1));
f_now=[(x_now(1)+3)*(x_now(2)^3-7)+18;sin(x_now(2)*e -1)];
B_now=[(x_now(2))^3-7 (x_now(1)+3)*(3*(x_now(2))^2);cos(x_now(2)*e-1)*x_now(2)*e cos(x_now(2)*e-1)*e];
H_now=(B_now)^(-1);

x_next=x_now-H_now*f_now;

while done==0
    
    x_next=x_now-H_now*f_now;
    
    if abs(max(x_next-x_now))<1e-6
        done=1;
        break;
    end
    
    cnt=cnt+1;
    cnvr_b(cnt)=norm(x_next-[0;1])*(norm(x_now-[0;1]))^(-1);
    
    s_now=x_next-x_now;
    f_next=[(x_next(1)+3)*(x_next(2)^3-7)+18;sin(x_next(2)*exp(x_next(1))-1)];
    y_now=f_next-f_now;
    H_now=H_now-(H_now*y_now-s_now)*transpose(s_now)*H_now/(transpose(s_now)*H_now*y_now);
   
    x_now=x_next;
    f_now=f_next;
    
end

cnvr_b_f=max(cnvr_b);

% fprintf('final itt: %d\n',cnt);
%fprintf('convergence rate: %d\n',cnvr_b_f);
%fprintf('Hw1-3_a answer: %f\n',x_next); 

answer=join(string(x_next),",");
