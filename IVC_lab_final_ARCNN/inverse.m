clear;
folder = 'compression_cnn/train2_label/';
for qScale = 0.15:0.3:1.95
    for i = 0:199
        imgpath = [folder,'BSDS',num2str(i,'%.3i'),'.jpg'];
        image = double(imread(imgpath));
        if size(image,1) == 481
            image = imrotate(image,90);
            %imshow(image/255);
        end
        imwrite(image/255,imgpath);
        
        outputpath = ['compression_cnn/train2_feature/Q',num2str(qScale),'/BSDSQ',num2str(qScale),num2str(i,'%.3i'),'.jpg'];
        image2 = double(imread(outputpath));
        if size(image2,1) == 481
            image2 = imrotate(image2,90);
            %imshow(image/255);
        end
        imwrite(image2/255,outputpath);
    end
    j = j+1;
end