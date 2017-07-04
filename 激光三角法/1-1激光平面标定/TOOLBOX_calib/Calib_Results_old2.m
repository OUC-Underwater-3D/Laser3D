% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2122.670541922674100 ; 2122.118833200811900 ];

%-- Principal point:
cc = [ 806.406331573036140 ; 596.105243831167060 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.382377379833108 ; 0.827999816576536 ; -0.000126279316408 ; 0.001419001565422 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 19.206802344482288 ; 19.027816837263529 ];

%-- Principal point uncertainty:
cc_error = [ 17.952173526031839 ; 16.462231820877648 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.032755983363612 ; 0.200919631297761 ; 0.001526276791533 ; 0.001407183537664 ; 0.000000000000000 ];

%-- Image size:
nx = 1600;
ny = 1200;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 24;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -2.220909e+00 ; -2.222700e+00 ; -1.268481e-02 ];
Tc_1  = [ -1.028717e-01 ; -5.827241e-02 ; 5.227179e-01 ];
omc_error_1 = [ 1.259760e-02 ; 1.308789e-02 ; 2.828140e-02 ];
Tc_error_1  = [ 4.454300e-03 ; 4.101352e-03 ; 5.165969e-03 ];

%-- Image #2:
omc_2 = [ -1.858993e+00 ; -2.252317e+00 ; -3.426840e-01 ];
Tc_2  = [ -1.017944e-01 ; -7.171914e-02 ; 4.295527e-01 ];
omc_error_2 = [ 6.637507e-03 ; 9.384909e-03 ; 1.651867e-02 ];
Tc_error_2  = [ 3.666151e-03 ; 3.403494e-03 ; 4.273126e-03 ];

%-- Image #3:
omc_3 = [ NaN ; NaN ; NaN ];
Tc_3  = [ NaN ; NaN ; NaN ];
omc_error_3 = [ NaN ; NaN ; NaN ];
Tc_error_3  = [ NaN ; NaN ; NaN ];

%-- Image #4:
omc_4 = [ NaN ; NaN ; NaN ];
Tc_4  = [ NaN ; NaN ; NaN ];
omc_error_4 = [ NaN ; NaN ; NaN ];
Tc_error_4  = [ NaN ; NaN ; NaN ];

%-- Image #5:
omc_5 = [ 1.579421e+00 ; 2.055207e+00 ; 3.949664e-01 ];
Tc_5  = [ -1.320724e-02 ; -7.688613e-02 ; 3.868719e-01 ];
omc_error_5 = [ 7.406734e-03 ; 7.340989e-03 ; 1.176762e-02 ];
Tc_error_5  = [ 3.292672e-03 ; 3.017263e-03 ; 3.721748e-03 ];

%-- Image #6:
omc_6 = [ -2.229054e+00 ; -1.969780e+00 ; 4.162297e-01 ];
Tc_6  = [ -7.217572e-02 ; -6.788510e-02 ; 4.841844e-01 ];
omc_error_6 = [ 8.863584e-03 ; 7.343274e-03 ; 1.739243e-02 ];
Tc_error_6  = [ 4.121426e-03 ; 3.752776e-03 ; 4.173315e-03 ];

%-- Image #7:
omc_7 = [ -2.238145e+00 ; -2.056863e+00 ; -6.559445e-01 ];
Tc_7  = [ -3.074223e-02 ; -8.408519e-02 ; 4.054440e-01 ];
omc_error_7 = [ 6.024140e-03 ; 8.738251e-03 ; 1.575641e-02 ];
Tc_error_7  = [ 3.502481e-03 ; 3.173327e-03 ; 4.103283e-03 ];

%-- Image #8:
omc_8 = [ NaN ; NaN ; NaN ];
Tc_8  = [ NaN ; NaN ; NaN ];
omc_error_8 = [ NaN ; NaN ; NaN ];
Tc_error_8  = [ NaN ; NaN ; NaN ];

%-- Image #9:
omc_9 = [ NaN ; NaN ; NaN ];
Tc_9  = [ NaN ; NaN ; NaN ];
omc_error_9 = [ NaN ; NaN ; NaN ];
Tc_error_9  = [ NaN ; NaN ; NaN ];

%-- Image #10:
omc_10 = [ -1.981509e+00 ; -1.998704e+00 ; 5.242006e-01 ];
Tc_10  = [ -1.503636e-01 ; -1.070308e-01 ; 5.131468e-01 ];
omc_error_10 = [ 8.920993e-03 ; 6.367521e-03 ; 1.397355e-02 ];
Tc_error_10  = [ 4.440640e-03 ; 4.084080e-03 ; 4.372108e-03 ];

%-- Image #11:
omc_11 = [ -1.920169e+00 ; -1.864588e+00 ; -1.493021e-01 ];
Tc_11  = [ -1.628352e-01 ; -8.793028e-02 ; 4.452262e-01 ];
omc_error_11 = [ 7.491335e-03 ; 7.413050e-03 ; 1.317861e-02 ];
Tc_error_11  = [ 3.817778e-03 ; 3.581257e-03 ; 4.233345e-03 ];

%-- Image #12:
omc_12 = [ 1.917115e+00 ; 1.941536e+00 ; -5.451814e-01 ];
Tc_12  = [ -1.142841e-01 ; -4.540235e-02 ; 5.013864e-01 ];
omc_error_12 = [ 6.227347e-03 ; 8.304518e-03 ; 1.367112e-02 ];
Tc_error_12  = [ 4.266929e-03 ; 3.938410e-03 ; 4.253736e-03 ];

