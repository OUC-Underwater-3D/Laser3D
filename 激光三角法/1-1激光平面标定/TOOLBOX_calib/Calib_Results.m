% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2757.853890083540600 ; 2764.693038328679900 ];

%-- Principal point:
cc = [ 1252.186726363090700 ; 962.788208343733340 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.139679766484303 ; 0.344820828923546 ; -0.000945381359931 ; -0.000054598094883 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 29.746311961487635 ; 30.129352892912131 ];

%-- Principal point uncertainty:
cc_error = [ 23.946283276668453 ; 23.931653813374083 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.037034862381168 ; 0.224693730394785 ; 0.002462610528439 ; 0.002599876928895 ; 0.000000000000000 ];

%-- Image size:
nx = 2592;
ny = 1944;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 11;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -2.219696e+00 ; -2.202693e+00 ; -4.498791e-02 ];
Tc_1  = [ -5.553888e+01 ; -8.397394e+01 ; 4.026754e+02 ];
omc_error_1 = [ 9.772925e-03 ; 1.011334e-02 ; 2.167170e-02 ];
Tc_error_1  = [ 3.541647e+00 ; 3.514966e+00 ; 4.553038e+00 ];

%-- Image #2:
omc_2 = [ -1.974200e+00 ; -1.958051e+00 ; -1.469725e-01 ];
Tc_2  = [ -7.711117e+01 ; -7.139261e+01 ; 3.370444e+02 ];
omc_error_2 = [ 7.041214e-03 ; 7.539296e-03 ; 1.388122e-02 ];
Tc_error_2  = [ 2.960392e+00 ; 2.965109e+00 ; 3.667652e+00 ];

%-- Image #3:
omc_3 = [ -1.914782e+00 ; -1.771505e+00 ; -6.729966e-01 ];
Tc_3  = [ -8.403875e+01 ; -3.318392e+01 ; 2.940707e+02 ];
omc_error_3 = [ 6.371235e-03 ; 8.267702e-03 ; 1.229336e-02 ];
Tc_error_3  = [ 2.567594e+00 ; 2.590152e+00 ; 3.497202e+00 ];

%-- Image #4:
omc_4 = [ 2.204030e+00 ; 2.167941e+00 ; -2.666258e-01 ];
Tc_4  = [ -7.436157e+01 ; -1.055177e+02 ; 3.872059e+02 ];
omc_error_4 = [ 7.479383e-03 ; 9.064407e-03 ; 1.712861e-02 ];
Tc_error_4  = [ 3.421641e+00 ; 3.371957e+00 ; 4.114445e+00 ];

%-- Image #5:
omc_5 = [ -2.033478e+00 ; -1.987587e+00 ; 3.052751e-01 ];
Tc_5  = [ -9.672650e+01 ; -8.614868e+01 ; 3.727024e+02 ];
omc_error_5 = [ 8.601853e-03 ; 6.599362e-03 ; 1.422615e-02 ];
Tc_error_5  = [ 3.288512e+00 ; 3.270115e+00 ; 3.864934e+00 ];

%-- Image #6:
omc_6 = [ 2.160736e+00 ; 1.956065e+00 ; 5.045720e-01 ];
Tc_6  = [ -4.166803e+01 ; -7.496189e+01 ; 3.076368e+02 ];
omc_error_6 = [ 8.466078e-03 ; 5.736122e-03 ; 1.430099e-02 ];
Tc_error_6  = [ 2.726044e+00 ; 2.677755e+00 ; 3.599377e+00 ];

%-- Image #7:
omc_7 = [ -2.216622e+00 ; -2.165582e+00 ; 4.835895e-01 ];
Tc_7  = [ -6.143339e+01 ; -4.351718e+01 ; 3.772893e+02 ];
omc_error_7 = [ 8.178587e-03 ; 7.013226e-03 ; 1.538138e-02 ];
Tc_error_7  = [ 3.267100e+00 ; 3.258127e+00 ; 3.726384e+00 ];

%-- Image #8:
omc_8 = [ 1.801952e+00 ; 2.166642e+00 ; -1.433916e-01 ];
Tc_8  = [ -4.195759e+01 ; -8.195600e+01 ; 3.495825e+02 ];
omc_error_8 = [ 6.538093e-03 ; 7.790890e-03 ; 1.367263e-02 ];
Tc_error_8  = [ 3.059828e+00 ; 3.032203e+00 ; 3.560177e+00 ];

%-- Image #9:
omc_9 = [ -2.223879e+00 ; -1.945758e+00 ; -2.230621e-01 ];
Tc_9  = [ -4.241392e+01 ; -5.150798e+01 ; 3.219278e+02 ];
omc_error_9 = [ 6.873910e-03 ; 8.066182e-03 ; 1.526226e-02 ];
Tc_error_9  = [ 2.829267e+00 ; 2.806146e+00 ; 3.534535e+00 ];

%-- Image #10:
omc_10 = [ -1.987847e+00 ; -2.296948e+00 ; -2.497607e-02 ];
Tc_10  = [ -3.511826e+01 ; -5.303607e+01 ; 3.892862e+02 ];
omc_error_10 = [ 7.580775e-03 ; 1.035182e-02 ; 1.918259e-02 ];
Tc_error_10  = [ 3.391769e+00 ; 3.396089e+00 ; 4.318211e+00 ];

%-- Image #11:
omc_11 = [ -2.454561e+00 ; -1.821547e+00 ; -3.995743e-01 ];
Tc_11  = [ -7.076633e+01 ; -5.459171e+01 ; 3.425319e+02 ];
omc_error_11 = [ 7.689028e-03 ; 7.659865e-03 ; 1.632768e-02 ];
Tc_error_11  = [ 3.030163e+00 ; 2.997106e+00 ; 3.922978e+00 ];

