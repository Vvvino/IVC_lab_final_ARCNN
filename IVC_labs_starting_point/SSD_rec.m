function rec_image = SSD_rec(ref_image, motion_vectors)
% [r,c] = size(motion_vectors);
% rec_image = zeros(8*r,8*c,3);
% for i = 1:r
%     for j = 1:c
%         r_move = ceil(motion_vectors(i,j)/9)-5;
%         c_move = motion_vectors(i,j) - (ceil(motion_vectors(i,j)/9)-1)*9-5;
%         rec_image(1+(i-1)*8:i*8,1+(j-1)*8:j*8,:) = ref_image(1+(i-1)*8+r_move:i*8+r_move,1+(j-1)*8+c_move:j*8+c_move,:);
%     end
% end
width = size(ref_image,2);
    height = size(ref_image,1);
    for i = 1:8:width
        for j = 1:8:height
            y = ceil(motion_vectors((j-1)/8+1,(i-1)/8+1)/9)-5;
            if mod(motion_vectors((j-1)/8+1,(i-1)/8+1),9) == 0
                x = 4;
            else
                x = mod(motion_vectors((j-1)/8+1,(i-1)/8+1),9)-5;
            end
            if j+y>0 && i+x>0 && height>=j+y+7 && width>=i+x+7
                rec_image(j:j+7,i:i+7,:) = ref_image(j+y:j+y+7,i+x:i+x+7,:);
            else
                rec_image(j:j+7,i:i+7,:) = ref_image(j:j+7,i:i+7,:);
            end
        end
    end
end