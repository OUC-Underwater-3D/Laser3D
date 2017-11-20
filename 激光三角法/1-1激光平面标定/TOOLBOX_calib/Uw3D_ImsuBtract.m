A=imread('D:\Matlab\calib_example\A_cret1.BMP');
B=imread('D:\Matlab\calib_example\A1.BMP');
C=rgb2gray(B);
D=imsubtract(A,C);
figure;imshow(D);