function [ w_s, t_w ] = cruise_climb(h1, h2, v_cruise_fts, r_cruise_ft, k1, k2, c_d0, alpha, beta)
%cruise_climb Computes Mattingly Energy Equation for Cruise Climb phase
%
%  Input  :
%   beta  - weight fraction 
%   alpha - thrust lapse
%   k1, k2, c_d0 - drag terms
%   h1, h2 - heights during beginning and end of cruise climb [ft]
%   v_cruise_kts - cruise velocity in ft/s
%   range_cruise_ft - range covered during cruise climb [ft]
%
%  Output :
%   array of thrust loading
%   array of wing loading

t_cruise_s      = r_cruise_ft/v_cruise_fts;
dh              = h2-h1;
dh_dt           = dh/t_cruise_s;

[rho1,~,~,~,~,~]              = stdatmo(h1,0,'US');
[rho2,~,~,~,~,~]              = stdatmo(h2,0,'US');
%drho_dh = (rho_2 -rho_1)/dh;
%rho = rho1 + drho_dh*h;
rho=0.5*(rho1+rho2);

%T = RtoF(temp);
q               = 0.5*rho*v_cruise_fts^2;

c1              = q/beta;
c2              = beta/alpha;
c3              = dh_dt/v_cruise_fts;

w_s             = wing_loading(); % generate range of wing loadings
%t_w             = c2.*((c1./w_s).*(k1.*(c1.*w_s).^2 + k2.*c1.*w_s + c_d0 )) + dh./(t_cruise_s.*v_cruise_fts);
t_w = c2.*( (k1*w_s)/c1 + k2 + (c_d0*c1)./w_s  + c3);
end

