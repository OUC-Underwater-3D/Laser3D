% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 702.593579951721150 ; 703.493404266959710 ];

%-- Principal point:
cc = [ 303.062418251973720 ; 227.216377537601400 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.140782531709711 ; 0.202320075046486 ; -0.005511666612840 ; -0.000434201316873 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 5.702419976746697 ; 5.332084977343876 ];

%-- Principal point uncertainty:
cc_error = [ 7.787992070292221 ; 8.853652315824085 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.031685883422437 ; 0.188523588863025 ; 0.003058681874764 ; 0.002899012910546 ; 0.000000000000000 ];

%-- Image size:
nx = 648;
ny = 486;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 14;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.870323e+00 ; 2.207225e+00 ; 1.049942e+00 ];
Tc_1  = [ -6.775638e-02 ; -9.880175e-02 ; 3.657661e-01 ];
omc_error_1 = [ 1.108951e-02 ; 7.349383e-03 ; 1.807357e-02 ];
Tc_error_1  = [ 4.131174e-03 ; 4.736180e-03 ; 3.670568e-03 ];

%-- Image #2:
omc_2 = [ 2.008846e+00 ; 2.248511e+00 ; 5.039387e-01 ];
Tc_2  = [ -8.022728e-02 ; -1.088547e-01 ; 4.866979e-01 ];
omc_error_2 = [ 1.060867e-02 ; 1.009759e-02 ; 2.139309e-02 ];
Tc_error_2  = [ 5.469156e-03 ; 6.231628e-03 ; 4.497865e-03 ];

%-- Image #3:
omc_3 = [ 2.094275e+00 ; 1.837020e+00 ; 5.195270e-01 ];
Tc_3  = [ 1.475607e-02 ; -8.582234e-02 ; 4.961743e-01 ];
omc_error_3 = [ 1.207632e-02 ; 7.630615e-03 ; 1.983182e-02 ];
Tc_error_3  = [ 5.564581e-03 ; 6.235453e-03 ; 4.325939e-03 ];

%-- Image #4:
omc_4 = [ -1.865044e+00 ; -1.816461e+00 ; 2.869255e-01 ];
Tc_4  = [ 9.841878e-03 ; -1.012947e-01 ; 4.576027e-01 ];
omc_error_4 = [ 9.304100e-03 ; 8.087092e-03 ; 1.508375e-02 ];
Tc_error_4  = [ 5.112006e-03 ; 5.803343e-03 ; 3.707516e-03 ];

%-- Image #5:
omc_5 = [ -1.684999e+00 ; -1.901056e+00 ; 2.828222e-01 ];
Tc_5  = [ -1.139981e-01 ; -7.833938e-02 ; 4.055352e-01 ];
omc_error_5 = [ 1.098478e-02 ; 9.120600e-03 ; 1.582026e-02 ];
Tc_error_5  = [ 4.547375e-03 ; 5.206846e-03 ; 3.536716e-03 ];

%-- Image #6:
omc_6 = [ -2.098610e+00 ; -1.591826e+00 ; -5.519681e-01 ];
Tc_6  = [ -9.444237e-02 ; -4.086758e-02 ; 4.613807e-01 ];
omc_error_6 = [ 9.423151e-03 ; 9.906103e-03 ; 1.630983e-02 ];
Tc_error_6  = [ 5.136364e-03 ; 5.865046e-03 ; 4.265851e-03 ];

%-- Image #7:
omc_7 = [ -1.835543e+00 ; -1.814076e+00 ; 6.402152e-01 ];
Tc_7  = [ -5.593210e-02 ; -7.125659e-02 ; 5.465321e-01 ];
omc_error_7 = [ 1.104179e-02 ; 7.645252e-03 ; 1.586038e-02 ];
Tc_error_7  = [ 6.058958e-03 ; 6.880209e-03 ; 3.925179e-03 ];

%-- Image #8:
omc_8 = [ 2.354988e+00 ; -4.482498e-02 ; -4.323650e-02 ];
Tc_8  = [ -7.056957e-02 ; 4.331706e-02 ; 4.395860e-01 ];
omc_error_8 = [ 1.325317e-02 ; 5.758689e-03 ; 1.335788e-02 ];
Tc_error_8  = [ 4.893809e-03 ; 5.539435e-03 ; 4.276450e-03 ];

%-- Image #9:
omc_9 = [ -2.144021e+00 ; -1.697357e+00 ; -5.939620e-01 ];
Tc_9  = [ -1.234016e-01 ; -4.771588e-02 ; 4.677032e-01 ];
omc_error_9 = [ 1.011043e-02 ; 9.954658e-03 ; 1.723015e-02 ];
Tc_error_9  = [ 5.195830e-03 ; 6.011395e-03 ; 4.594077e-03 ];

%-- Image #10:
omc_10 = [ -1.574743e+00 ; -2.113774e+00 ; -1.505531e-01 ];
Tc_10  = [ -3.248880e-02 ; -8.080852e-02 ; 4.715860e-01 ];
omc_error_10 = [ 8.009049e-03 ; 1.072821e-02 ; 1.713174e-02 ];
Tc_error_10  = [ 5.234514e-03 ; 5.978574e-03 ; 4.084618e-03 ];

%-- Image #11:
omc_11 = [ -1.852415e+00 ; -2.062502e+00 ; -4.162400e-01 ];
Tc_11  = [ -1.106636e-01 ; -9.884670e-02 ; 4.887409e-01 ];
omc_error_11 = [ 9.372582e-03 ; 1.053839e-02 ; 1.826095e-02 ];
Tc_error_11  = [ 5.457849e-03 ; 6.303506e-03 ; 4.848140e-03 ];

%-- Image #12:
omc_12 = [ -2.088873e+00 ; -1.343413e+00 ; 5.371492e-01 ];
Tc_12  = [ 1.741838e-03 ; -1.329083e-02 ; 5.501291e-01 ];
omc_error_12 = [ 1.075587e-02 ; 7.341634e-03 ; 1.491299e-02 ];
Tc_error_12  = [ 6.097499e-03 ; 6.890184e-03 ; 4.007667e-03 ];

%-- Image #13:
omc_13 = [ 1.480826e+00 ; 2.062113e+00 ; 8.418302e-01 ];
Tc_13  = [ -1.019506e-01 ; -9.001735e-02 ; 4.256001e-01 ];
omc_error_13 = [ 9.696808e-03 ; 8.634638e-03 ; 1.605891e-02 ];
Tc_error_13  = [ 4.801914e-03 ; 5.496965e-03 ; 3.970342e-03 ];

%-- Image #14:
omc_14 = [ 1.848254e+00 ; 2.531653e+00 ; -2.259572e-02 ];
Tc_14  = [ -6.627133e-02 ; -7.487428e-02 ; 5.919297e-01 ];
omc_error_14 = [ 1.316994e-02 ; 1.762992e-02 ; 3.328067e-02 ];
Tc_error_14  = [ 6.583832e-03 ; 7.485272e-03 ; 5.301914e-03 ];

