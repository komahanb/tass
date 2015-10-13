function [ sigma ] = get_sigma(h,dT)
% Thrust lapse rate
% Input:
% h             - height
% dT            - Temperature diff from standard temp of 15C (hold, cold day)
% standard atmosphere
[rho_std,a_std,T_std,P_std,~,~] = stdatmo(0,0,'US');
[rho,a,T,P,~,~]     = stdatmo(h,dT,'US');

%delta = P/P_std;
%theta=T/T_std;
%sigma1 = delta/theta;

sigma               = rho/rho_std;

end