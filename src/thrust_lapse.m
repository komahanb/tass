function [ alpha ] = thrust_lapse(V,h,dT,type)
%thrust_lapse Find the thrust lapse
% Input:
% M             - Mach number
% sigma         
% type          - mil/max or dry/wet

%Turbojet with afterburning

[~,a,~,~,~,~] = stdatmo(h,dT,'US');
M = V/a;
sigma = get_sigma(h,dT);
if (strcmp(type,'military'))
    alpha=0.76*(0.907+0.262*abs(M-0.5)^1.5)*sigma^0.7;
else
    alpha=(0.952+0.3*(M-0.4)^2)*sigma^0.7;
end

end
