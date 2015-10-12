function [ w_e , w_t ] = estimate_takeoff_gross_weight( w_p, w_c, fuel_frac )
%% estimate_takeoff_gross_weight estimates the takeoff gross weight
%
%  Performs iterations to estimate the takeoff gross weight
%  w_{to} = \frac{w_c+w_p} {1 - \frac{w_f}{w_to} -\frac{w_e}{w_to} }
%
%  Currently implementation for:
%       (1) fighters only
%       (2) mission profile must be the same

% Estimation of gross weight
temp = w_p + w_c + 100; % Initial guess for gross weight
w_t  = (w_p+w_c)/(1 - fuel_frac - get_empty_weight_fraction(temp)); 
temp = 1; 
while abs(temp-w_t)>1 && temp<500
    temp = w_t;
    w_t  = (w_p+w_c)/(1 - fuel_frac - get_empty_weight_fraction(temp) );
    temp = temp+50; % add 50 lb each iteration
end
w_e = get_empty_weight_fraction(temp)*w_t;
if temp == 500
    error('Weight estimate did not converge')
end
end

