function [aftercorrect,imageFileNames]=Uw3D_PhotoCorrect( )


imageFileNames = {'D:\Matlab\calib_example\C1.bmp',...
    'D:\Matlab\calib_example\C2.bmp',...
    'D:\Matlab\calib_example\C3.bmp',...
    'D:\Matlab\calib_example\C4.bmp',...
    'D:\Matlab\calib_example\C5.bmp',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Generate world coordinates of the corners of the squares
squareSize = 30;  % in units of 'mm'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'mm', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', []);
for i=1:length(imageFileNames);
originalImage = imread(imageFileNames{i});
undistortedImage = undistortImage(originalImage, cameraParams);
aftercorrect(i,:,:)=rgb2gray(undistortedImage);
end

