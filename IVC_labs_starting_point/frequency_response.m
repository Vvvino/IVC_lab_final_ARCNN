W1 = [1 2 1;2 4 2;1 2 1];
Y = fft2(W1);
imagesc(abs(fftshift(Y)))

