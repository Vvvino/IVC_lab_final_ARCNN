function motion_vectors_indices = SSD(ref_image, image)
    search_range = 8;
    block_range = 9;
    SSE = 9999999999;
    check = 1;
    Index_Matrix = reshape(1:81,9,9)';
    
    ref_image_1 = padarray(ref_image,[4,4],0,'pre');
    ref_image_1 = padarray(ref_image_1,[8,8],0,'post');
    
    
    Y_ref = ref_image_1(:,:,1);
    Y_image = image(:,:,1);
    [p,q] = size(Y_image);
    cunt = 1;
    cunt_2 = 1;
    m = 1;
    
    for h = 1:8:p
        for g = 1:8:q
                    
            Y_image_block{cunt} = Y_image(h:h+7,g:g+7);                    
                    
            for k = h:h+8
                for l = g:g+8
                            
                    Y_ref_block_move{cunt_2} = Y_ref(k:k+7,l:l+7);
                    SSE_block{m} = Y_image_block{cunt} - Y_ref_block_move{cunt_2};
                    SSE1(m) = sum(sum(SSE_block{m}.^2));
                                
                    cunt_2 = cunt_2 + 1;
                    m = m+1;
                            
                end
            end
            [min_val(cunt), idx] = min(SSE1);
            bestx = ceil(idx/9);
            besty = mod(idx,9);
            
            if besty == 0
                besty = besty + 9;
            end
            koor(1,cunt) = bestx;
            koor(2,cunt) = besty;
            motion_vectors_indices((h-1)/8 +1,(g-1)/8 +1) = Index_Matrix(bestx,besty);
            m = 1;
            cunt = cunt + 1;
                    
        end
    end
% end
    
