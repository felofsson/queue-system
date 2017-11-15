function x = dummy_function(mat_file_path)
% Simple dummy function to show the usage of fp.m
% This function loads parameters from mat_file_path
% and compute a result based on a parameter specificed in 
% the meta.opt
%
% N. B. This function should be replaced with your 
% time-consuming function. To mimic the behaviour of 
% a more realistic function, a pause is utilized to 
% fake that a more complex computation is taking place.


load(mat_file_path, 'meta');
opt = meta.opt;

% Retrieve parameters
xRange = opt.xRange;
my_param = opt.my_param;

%Compute the result
x = 1 - exp(-my_param * xRange);

pause(15)

end