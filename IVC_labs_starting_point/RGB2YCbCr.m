function [image_YCbCr_PCA,T,offset] = RGB2YCbCr(image)

[m,n,c] = size(image);
R = image(:,:,1);
R_sample = zeros(size(R));

G = image(:,:,2);
G_sample = zeros(size(G));

B = image(:,:,3);
B_sample = zeros(size(B));

for i = 1:16:m
    for j = 1:16:n
        m_R = R(i:i+15,j:j+15);
        R_sample(i:i+15,j:j+15) = R(i:i+15,j:j+15) - mean(m_R(:));
        m_G = G(i:i+15,j:j+15);
        G_sample(i:i+15,j:j+15) = R(i:i+15,j:j+15) - mean(m_G(:));
        m_B = R(i:i+15,j:j+15);
        B_sample(i:i+15,j:j+15) = R(i:i+15,j:j+15) - mean(m_B(:));               
    end
end

R_sample_1 = R_sample(:);
G_sample_1 = G_sample(:);
B_sample_1 = B_sample(:);
S_sample(:,1) = R_sample_1;
S_sample(:,2) = G_sample_1;
S_sample(:,3) = B_sample_1;

COV_R = S_sample'*S_sample;
[V,D,W] = eig(COV_R);
[d,ind] = sort(diag(D),'descend');
Ds = D(ind,ind);
Vs = V(:,ind);
Ws = W(:,ind);

xp = Vs(:,1);
yp = Vs(:,2);
zp = Vs(:,3);

x = xp'/norm(xp,1)*219/255;
ScaleCb = 224/255/(abs(yp(1,1))+abs(yp(2,1))+abs(yp(3,1)));
y = yp'* ScaleCb;
ScaleCr = 224/255/(abs(zp(1,1))+abs(zp(2,1))+abs(zp(3,1)));
z = zp'* ScaleCr;

T(1,:) = x;
T(2,:) = y;
T(3,:) = z;

Y_offset = 16;
Cb_offset = -1*(sum(y<0))*255+16;
Cr_offset = -1*(sum(z<0))*255+16;

offset = [Y_offset,Cb_offset,Cr_offset]';

Y = x(1,1)*R + x(1,2)*G +x(1,3)*B + Y_offset;
Cb = y(1,1)*R + y(1,2)*G +y(1,3)*B + Cb_offset;
Cr = z(1,1)*R + z(1,2)*G +z(1,3)*B + Cr_offset;

image_YCbCr_PCA(:,:,1) = Y;
image_YCbCr_PCA(:,:,2) = Cb;
image_YCbCr_PCA(:,:,3) = Cr;

end


