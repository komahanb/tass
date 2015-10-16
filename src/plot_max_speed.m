function [  ] = plot_max_speed(v_fts,h,dT,power_setting)
%% CLIMB

global_constants();

%h               = 0;
dh_dt           = 0;
%dT              = 31;
%power_setting   = 'max';
%v_fts           = 1200;                     % cruise velocity [ft/s]
k2              = 0;
[k1, cd0]       = drag_polar(h,dT,v_fts);

beta            = 1.0;
[~,~,temp]      =  initial_fuel_fraction();
%beta = temp(7) % first climb before cruise
alpha           = thrust_lapse(v_fts,h,dT,power_setting)

[w_s, t_w]      = cruise(h,v_fts,dh_dt, alpha,beta,k1,k2,cd0);

draw_constraint(w_s,t_w);

%plt = plot(w_s,t_w);
end