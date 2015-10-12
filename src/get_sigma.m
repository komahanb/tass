function [ sigma ] = get_sigma(h,dT)
% Thrust lapse rate
% Input:
% h             - height
% dT            - Temperature diff from standard temp of 15C (hold, cold day)
% standard atmosphere
[rho_std,~,~,~,~,~] = stdatmo(0,0,'US');
[rho,~,~,~,~,~]     = stdatmo(h,dT,'US');
sigma               = rho/rho_std;
end