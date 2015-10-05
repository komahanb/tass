function [ w_s, t_w ] = constant_speed_turn(h, v_turn, n, k1, k2, c_d0, alpha, beta)
%cruise_climb Computes Mattingly Energy Equation for Cruise Climb phase
%
%  Input  :
%   beta         - weight fraction 
%   alpha        - thrust lapse
%   k1, k2, c_d0 - drag terms
%   h            - height at which turn is done [ft]
%   n            - load factor
%   v_turn_fts   - cruise velocity in ft/s
%
%  Output :
%   array of thrust loading
%   array of wing loading

[rho,~,~,~,~,~]              = stdatmo(h,0,'US');
q               = 0.5*rho*v_turn^2

c1              = q/beta;
c2              = beta/alpha;

w_s             = wing_loading(); % generate range of wing loadings
%t_w             = c2.*((c1./w_s).*(k1.*(c1.*w_s).^2 + k2.*c1.*w_s + c_d0 )) + dh./(t_cruise_s.*v_cruise_fts);
t_w = c2.*( (k1*w_s*n*n)/c1 + k2*n + (c_d0*c1)./w_s);
end

