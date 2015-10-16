function [  ] = plot_turn(v_cruise_kts, h1 ,n)

%% CONSTANT SPEED TURN DURING COMBAT

%clear;
global_constants();
% Conversion factors and constants
 kts_to_fts      = 1.68781;                  % converts kts to fts
 fts_to_mach     = 0.00088863;               % convert ft/s to sea level mach number
 kts_to_mach     = kts_to_fts/fts_to_mach;   % convert knots to mach
 nm_to_ft        = 6076.12;                  % convert nautical mile to foot\
 

% v_cruise_kts    = 536;                      % cruise velocity [kts] during combat
v_cruise_fts    = v_cruise_kts*kts_to_fts;  % cruise velocity [ft/s] during combat

%altitude at which turn is done (during combat)
% h1              = 47550;                    % ft

beta            = 0.75;
alpha           = thrust_lapse(v_cruise_fts,h1,0,'max');

% n               = 2;                        % load factor

[w_s, t_w] = constant_speed_turn(h1,v_cruise_fts,n,k1,k2,cd0,alpha,beta);

%plot(w_s,t_w)
draw_constraint(w_s,t_w);

end