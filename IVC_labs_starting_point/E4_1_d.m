% clear;
% A = [1 0 0 2 3 4 5 1 3 0 0 0 0 0 0 0 0 1 2 3 4 0 0 0 0 0 1  4 6 8 2,...
%     4 30 0 0 0 0 2 3 5 6 7 8 9 0 3 8 2 9 29 2 0 0 0 0 0 1 3 9 4 3 0 1 0 0 1];
function B = E4_1_d(A)
B = [];
n = size(A,2);
k = 0;
j = 0;
i = 1;
h = 1;

while i<=n
    if A(i) ~= 0
        B(h) = A(i);
        h = h+1;
        i=i+1;
    elseif A(i) == 0
        for k = 1:99999999
            if A(i+j) ==0            
                j= j+1;
                if i +j >n
                    break
                end
            else 
                break
            end
        end
        B(h) = 0;
        B(h+1) = j-1;
        h = h+2;
        i=i+j;
        j = 0;
    end    
end
end


