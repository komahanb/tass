function [ w_s, t_w ] = climb(h_cruise, v_cruise_fts, dh_dt, alpha, beta,k1,k2,cd0)
%cruise_climb Computes Mattingly Energy Equation for Cruise Climb phase
%
%  Input  :
%   beta  - weight fraction 
%   alpha - thrust lapse
%   k1, k2, c_d0 - drag terms
%   h1, h2 - heights during beginning and end of cruise climb [ft]
%   v_cruise_kts - cruise velocity in ft/s
%   dh/dt - rate of climb [ft/s]
%
%  Output :
%   array of thrust loading
%   array of wing loading

[rho,~,~,~,~,~]              = stdatmo(h_cruise,0,'US');

q               = 0.5*rho*v_cruise_fts^2;

c1              = q/beta;
c2              = beta/alpha;
c3              = dh_dt/v_cruise_fts;

w_s             = wing_loading(); % generate range of wing loadings
%t_w             = c2.*((c1./w_s).*(k1.*(c1.*w_s).^2 + k2.*c1.*w_s + c_d0 )) + dh./(t_cruise_s.*v_cruise_fts);
t_w = c2.*( (k1*w_s)/c1 + k2 + (cd0*c1)./w_s  + c3);
end

