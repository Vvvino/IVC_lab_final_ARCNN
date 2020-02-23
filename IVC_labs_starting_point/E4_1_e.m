clear;
A = [1 0 0 2 3 4 5 1 3 0 0 0 0 0 0 0 0 1 2 3 4 0 0 0 0 0 1 4 6 8 2 4 30 0 0 0 0 2 3 5 6 7 8 9 0 3 8 2 9 29 2 0 0 0 0 0 1 3 9 4 3 0 0 0];
B = E4_1_d(A);
C = [];
n = size(B,2);
h = 1;
i = 1;

while i <= n
    if B(i) ~= 0
        C(h) = B(i);
        h = h + 1;
        i = i + 1;
    elseif B(i) == 0
        num = B(i+1);
        for j = 0:num
            C(h+j)=0;            
        end
        h = h + num + 1;
        i = i + 2;
    end    
    
end