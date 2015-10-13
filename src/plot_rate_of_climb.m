%% CLIMB
h               = 0;
dh_dt           = 90;
dT              = 0;
power_setting   = 'max';
v_fts           = 458*kts_to_fts;                     % cruise velocity [ft/s]
k2              = 0;
[k1, cd0]       = drag_polar(h,dT,v_fts);

beta            = 0.99;                     % assumed
alpha           = thrust_lapse(v_fts,h,dT,power_setting);

[w_s, t_w]      = cruise(h,v_fts,dh_dt, alpha,beta,k1,k2,cd0);

%plt = plot(w_s,t_w);
draw_constraint(w_s,t_w);