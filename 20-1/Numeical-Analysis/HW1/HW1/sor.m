function x = sor(A,x_init,b,w,e)
%SOR Summary of this function doesn't goes here
%   Detailed explanation doesn't goes here

x_m=transpose(x_init);
sor_done=0;
cnt=0;

D=diag(diag(A));
L=tril(A);

while sor_done==0
    x=x_m-w*(D+w*L)^(-1)*(A*x_m-b);
    
    if abs(max(x-x_m)) < e
        sor_done=1;
        break;
    end
    x_m=x;
    cnt=cnt+1;

end

x=transpose(x);

end

