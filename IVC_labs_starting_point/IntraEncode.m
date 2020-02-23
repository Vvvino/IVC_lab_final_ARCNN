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