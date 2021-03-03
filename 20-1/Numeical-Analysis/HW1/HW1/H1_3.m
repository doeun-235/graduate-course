clearvars -except list ind HWans


%f(x)=e^(-x)-x, f'=-e^(-x)-1
%Newton : x_k+1=x_k-f(x_k)/f'(x_k)

x_prev=1.5;
done=0;
cnt=0;

f_prev=exp(-x_prev)-x_prev;
f_x=-exp(-x_prev)-1;

x_now = x_prev-(f_prev/f_x);

%Secant = x_k+2=x_k+1-f(x_k+1)*(x_k+1-x_k)/(f(x_k+1)-f(x_k))

while done==0
    
    f_now=exp(-x_now)-x_now;
    
    if abs(f_now)<1e-6
        done=1;
        break;
    end
    
    x_next=x_now-f_now*(x_now-x_prev)/(f_now-f_prev);
    x_prev=x_now;
    f_prev=f_now;
    x_now=x_next;
    cnt=cnt+1;
    
end

%fprintf('final itt: %d\n',cnt); 
%fprintf('Hw1-1_3 answer: %f\n',x_now); 
answer=x_now;
    

