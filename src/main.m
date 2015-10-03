%%
clear;clc;close all;
w_p = 432;              % weight of payload
w_c = 210;              % weight of crew
fuel_frac = 0.4;        % estimated fuel_fraction
w_to = estimate_takeoff_gross_weight(w_p,w_c,fuel_frac);
fprintf('Gross takeoff weight estimation: %0.0f [lbs]\n',w_to);
%%