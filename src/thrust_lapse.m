function [ alpha ] = thrust_lapse(V,h,dT,type)
%thrust_lapse Find the thrust lapse
% Input:
% M             - Mach number
% sigma         
% type          - mil/max or dry/wet

%Turbojet with afterburning

[~,a,~,~,~,~] = stdatmo(h,dT,'US');
M = V/a;

if (strcmp(type,'mil'))
    alpha=(0.907+0.262*abs(M-0.5)^1.5)*0.76*get_sigma(h,dT)^0.7;
else
    alpha=(0.952+0.3*(M-0.4)^2)*get_sigma(h,dT)^0.7;
end
end
