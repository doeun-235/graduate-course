clearvars -except list ind HWans

%f(x)=e^(-x)-x, f'=-e^(-x)-1
%Newton : x_k+1=x_k-f(x_k)/f'(x_k)

x_now=1.5;
done=0;
cnt=0;

while done==0
    f=exp(-x_now)-x_now;
    if abs(f) < 1e-6
        done=1;
        break;
    end
    f_x=-exp(-x_now)-1;
    x_now = x_now-(f/f_x);
    cnt=cnt+1;
end

%fprintf('final itt: %d\n',cnt); 
%fprintf('Hw1-1_2 answer: %f\n',x_now); 

answer=x_now;
