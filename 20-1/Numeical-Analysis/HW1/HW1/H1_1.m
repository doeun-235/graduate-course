clearvars -except list ind HWans

a=0;
b=2.5;

%f(x)=e^(-x)-x , f(0)>0,f(2.5)<0

done=0;
cnt=0;

while done==0
   c=(a+b)/2;
   
   f=exp(-c)-c;
   
   if abs(f) < 1e-6
       done = 1;
       break;
   end
   
   if f > 0
       a = c;
   elseif f < 0
       b = c;
   end
   
   cnt=cnt+1;
%   if mod(cnt,10)==0
%        fprintf('itt: %d\n',cnt);      
%   end

end


%fprintf('final itt: %d\n',cnt); 

%fprintf('Hw1-1_1 answer: %f\n',c); 
answer=c;