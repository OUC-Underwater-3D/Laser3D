% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2047.123455157985700 ; 2052.372558721437600 ];

%-- Principal point:
cc = [ 1238.387791724818000 ; 904.145036763386430 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.336698075665891 ; 0.162919622678280 ; 0.000993181953937 ; -0.000728064381730 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 8.797452226114787 ; 9.204792435888541 ];

%-- Principal point uncertainty:
cc_error = [ 10.823629242679999 ; 10.160660170596460 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.009340883250662 ; 0.019955810615752 ; 0.001014654627669 ; 0.000697195819452 ; 0.000000000000000 ];

%-- Image size:
nx = 2560;
ny = 1920;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 20;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -3.131668e+00 ; 1.479954e-02 ; 2.474540e-03 ];
Tc_1  = [ -1.062784e+02 ; 9.755050e+01 ; 3.972483e+02 ];
omc_error_1 = [ 7.492931e-03 ; 1.258402e-03 ; 1.140522e-02 ];
Tc_error_1  = [ 2.127979e+00 ; 1.993931e+00 ; 1.998413e+00 ];

%-- Image #2:
omc_2 = [ -2.812912e+00 ; 2.090349e-02 ; -2.888807e-01 ];
Tc_2  = [ -9.788549e+01 ; 1.232817e+02 ; 3.828070e+02 ];
omc_error_2 = [ 5.661985e-03 ; 1.976235e-03 ; 8.547709e-03 ];
Tc_error_2  = [ 2.065396e+00 ; 1.909751e+00 ; 1.896907e+00 ];

%-- Image #3:
omc_3 = [ -2.758186e+00 ; -6.468541e-02 ; 2.176267e-01 ];
Tc_3  = [ -9.136088e+01 ; 1.103148e+02 ; 3.869429e+02 ];
omc_error_3 = [ 5.372703e-03 ; 2.092879e-03 ; 8.060144e-03 ];
Tc_error_3  = [ 2.082247e+00 ; 1.920880e+00 ; 1.707213e+00 ];

%-- Image #4:
omc_4 = [ 2.978579e+00 ; 2.484240e-01 ; 3.573970e-01 ];
Tc_4  = [ -1.017522e+02 ; 1.220356e+02 ; 3.525223e+02 ];
omc_error_4 = [ 6.542702e-03 ; 1.435017e-03 ; 1.014936e-02 ];
Tc_error_4  = [ 1.941729e+00 ; 1.784691e+00 ; 1.943402e+00 ];

%-- Image #5:
omc_5 = [ -2.591495e+00 ; 4.916346e-02 ; -1.987337e-01 ];
Tc_5  = [ -9.456760e+01 ; 1.118816e+02 ; 4.120019e+02 ];
omc_error_5 = [ 5.327780e-03 ; 2.428274e-03 ; 7.528016e-03 ];
Tc_error_5  = [ 2.207373e+00 ; 2.048589e+00 ; 1.863455e+00 ];

%-- Image #6:
omc_6 = [ 2.810893e+00 ; -1.417485e-01 ; 4.783843e-01 ];
Tc_6  = [ -9.834506e+01 ; 1.211882e+02 ; 3.630629e+02 ];
omc_error_6 = [ 6.282370e-03 ; 1.843773e-03 ; 8.912296e-03 ];
Tc_error_6  = [ 2.002253e+00 ; 1.857466e+00 ; 2.030114e+00 ];

%-- Image #7:
omc_7 = [ -2.643124e+00 ; 3.266784e-02 ; -8.946344e-01 ];
Tc_7  = [ -1.174689e+02 ; 1.187033e+02 ; 3.978094e+02 ];
omc_error_7 = [ 5.717115e-03 ; 2.710100e-03 ; 7.428779e-03 ];
Tc_error_7  = [ 2.157732e+00 ; 2.001538e+00 ; 2.103014e+00 ];

%-- Image #8:
omc_8 = [ 2.782356e+00 ; 1.105240e-01 ; -3.180141e-01 ];
Tc_8  = [ -9.943669e+01 ; 9.416095e+01 ; 4.626652e+02 ];
omc_error_8 = [ 6.746714e-03 ; 1.902431e-03 ; 9.152922e-03 ];
Tc_error_8  = [ 2.466141e+00 ; 2.303173e+00 ; 2.184975e+00 ];

%-- Image #9:
omc_9 = [ -3.045803e+00 ; -1.087651e-02 ; -6.336324e-01 ];
Tc_9  = [ -1.005893e+02 ; 1.017057e+02 ; 4.715533e+02 ];
omc_error_9 = [ 6.980143e-03 ; 2.144625e-03 ; 1.054083e-02 ];
Tc_error_9  = [ 2.536073e+00 ; 2.361747e+00 ; 2.509797e+00 ];

