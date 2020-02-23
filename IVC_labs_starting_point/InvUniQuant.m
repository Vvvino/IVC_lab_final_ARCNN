function image = InvUniQuant(qImage, bits)
    [w,l,d] = size(qImage);
    q_R = qImage(:,:,1);
    q_G = qImage(:,:,2);
    q_B = qImage(:,:,3);
    q_RGB = qImage(:);
    [m,n] = size(q_RGB);

    for i = 1:m
     image(i) = ((qImage(i)/2^bits)+0.5*(1/2^bits))*256; 
    end
    image = reshape(image,[w,l,d]);
end