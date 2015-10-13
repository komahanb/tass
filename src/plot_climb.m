%function [  ] = plot_climb()
%% CLIMB
clear;
global_constants();

v_cruise_kts    = 458;                      % cruise velocity [kts]
v_cruise_fts    = v_cruise_kts*kts_to_fts;  % cruise velocity [ft/s]

%altitude changes as it is cruise climb
h               = 35400;                    % ft
dh_dt           = 90;                       % ft/s
dT              = 0;

beta            = 0.98;                     % assumed
alpha           = thrust_lapse(v_cruise_fts,h,0,'mil');

[k1, cd0]       = drag_polar(h,dT,v_cruise_fts);
k2              = 0 ;

[w_s, t_w]      = climb(h,v_cruise_fts,dh_dt,alpha,beta,k1,k2,cd0);

draw_constraint(w_s,t_w);

%plot(w_s,t_w,'linewidth',2);
%end