function [ we_wt ] = get_empty_weight_fraction( w_t )
% get_empty_weight_fraction(w_t) 
% Returns the ratio of empty weight to the take-off weight based on the type of aircraft
% Formula: we_wt = 2.34*w_t^(-0.13) % fighter aircraft
we_wt = 1.02*w_t^(-0.13); % fighter aircraft
end
