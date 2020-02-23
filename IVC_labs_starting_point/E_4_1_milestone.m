lena_small = double(imread('data/images/lena_small.tif'));
Lena       = double(imread('data/images/lena.tif'));
path(path,'encoder')          
path(path,'decoder')            
path(path,'analysis')
scales = 1 : 0.6 : 1; % quantization scale factor, for E(4-1), we just evaluate scale factor of 1
for scaleIdx = 1 : numel(scales)
    qScale   = scales(scaleIdx);
    k_small  = IntraEncode(lena_small, qScale);
    k        = IntraEncode(Lena, qScale);
    %% use pmf of k_small to build and train huffman table
    %your code here
    PMF = stats_marg(k_small);
    [BinaryTree, HuffCode, BinCode, Codelengths] = buildHuffman(PMF);
    %% use trained table to encode k to get the bytestream
    % your code here
    [bytestream] = enc_huffman_new(k+256, BinCode, Codelengths);
    bitPerPixel(scaleIdx) = (numel(bytestream)*8) / (numel(Lena)/3);
    k_rec = dec_huffman_new(bytestream, BinaryTree, length(k))-256;
    %% image reconstruction
    I_rec = IntraDecode(k_rec, size(Lena),qScale);
    PSNR(scaleIdx) = calcPSNR(Lena, I_rec);
    fprintf('QP: %.1f bit-rate: %.2f bits/pixel PSNR: %.2fdB\n', qScale, bitPerPixel(scaleIdx), PSNR(scaleIdx))
end

%% put all used sub-functions here.
function dst = IntraDecode(image, img_size , qScale)
%  Function Name : IntraDecode.m
%  Input         : image (zero-run encoded image, 1xN)
%                  img_size (original image size)
%                  qScale(quantization scale)
%  Output        : dst   (decoded image)
        dst_De = ZeroRunDec(image);
        I_zz_De = reshape(dst_De,img_size(1)*8, (img_size(2)/8)*3);
        I_zz_De_1 = blockproc(I_zz_De, [64, 3], @(block_struct) DeZigZag8x8(block_struct.data));
        I_quant_De = blockproc(I_zz_De_1, [8, 8], @(block_struct) DeQuant8x8(block_struct.data, qScale));
        I_dct_De = blockproc(I_quant_De, [8, 8], @(block_struct) IDCT8x8(block_struct.data));
        dst = ictYCbCr2RGB(I_dct_De);         
end

function dst = IntraEncode(image, qScale)
%  Function Name : IntraEncode.m
%  Input         : image (Original RGB Image)
%                  qScale(quantization scale)
%  Output        : dst   (sequences after zero-run encoding, 1xN)
         imageYCbCr = ictRGB2YCbCr(image);
         I_dct = blockproc(imageYCbCr, [8, 8], @(block_struct) DCT8x8(block_struct.data));
         I_quant = blockproc(I_dct, [8, 8], @(block_struct) Quant8x8(block_struct.data, qScale));
         I_zz = blockproc(I_quant, [8, 8], @(block_struct) ZigZag8x8(block_struct.data));
         dst = ZeroRunEnc(I_zz(:)');
end