shittt
% Frame1_R = Frame1_RGB(:,:,1);
% Frame1_R = Frame1_R(:)';
% Frame1_G = Frame1_RGB(:,:,2);
% Frame1_G = Frame1_G(:)';
% Frame1_B = Frame1_RGB(:,:,3);
% Frame1_B = Frame1_B(:)';
% Frame1_RGB_pic = [Frame1_R;Frame1_G;Frame1_B];
% 
% I_rec_Y = I_rec(:,:,1);
% I_rec_Y = I_rec_Y(:)';
% I_rec_Cb = I_rec(:,:,1);
% I_rec_Cb = I_rec_Cb(:)';
% I_rec_Cr = I_rec(:,:,1);
% I_rec_Cr = I_rec_Cr(:)';
% cunt = size(I_rec_Y,2);
% I_rec_pic = [ones(1,cunt);I_rec_Y;I_rec_Cb;I_rec_Cr];
% T_and_offset_1 = Frame1_RGB_pic*pinv(I_rec_pic);
% I_rec_RGB = T_and_offset_1*I_rec_pic;
% I_rec_RGB_R = I_rec_RGB(1,:);
% I_rec_RGB_R = reshape(I_rec_RGB_R,288,352);
% I_rec_RGB_G = I_rec_RGB(2,:);
% I_rec_RGB_G = reshape(I_rec_RGB_G,288,352);
% I_rec_RGB_B = I_rec_RGB(3,:);
% I_rec_RGB_B = reshape(I_rec_RGB_B,288,352);
% I_rec_RGB_1(:,:,1) = I_rec_RGB_R;
% I_rec_RGB_1(:,:,2) = I_rec_RGB_G;
% I_rec_RGB_1(:,:,3) = I_rec_RGB_B;
% offset_1 = T_and_offset_1(:,1);
% T_1 = T_and_offset_1(:,2:4);
% 
% I_rec_RGB = YCbCr2RGB_2(I_rec,T_1,offset_1);