%-- Image #13:
omc_13 = [ 2.309635e+00 ; 1.529572e+00 ; -6.206134e-01 ];
Tc_13  = [ -1.020960e-01 ; -7.714427e-03 ; 4.983812e-01 ];
omc_error_13 = [ 7.683816e-03 ; 7.106782e-03 ; 1.372836e-02 ];
Tc_error_13  = [ 4.248001e-03 ; 3.879332e-03 ; 4.239982e-03 ];

%-- Image #14:
omc_14 = [ 1.916585e+00 ; 2.272744e+00 ; 1.204132e-01 ];
Tc_14  = [ -1.085431e-01 ; -1.001841e-01 ; 4.557545e-01 ];
omc_error_14 = [ 8.618806e-03 ; 1.098898e-02 ; 1.981206e-02 ];
Tc_error_14  = [ 3.924695e-03 ; 3.603829e-03 ; 4.364218e-03 ];

%-- Image #15:
omc_15 = [ -2.044964e+00 ; -1.951009e+00 ; 4.334449e-01 ];
Tc_15  = [ -1.156519e-01 ; -5.414000e-02 ; 5.022532e-01 ];
omc_error_15 = [ 8.357486e-03 ; 7.224706e-03 ; 1.470130e-02 ];
Tc_error_15  = [ 4.287948e-03 ; 3.945491e-03 ; 4.238809e-03 ];

%-- Image #16:
omc_16 = [ -2.224704e+00 ; -2.209836e+00 ; -2.088402e-02 ];
Tc_16  = [ -8.135306e-02 ; -4.386292e-02 ; 5.226782e-01 ];
omc_error_16 = [ 1.181910e-02 ; 1.308070e-02 ; 2.712993e-02 ];
Tc_error_16  = [ 4.450995e-03 ; 4.086442e-03 ; 5.190583e-03 ];

%-- Image #17:
omc_17 = [ -2.179422e+00 ; -1.842985e+00 ; 2.830802e-01 ];
Tc_17  = [ -1.552019e-01 ; -3.494164e-02 ; 5.072762e-01 ];
omc_error_17 = [ 8.805692e-03 ; 7.092346e-03 ; 1.584541e-02 ];
Tc_error_17  = [ 4.342528e-03 ; 4.023474e-03 ; 4.484489e-03 ];

%-- Image #18:
omc_18 = [ 2.137899e+00 ; 1.918385e+00 ; -6.342131e-01 ];
Tc_18  = [ -1.362805e-01 ; -2.326709e-02 ; 5.011100e-01 ];
omc_error_18 = [ 6.571347e-03 ; 8.283833e-03 ; 1.467541e-02 ];
Tc_error_18  = [ 4.261901e-03 ; 3.954921e-03 ; 4.229708e-03 ];

%-- Image #19:
omc_19 = [ 1.680358e+00 ; 2.410349e+00 ; 3.668539e-01 ];
Tc_19  = [ -2.607209e-02 ; -9.009674e-02 ; 4.316483e-01 ];
omc_error_19 = [ 7.817575e-03 ; 8.899983e-03 ; 1.565913e-02 ];
Tc_error_19  = [ 3.680318e-03 ; 3.376669e-03 ; 4.221629e-03 ];

%-- Image #20:
omc_20 = [ NaN ; NaN ; NaN ];
Tc_20  = [ NaN ; NaN ; NaN ];
omc_error_20 = [ NaN ; NaN ; NaN ];
Tc_error_20  = [ NaN ; NaN ; NaN ];

%-- Image #21:
omc_21 = [ 2.238656e+00 ; 1.878548e+00 ; -7.421172e-01 ];
Tc_21  = [ -1.363705e-01 ; -4.805067e-02 ; 4.966446e-01 ];
omc_error_21 = [ 6.252411e-03 ; 8.435446e-03 ; 1.458774e-02 ];
Tc_error_21  = [ 4.253129e-03 ; 3.930473e-03 ; 4.129009e-03 ];

%-- Image #22:
omc_22 = [ -1.901647e+00 ; -1.986735e+00 ; -2.531825e-01 ];
Tc_22  = [ -1.084733e-01 ; -6.192921e-02 ; 4.406039e-01 ];
omc_error_22 = [ 6.679818e-03 ; 8.457478e-03 ; 1.430920e-02 ];
Tc_error_22  = [ 3.759327e-03 ; 3.475246e-03 ; 4.240093e-03 ];

%-- Image #23:
omc_23 = [ 1.878510e+00 ; 1.882992e+00 ; -5.866769e-01 ];
Tc_23  = [ -1.087826e-01 ; -4.398023e-02 ; 5.006352e-01 ];
omc_error_23 = [ 6.066512e-03 ; 8.113751e-03 ; 1.293163e-02 ];
Tc_error_23  = [ 4.261389e-03 ; 3.925832e-03 ; 4.201191e-03 ];

%-- Image #24:
omc_24 = [ -1.922098e+00 ; -1.976143e+00 ; 4.620629e-01 ];
Tc_24  = [ -1.162084e-01 ; -8.451666e-02 ; 5.010621e-01 ];
omc_error_24 = [ 8.192355e-03 ; 6.953328e-03 ; 1.377845e-02 ];
Tc_error_24  = [ 4.301063e-03 ; 3.943610e-03 ; 4.206884e-03 ];

