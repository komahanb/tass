%% Weight Breakdown
clear;clc;close all;

w_p             = 432;                      % weight of payload [lbs]
w_c             = 210;                      % weight of crew [lbs]
fuel_frac       = 0.4;                      % estimated fuel_fraction
[w_e, w_to]     = estimate_takeoff_gross_weight(w_p,w_c,fuel_frac);
w_f             = fuel_frac*w_to;

% print a summary of results
fprintf('------------------------------------\n')
fprintf('Weights Breakdown:\n')
fprintf('------------------------------------\n')

fprintf('Payload Weight | %0.0f [lbs]  | %0.3f\n',w_p,fuel_frac)
fprintf('Crew Weight    | %0.0f [lbs]  | %0.3f\n',w_c,fuel_frac)
fprintf('Empty Weight   | %0.0f [lbs]  | %0.3f\n',w_e,fuel_frac)
fprintf('Fuel Weight    | %0.0f [lbs]  | %0.3f\n',w_f,fuel_frac)
fprintf('------------------------------------\n')
fprintf('Gross Weight   | %0.0f [lbs] | %0.3f\n',w_to,fuel_frac)
fprintf('------------------------------------\n')
