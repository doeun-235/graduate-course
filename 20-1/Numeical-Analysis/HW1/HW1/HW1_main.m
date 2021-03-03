clear

list=["1_1","1_2","1_3","2_a","2_b","3_a","3_b","3_c","4_a","4_b"];
%lista=['1_1','1_2'] 이런 식으로 하면 "1_11_2" 와 같이 하나의 문자열로 합쳐짐

len=length(list);
anss=zeros(size(list));
HWans=string(anss);

for ind=1:len
    name=strcat("H",list(ind));
    run(name);
    HWans(ind)=string(answer);
end

NUM=transpose(list);
ANSWER=transpose(HWans);

T=table(NUM,ANSWER);
T(:,:)

%문자열 벡터와 string 차이 확인해보기