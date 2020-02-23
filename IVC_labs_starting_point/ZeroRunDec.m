function dst = ZeroRunDec(src)
%  Function Name : ZeroRunDec.m zero run level decoder
%  Input         : src (zero run code)
%
%  Output        : dst (reconstructed source)
    dst = [];
    n = size(src,2);
    h = 1;
    i = 1;

    while i <= n
        if src(i) ~= 0
        dst(h) = src(i);
        h = h + 1;
        i = i + 1;
        elseif src(i) == 0
            num = src(i+1);
            for j = 0:num
                dst(h+j)=0;            
            end
            h = h + num + 1;
            i = i + 2;
        end    
    
    end
end