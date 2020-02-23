function zze = ZeroRunEnc(zz)
%  Input         : zz (Zig-zag scanned block, 1xN)
%
%  Output        : zze (zero-run-level encoded block, 1xM)

zze = [];
n = size(zz,2);
p = ceil(n/255);
k = 0;
j = 0;
i = 1;
h = 1;
q = 1;


    while i<=n
        if zz(i) ~= 0
            zze(h) = zz(i);
            h = h+1;
            i = i+1;
    elseif zz(i) == 0
        for k = 1:255
            if zz(i+j) == 0            
                j= j+1;
                if i +j >n
                    break
                end
            else 
                break
            end
        end
        zze(h) = 0;
        zze(h+1) = j-1;
        h = h+2;
        i =i+j;
        j = 0;
        end
    end


end