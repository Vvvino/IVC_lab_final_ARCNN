clear;
%% load huffmantable, first two frame and lena small
path(path,'encoder')          
path(path,'decoder')            
path(path,'analysis')
Frame1 = double(imread('foreman20_40_RGB/foreman0020.bmp'));%Frame 1 and Frame 2 are RGB 
Frame2 = double(imread('foreman20_40_RGB/foreman0021.bmp'));
lena_small = double(imread('data/images/lena_small.tif'));%Lena is also RGB
%% use lena small to train huffman table
f = waitbar(0,'Please wait...');
g=1;
 for qScale = 0.15:0.3:2
k_small  = IntraEncode(lena_small, qScale); %lena_small transfer coding now YCbCr
k        = IntraEncode(Frame1, qScale);% Frame 1 transfer coding now YCbCr

PMF_1 = hist(k_small,min(k):max(k));% PMf of lena small
PMF_1 = PMF_1/sum(PMF_1);
[BinaryTree_1, HuffCode_1, BinCode_1, Codelengths_1] = buildHuffman(PMF_1);% build a huff
%% use first frame with lena small huffman table to transfer coding and calculate PSNR and bit/pixel
bytestream_1 = enc_huffman_new(k-min(k)+1, BinCode_1, Codelengths_1);%encode Frame1 transfer coding with lena_small huffman 
bitPerPixel(1) = (numel(bytestream_1)*8) / (numel(Frame1)/3);% calculate the bit/pixel
k_rec = dec_huffman_new(bytestream_1, BinaryTree_1, length(k)) + min(k)-1;%decoding Frame1 transfer coding
I_rec = (IntraDecode((k_rec), size(Frame1),qScale));%Transfer decoding Frame1 and transfer to RGB
PSNR(1) = calcPSNR(Frame1, ictYCbCr2RGB(I_rec));%calculate PSNR(both RGB)
Frame_new_rec{1} = I_rec;%the first reconstructed Frame1( YCbCr)
fprintf('QP: %.1f bit-rate: %.2f bits/pixel PSNR: %.2fdB\n', qScale, bitPerPixel(1), PSNR(1))
%% use motion vector between Frame 1 and 2 to build a motion vector huffman table
Frame1_YCbCr = ictRGB2YCbCr(Frame1);%Frame1 YCbCr
Frame2_YCbCr = ictRGB2YCbCr(Frame2);%Frame2 YCbCr
mv_indices = SSD(Frame1_YCbCr, Frame2_YCbCr);%Mv between Frame1 and 2
PMF_2 = hist(mv_indices,1:81);%pmf of mv
PMF_2 = PMF_2/sum(PMF_2);
[BinaryTree_2, HuffCode_2, BinCode_2, Codelengths_2] = buildHuffman(PMF_2);%build huffman with mv

%% with for loop to reconstruct picutre and calculate the PSNR and bit/pixel
for i = 1:20
    %% load picture from folder and make it YCbCr
    Frame_pre = ['foreman20_40_RGB/foreman00',int2str(19+i),'.bmp'];
    Frame_new = ['foreman20_40_RGB/foreman00',int2str(19+i+1),'.bmp'];
    Frame_pre_YCbCr = ictRGB2YCbCr(double(imread(Frame_pre)));
    Frame_new_YCbCr = ictRGB2YCbCr(double(imread(Frame_new)));
        
    motion_vectors = SSD(Frame_new_rec{i},Frame_new_YCbCr);%mv between 2 Frames
    Frame_sender_rec = SSD_rec(Frame_new_rec{i},motion_vectors);%sender part reconstructed next frame with mv_vectors
    
    bytestream_mv{i} = enc_huffman_new(motion_vectors(:), BinCode_2, Codelengths_2);%encode mv with mv huffman table
    mv_decode = dec_huffman_new(bytestream_mv{i}, BinaryTree_2, length(motion_vectors(:)));  %decode mv the mv huffman table 
    mv_decode = reshape(mv_decode,size(motion_vectors));%reshape to the same size
    
    Frame_receive_rec = SSD_rec(Frame_new_rec{i}, mv_decode);%receiver part reconstructed next frame with decoded mv_vectors
    
    Prediction_error = ictYCbCr2RGB(Frame_new_YCbCr - Frame_sender_rec);% error between sender reconstrected Frame and true Frame
    err_en{i} = IntraEncode(Prediction_error, qScale);% transfer coding this error  
    err_rec = IntraDecode(err_en{i}, size(Prediction_error) , qScale);%transfer decode the error
    
    Frame_new_rec{i+1} = Frame_receive_rec + err_rec;% receiver reconstruted new Frame with decoded error
    PSNR(i+1) = calcPSNR(ictYCbCr2RGB(Frame_new_YCbCr),ictYCbCr2RGB(Frame_new_rec{i+1}));% calculate the PSNR between receiver reconstruted Frame and true Frame
    
end

% calculate minimum of all residuals
for h =1:20
        min_err_en_1(h) = min(err_en{h});
        max_err_en_1(h) = max(err_en{h});
end
mini_err_en_value = min(min_err_en_1);
maxi_err_en_value = max(max_err_en_1);
% build huffman table for residual
%% use prediction error between Frame 1 and 2 to buld prediction error huffman table
Frame2_rec = SSD_rec(Frame1_YCbCr, mv_indices);%reconstructed Frame2 with mv and Frame1 YCbCr
Prediction_error_1 = ictYCbCr2RGB(Frame2_rec - Frame2_YCbCr);%get the error of reconstructed Frame2 and true Frame2 YCbCr
Pre_error_encode = IntraEncode(Prediction_error_1, qScale);%transfer encoding the error
PMF_3 = hist(Pre_error_encode,mini_err_en_value:maxi_err_en_value);%get the pmf of transfer encoding error
PMF_3 = PMF_3/sum(PMF_3);
[BinaryTree_3, HuffCode_3, BinCode_3, Codelengths_3] = buildHuffman(PMF_3);%with transfer encoding error budild a huffman 

% second loop, encode residual images
for j=1:20
    bytestream_err{j} = enc_huffman_new(err_en{j}-mini_err_en_value+1, BinCode_3, Codelengths_3);%hufman coding it
    bitPerPixel(j+1) = ((numel(bytestream_err{j})+numel(bytestream_mv{j}))*8) / (numel(Frame_pre_YCbCr)/3);%calculate the bit/pixel
    err_rec = dec_huffman_new(bytestream_err{j}, BinaryTree_3, length(err_en{j})) + mini_err_en_value-1;%huffman decode the error 
end
waitbar(g/7,f,'Processing');

R_av(g) = mean(bitPerPixel);
D_av(g) = sum(PSNR)/length(PSNR);
g=g+1;
end
waitbar(1,f,'Finishing');close(f);
%PSNR_new = [39.24122282 37.1089672  35.78697705 34.84181023 34.12119539
%33.52920296 33.04901247];
PSNR_new2 = [39.65411966 36.95978007 35.51746868 34.5422275  33.81474007 33.22309146 32.78242168];
plot(R_av,D_av,'Marker','*')
hold on
plot(R_av,PSNR_new2,'Marker','*')


