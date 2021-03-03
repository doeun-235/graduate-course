function x = newtonforSOR(J_F,F,x_init,i,e)
%UNTITLED Summary of this function goes nowhere
%   solve F_i(x,...,x_i,....,x)=0

x_k=x_init;
x=x_k;

ntnsor_done=0;
cnt=0;

    while ntnsor_done==0
    
        F_d=J_F(x_k,i);
        a=F(x_k,i);
        x(i)=x_k(i)-(F_d)^(-1)*(a);
        
        if abs(max(x-x_k)) < e
            ntnsor_done=1;
            break;
        end
    
        x_k=x;
        cnt=cnt+1;

    end

end

