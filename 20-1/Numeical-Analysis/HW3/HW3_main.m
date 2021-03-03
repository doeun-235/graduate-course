clear

list=["1","2"];
%lista=['1_1','1_2'] 이런 식으로 하면 "1_11_2" 와 같이 하나의 문자열로 합쳐짐

len=length(list);
anss=zeros(size(list));
HWans=string(anss);

for ind=1:len
    name=strcat("H",list(ind));
    run(name);
end

