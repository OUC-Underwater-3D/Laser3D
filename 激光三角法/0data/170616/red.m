A = imread('w4.bmp');
A(:,:,2) = A(:,:,1);
A(:,:,3) = A(:,:,1);
imshow(A);
imwrite(A,'cc4.bmp');