%-- Image #10:
omc_10 = [ 3.064789e+00 ; 7.488747e-02 ; -6.085784e-01 ];
Tc_10  = [ -1.153930e+02 ; 9.715652e+01 ; 4.887631e+02 ];
omc_error_10 = [ 6.207363e-03 ; 2.284371e-03 ; 9.653117e-03 ];
Tc_error_10  = [ 2.600457e+00 ; 2.441888e+00 ; 2.165507e+00 ];

%-- Image #11:
omc_11 = [ -2.556010e+00 ; -8.321102e-03 ; -1.693483e-01 ];
Tc_11  = [ -1.033885e+02 ; 8.605035e+01 ; 4.837255e+02 ];
omc_error_11 = [ 5.439080e-03 ; 2.434627e-03 ; 7.638890e-03 ];
Tc_error_11  = [ 2.569821e+00 ; 2.401715e+00 ; 2.122383e+00 ];

%-- Image #12:
omc_12 = [ 2.758354e+00 ; -1.948633e-02 ; 4.214405e-02 ];
Tc_12  = [ -9.480960e+01 ; 8.965282e+01 ; 4.756058e+02 ];
omc_error_12 = [ 7.276076e-03 ; 1.889411e-03 ; 9.854060e-03 ];
Tc_error_12  = [ 2.542532e+00 ; 2.374631e+00 ; 2.414364e+00 ];

%-- Image #13:
omc_13 = [ -2.298212e+00 ; -1.193724e+00 ; 1.159231e-01 ];
Tc_13  = [ -1.325542e+02 ; 7.339338e+01 ; 4.374065e+02 ];
omc_error_13 = [ 5.119265e-03 ; 3.825476e-03 ; 7.527285e-03 ];
Tc_error_13  = [ 2.351008e+00 ; 2.209714e+00 ; 1.923227e+00 ];

%-- Image #14:
omc_14 = [ -2.356896e+00 ; -1.152093e+00 ; -6.803292e-01 ];
Tc_14  = [ -1.402758e+02 ; 7.735030e+01 ; 3.935398e+02 ];
omc_error_14 = [ 4.931122e-03 ; 4.084264e-03 ; 7.575079e-03 ];
Tc_error_14  = [ 2.108098e+00 ; 1.993494e+00 ; 2.084408e+00 ];

%-- Image #15:
omc_15 = [ 2.433468e+00 ; 1.055933e+00 ; -4.312527e-01 ];
Tc_15  = [ -1.281673e+02 ; 6.495537e+01 ; 4.490303e+02 ];
omc_error_15 = [ 5.651839e-03 ; 3.323335e-03 ; 7.949414e-03 ];
Tc_error_15  = [ 2.392404e+00 ; 2.253821e+00 ; 1.963879e+00 ];

%-- Image #16:
omc_16 = [ 2.619670e+00 ; 6.171873e-01 ; 7.329728e-01 ];
Tc_16  = [ -1.306499e+02 ; 9.581236e+01 ; 3.970426e+02 ];
omc_error_16 = [ 5.962244e-03 ; 2.039801e-03 ; 8.492771e-03 ];
Tc_error_16  = [ 2.195860e+00 ; 2.025314e+00 ; 2.292782e+00 ];

%-- Image #17:
omc_17 = [ -2.205160e+00 ; -1.748348e+00 ; -7.606933e-01 ];
Tc_17  = [ -1.520343e+02 ; -2.187613e+00 ; 3.723359e+02 ];
omc_error_17 = [ 4.291755e-03 ; 4.545122e-03 ; 8.271487e-03 ];
Tc_error_17  = [ 1.983169e+00 ; 1.914817e+00 ; 2.075501e+00 ];

%-- Image #18:
omc_18 = [ 2.176529e+00 ; 1.782791e+00 ; -3.483391e-01 ];
Tc_18  = [ -1.496851e+02 ; 8.447621e+00 ; 4.393963e+02 ];
omc_error_18 = [ 5.127448e-03 ; 4.940665e-03 ; 9.655114e-03 ];
Tc_error_18  = [ 2.325376e+00 ; 2.236849e+00 ; 1.971999e+00 ];

%-- Image #19:
omc_19 = [ 1.820638e+00 ; 1.691171e+00 ; 4.754350e-01 ];
Tc_19  = [ -1.694276e+02 ; 1.388627e+01 ; 4.014905e+02 ];
omc_error_19 = [ 4.932818e-03 ; 3.530682e-03 ; 7.838537e-03 ];
Tc_error_19  = [ 2.225608e+00 ; 2.082765e+00 ; 2.183509e+00 ];

%-- Image #20:
omc_20 = [ -2.267060e+00 ; -2.148418e+00 ; -3.454413e-02 ];
Tc_20  = [ -1.623366e+02 ; 7.904711e+00 ; 3.980801e+02 ];
omc_error_20 = [ 5.516907e-03 ; 5.499191e-03 ; 1.110146e-02 ];
Tc_error_20  = [ 2.113667e+00 ; 2.052594e+00 ; 2.084827e+00 ];

