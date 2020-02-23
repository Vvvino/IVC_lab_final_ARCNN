clear;
label = {'smandril.tif-starting algorithm','lena.tif-starting algorithm','monarch.tif-starting algorithm','satpic1.bmp-subsample-prefiltered','satpic1.bmp-subsample-unprefiltered','sail.tif-resample()algorithm','lena.tif-resample()algorithm','sail.tif-chrominance-subsampling','lena.tif-huffmancoding'};
bitrate = [8,8,8,6,6,6,6,12,6.731];
PSNR = [16.6579,15.4940,17.0555,27.2989,27.5048,33.6502,37.4886,49.6624,37.7059];
plot(bitrate,PSNR,'s','MarkerSize',10),
xlabel('Bit per pixle'),ylabel('PSNR[dB]')
xlim([0 20]),ylim([10,50]);
for i = 1:9
    text(bitrate(i)+2,PSNR(i),label{i});
end