function [aftercorrect,imageFileNames]=Uw3D_PhotoCorrect(image_name)
         %%%aftercorrect
load matlab;
load calibrationSession;
% Define images to process
image_name=calibrationSession.BoardSet.FullPathNames;
imageFileNames = image_name;
for i=1:length(imageFileNames);
    originalImage = imread(imageFileNames{i});
    undistortedImage = undistortImage(originalImage, cameraParams);
    aftercorrect(:,:,:,i)=undistortedImage;
end