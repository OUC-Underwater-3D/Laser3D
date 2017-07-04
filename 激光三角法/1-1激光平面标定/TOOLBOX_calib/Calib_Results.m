% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 928.617455533955190 ; 930.081927491116290 ];

%-- Principal point:
cc = [ 345.168977653240060 ; 246.640990492586470 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.121339008876749 ; 0.250046565521314 ; 0.001565917713542 ; 0.015110242428423 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 4.288133558625104 ; 4.429257495241102 ];

%-- Principal point uncertainty:
cc_error = [ 9.819799835673834 ; 7.968275677590071 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.034169449464140 ; 0.313486500888176 ; 0.003899798215747 ; 0.005400821964550 ; 0.000000000000000 ];

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
omc_1 = [ -1.835453e+00 ; -1.880920e+00 ; -6.829316e-01 ];
Tc_1  = [ -9.751186e-02 ; -3.259329e-02 ; 4.656598e-01 ];
omc_error_1 = [ 6.090777e-03 ; 8.249123e-03 ; 1.390132e-02 ];
Tc_error_1  = [ 4.925293e-03 ; 4.086070e-03 ; 2.388405e-03 ];

%-- Image #2:
omc_2 = [ -2.466584e+00 ; -1.076578e+00 ; -1.015231e+00 ];
Tc_2  = [ -1.482363e-01 ; 3.187345e-02 ; 4.490132e-01 ];
omc_error_2 = [ 7.930559e-03 ; 6.338741e-03 ; 1.451817e-02 ];
Tc_error_2  = [ 4.838669e-03 ; 3.942979e-03 ; 2.615421e-03 ];

%-- Image #3:
omc_3 = [ -2.523188e+00 ; -1.037632e+00 ; -1.020325e+00 ];
Tc_3  = [ -9.862648e-02 ; 3.689546e-02 ; 4.514498e-01 ];
omc_error_3 = [ 7.633692e-03 ; 6.634877e-03 ; 1.524200e-02 ];
Tc_error_3  = [ 4.823789e-03 ; 3.895048e-03 ; 2.416454e-03 ];

%-- Image #4:
omc_4 = [ 1.665668e+00 ; 1.765696e+00 ; 8.083104e-01 ];
Tc_4  = [ -7.231750e-02 ; -6.540187e-02 ; 4.395453e-01 ];
omc_error_4 = [ 8.090425e-03 ; 7.607913e-03 ; 1.223014e-02 ];
Tc_error_4  = [ 4.719358e-03 ; 3.808968e-03 ; 2.385386e-03 ];

%-- Image #5:
omc_5 = [ 2.005944e+00 ; 1.235479e+00 ; 5.467937e-01 ];
Tc_5  = [ -7.734561e-02 ; -4.479832e-02 ; 4.415958e-01 ];
omc_error_5 = [ 7.910100e-03 ; 6.690408e-03 ; 1.351672e-02 ];
Tc_error_5  = [ 4.711885e-03 ; 3.807928e-03 ; 2.313164e-03 ];

%-- Image #6:
omc_6 = [ -1.712755e+00 ; -1.858179e+00 ; -1.319455e-01 ];
Tc_6  = [ -8.767635e-02 ; -6.697585e-02 ; 4.801044e-01 ];
omc_error_6 = [ 6.509179e-03 ; 8.097025e-03 ; 1.346229e-02 ];
Tc_error_6  = [ 5.098294e-03 ; 4.187653e-03 ; 2.089029e-03 ];

%-- Image #7:
omc_7 = [ -1.667193e+00 ; -1.751842e+00 ; -2.945447e-01 ];
Tc_7  = [ -1.081442e-01 ; -5.433467e-02 ; 4.537887e-01 ];
omc_error_7 = [ 6.504527e-03 ; 8.198224e-03 ; 1.266430e-02 ];
Tc_error_7  = [ 4.814274e-03 ; 3.988087e-03 ; 2.139812e-03 ];

%-- Image #8:
omc_8 = [ -1.559022e+00 ; -1.620666e+00 ; -9.369615e-01 ];
Tc_8  = [ -1.204644e-01 ; -1.660128e-02 ; 4.200785e-01 ];
omc_error_8 = [ 7.066897e-03 ; 8.641882e-03 ; 1.164942e-02 ];
Tc_error_8  = [ 4.448504e-03 ; 3.708005e-03 ; 2.309830e-03 ];

%-- Image #9:
omc_9 = [ -1.694736e+00 ; -1.642853e+00 ; -8.993513e-01 ];
Tc_9  = [ -1.261792e-01 ; -6.334497e-02 ; 4.317853e-01 ];
omc_error_9 = [ 6.529781e-03 ; 7.914878e-03 ; 1.209836e-02 ];
Tc_error_9  = [ 4.613605e-03 ; 3.889384e-03 ; 2.401036e-03 ];

%-- Image #10:
omc_10 = [ 2.162285e+00 ; 7.336648e-02 ; 7.677207e-02 ];
Tc_10  = [ -1.177722e-01 ; -2.372867e-03 ; 4.306103e-01 ];
omc_error_10 = [ 9.286508e-03 ; 6.459959e-03 ; 1.185732e-02 ];
Tc_error_10  = [ 4.556198e-03 ; 3.774973e-03 ; 2.444142e-03 ];

%-- Image #11:
omc_11 = [ -1.839313e+00 ; -1.673411e+00 ; -8.325586e-01 ];
Tc_11  = [ -1.105423e-01 ; -6.824448e-02 ; 4.502501e-01 ];
omc_error_11 = [ 6.128565e-03 ; 7.646553e-03 ; 1.268111e-02 ];
Tc_error_11  = [ 4.821307e-03 ; 4.034957e-03 ; 2.348415e-03 ];

%-- Image #12:
omc_12 = [ -1.879450e+00 ; -1.532956e+00 ; -9.505536e-01 ];
Tc_12  = [ -9.674669e-02 ; -5.797326e-02 ; 4.387127e-01 ];
omc_error_12 = [ 6.287515e-03 ; 7.711167e-03 ; 1.260306e-02 ];
Tc_error_12  = [ 4.698656e-03 ; 3.905713e-03 ; 2.254198e-03 ];

%-- Image #13:
omc_13 = [ -1.558742e+00 ; -1.765251e+00 ; -8.133648e-01 ];
Tc_13  = [ -9.604711e-02 ; -8.277651e-02 ; 4.358679e-01 ];
omc_error_13 = [ 6.022452e-03 ; 8.262947e-03 ; 1.194455e-02 ];
Tc_error_13  = [ 4.665548e-03 ; 3.913012e-03 ; 2.262145e-03 ];

%-- Image #14:
omc_14 = [ -1.701042e+00 ; -1.532314e+00 ; -1.002845e+00 ];
Tc_14  = [ -1.110097e-01 ; -4.219980e-02 ; 4.090979e-01 ];
omc_error_14 = [ 7.057591e-03 ; 8.113282e-03 ; 1.191924e-02 ];
Tc_error_14  = [ 4.356169e-03 ; 3.648083e-03 ; 2.258328e-03 ];

