function image = InvLloydMax(qImage, clusters)
    [m,n,l] = size(qImage);
    qImage1 = qImage(:);
    g = length(qImage1);
    q = length(clusters);
    for i = 1:g
        qImage(i) = clusters(qImage(i));
    end
    image = reshape(qImage,[m,n,l]);

end