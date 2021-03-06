function [ we_wt ] = get_empty_weight_fraction(A, B , w_t , method)
% get_empty_weight_fraction(w_t) 
% Returns the ratio of empty weight to the take-off weight based on the type of aircraft
% Formula: we_wt = 2.34*w_t^(-0.13) % fighter aircraft
 %we_wt = 2.36*w_t^(-0.18); % 
 if (strcmp('raymer',method))
     %disp('raymer');
    we_wt = 2.34*w_t^(-0.13); % fighter aircraft Eq. 3.52 Mattingly notw
 else
     %disp('roskam');
    we_wt = ((invlog10((log10(w_t) - A )/B))/w_t); % Roskam EQ. 2.16
 end
end

