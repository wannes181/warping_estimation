function [z] = crossing_tanweer(x)

p = sort(find(x>0));
q = sort(find(x<0));

i_p = [];
i_q = [];

p_p =[];
p_q=[];

for i = 1:numel(p)-1
    p_p=[p_p,p(i+1)-p(i)];
end

for i = 1:numel(q)-1
    p_q=[p_q,q(i+1)-q(i)];
end

threshold = mean([p_p,p_q])+3*std([p_p,p_q]);

for i = 1:numel(p)-1
    if abs(p(i+1) - p(i)) > threshold % If difference is larger than threshold
        i_p = [i_p;p(i),p(i+1)];
    end
end

for i = 1:numel(q)-1
    if abs(q(i+1) - q(i)) > threshold % If difference is larger than threshold
        i_q = [i_q;q(i),q(i+1)];
    end
end

r = sort(reshape([i_p;i_q],1,[]));
r = [0,r,numel(x)];

z=[];

for i=1:2:numel(r)-1
    avg = (r(i)+r(i+1))/2;
    z = [z,avg];
end
end

