function [w_t ] = estimate_takeoff_gross_weight( w_p, w_c, f_fuel, A, B )
%% estimate_takeoff_gross_weight estimates the takeoff gross weight
%
%  Performs iterations to estimate the takeoff gross weight
%  w_{to} = \frac{w_c+w_p} {1 - \frac{w_f}{w_to} -\frac{w_e}{w_to} }
%
%  Currently implementation for:
%       (1) fighters only
%       (2) mission profile must be the same

% Estimation of gross weight
%guess  =   w_p + w_c+13000;
%disp('sdhfaslkjfhlsakjh')
%clc;
cnt= 0;
guess  = 2*(w_p +w_c);
actual  =  guess /(1-f_fuel - get_empty_weight_fraction(A, B, guess));
while (abs(guess-actual)) > 1 && cnt<=500
        %cnt,guess, actual,get_empty_weight_fraction(A, B, guess)
    guess  =   actual;
    actual  = (w_p + w_c )/(1-f_fuel - get_empty_weight_fraction(A, B, guess));
    %actual  =  guess /(1-f_fuel - get_empty_weight_fraction(guess));
    cnt = cnt + 1 ;
    %error('sdfsd')
end
w_t = actual;
end

