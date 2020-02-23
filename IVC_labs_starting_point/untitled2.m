clear;
I = double(imread('foreman20_40_RGB/foreman0020.bmp'));
[cA,cH,cV,cD]=dwt2(I,'bior3.7');
subplot(2,2,1);
imshow(cA/256)
subplot(2,2,2);
imshow(cH/256)
subplot(2,2,3);
imshow(cV/256)
subplot(2,2,4);
imshow(cD/256)
% subplot(2,2,1);
% 
% J=rgb_to_gray(I);
% imshow(J/256);
% title('0_');
% 
% 
% [cA1,cH1,cV1,cD1] = dwt2(J,'bior3.7');    
% A1 = upcoef2('a',cA1,'bior3.7',1); 
% H1 = upcoef2('h',cH1,'bior3.7',1);
% V1 = upcoef2('v',cV1,'bior3.7',1);
% D1 = upcoef2('d',cD1,'bior3.7',1);
% Y=idwt2(A1,H1,V1,D1,'bior3.7');
% subplot(2,2,2);image(Y);title('1');
% A1 = upcoef2('a',cA1,'bior3.7',2); 
% H1 = upcoef2('h',cH1,'bior3.7',2);
% V1 = upcoef2('v',cV1,'bior3.7',2);
% D1 = upcoef2('d',cD1,'bior3.7',2);
% Y=idwt2(A1,H1,V1,D1,'bior3.7');
% subplot(2,2,3);image(Y);title('2');
% A1 = upcoef2('a',cA1,'bior3.7',3); 
% H1 = upcoef2('h',cH1,'bior3.7',3);
% V1 = upcoef2('v',cV1,'bior3.7',3);
% D1 = upcoef2('d',cD1,'bior3.7',3);
% Y=idwt2(A1,H1,V1,D1,'bior3.7');
% subplot(2,2,4);image(Y);title('3');
% 
% 
% % [LoD,HiD] = wfilters('haar','d');
% % [cA1,cH1,cV1,cD1] = dwt2(J,LoD,HiD,'mode','symh');
% %  subplot(2,2,1)
% % imagesc(cA1)
% % colormap gray
% % title('Approximation')
% % subplot(2,2,2)
% % imagesc(cH1)
% % colormap gray
% % title('Horizontal')
% % subplot(2,2,3)
% % imagesc(cV1/256)
% % colormap gray
% % title('Vertical')
% % subplot(2,2,4)
% % imagesc(cD1)
% % colormap gray
% % title('Diagonal')
% %  
% % A1 = upcoef2('a',cA1,'haar',1); 
% % H1 = upcoef2('h',cH1,'haar',1);
% % V1 = upcoef2('v',cV1,'haar',1);
% % D1 = upcoef2('d',cD1,'haar',1);
% % Y=idwt2(A1,H1,V1,D1,'haar');
% % subplot(2,2,2);image(Y/256);title('1_');
% % A1 = upcoef2('a',cA1,'haar',2); 
% % H1 = upcoef2('h',cH1,'haar',2);
% % V1 = upcoef2('v',cV1,'haar',2);
% % D1 = upcoef2('d',cD1,'haar',2);
% % Y=idwt2(A1,H1,V1,D1,'haar');
% % subplot(2,2,3);image(Y/256);title('2_');
% % A1 = upcoef2('a',cA1,'haar',3); 
% % H1 = upcoef2('h',cH1,'haar',3);
% % V1 = upcoef2('v',cV1,'haar',3);
% % D1 = upcoef2('d',cD1,'haar',3);
% % Y=idwt2(A1,H1,V1,D1,'haar');
% % subplot(2,2,4);image(Y/256);title('3_');
% 
% 
% 
% 
