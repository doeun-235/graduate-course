clearvars -except list ind HWans

% g_1=(x_2+5)/4, g_2=(1+x_1^2)^(1/3)-1

x_now = [1.5;0.5];
done=0;
cnt=0;

while done==0
    x_next(1)= (x_now(2)+5)/4;
    x_next(2)= (1+((x_now(1))^2))^(1/3)-1;
    
    if max(abs(x_next-x_now))<1e-6
        done=1;
        break;
    else
        x_now=x_next;
    end
    cnt=cnt+1;
end

%fprintf('final itt: %d\n',cnt); 
%fprintf('Hw1-2_b answer: %f\n',x_next); 

answer=join(string(x_next),",");
