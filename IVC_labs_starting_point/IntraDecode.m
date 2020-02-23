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
        dst =  I_dct_De;        
end