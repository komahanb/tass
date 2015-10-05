%% Weight Breakdown
clear;clc;close all;

w_p             = 432;                      % weight of payload [lbs]
w_c             = 210;                      % weight of crew [lbs]
fuel_frac       = 0.4;                      % estimated fuel_fraction
[w_e, w_to]     = estimate_takeoff_gross_weight(w_p,w_c,fuel_frac);
w_f             = fuel_frac*w_to;

% print a summary of results
fprintf('------------------------------------\n')
fprintf('Weights Breakdown:\n')
fprintf('------------------------------------\n')

fprintf('Payload Weight | %0.0f [lbs]  | %0.3f\n',w_p,fuel_frac)
fprintf('Crew Weight    | %0.0f [lbs]  | %0.3f\n',w_c,fuel_frac)
fprintf('Empty Weight   | %0.0f [lbs]  | %0.3f\n',w_e,fuel_frac)
fprintf('Fuel Weight    | %0.0f [lbs]  | %0.3f\n',w_f,fuel_frac)
fprintf('------------------------------------\n')
fprintf('Gross Weight   | %0.0f [lbs] | %0.3f\n',w_to,fuel_frac)
fprintf('------------------------------------\n')



% Conversion factors and constants
kts_to_fts      = 1.68781;                  % converts kts to fts
fts_to_mach     = 0.00088863;               % convert ft/s to sea level mach number
kts_to_mach     = kts_to_fts/fts_to_mach;   % convert knots to mach
nm_to_ft        = 6076.12;                 % convert nautical mile to foot

%% TAKEOFF CONSTRAINTS
c_l_max_to      = 1.2;                      % Mattingly page 35 (clean wing)
c_l_max_landing = 0.8*c_l_max_to;           % Mattingly page 35
k1              = 0.12;                     % Fig 2.10 Mattingly
k2              = 0;                        % Mattingly
cd0             = 0.018;                    % Fig 2.11 Mattingly 
beta            = 1.0;                      % weight fraction
alpha           = thrust_lapse(M,sigma,'mil');
k_to            = 1.2;                      % safety factor
time_rot        = 3.0;                      % time of rotation [s]
s_to            = 4400;                     % take off distance 
mu_to           = 0.05;

% standard atmosphere
h_to            = 0;                        % runway from sealevel
T_to            = 90;                       % F
T_std           = 59;                       % F
[rho,a,~,~,~,~] = stdatmo(h_to,T_to-T_std,'US');
g0              = 32.17;                    % ft/s

% Mattingly equation for takeoff
A               = (k_to *beta)^2/(rho*g0*c_l_max_to*alpha_wet*t_w);
B               = t_r * k_to*( (2*beta) / (rho*c_l_max) )^0.5;
C               = s_to;

w_s             = ( (-B+(B^2+4*A*C)^0.5) / (2*A) )^2;
%% propulsion
% J47 GE - 33 engine sea level static thrust are below
T_max           = 7650;                     % maximum thrust with afterburners
T_mil           = 5550;                     % maximum thrust without afterburners
T_normal        = 5100;                     % thrust at normal power setting
%%
% for finding alpha
theta           = 1.0796;
delta           = 0.9298;
theta0          = 0;
delta0          = 0;
sigma=delta/theta;
% takeoff per
%standard atmosphere
h_to            = 0;                        % runway from sealevel
T_to            = 90;                       % F
T_std           = 59;                       % F
%[rho,a,temp,press,kvisc,ZorH]              = stdatmo(h_to,32.2-15,'SI');
[rho,a,temp,press,kvisc,ZorH]              = stdatmo(h_to,T_to-T_std,'US');
%[rho,a,temp,press,kvisc,ZorH]              = stdatmo(h_to,0,'US');
T_to = (temp - 491.67)+ 32.00               % convert to F from R
clear temp;
g               = 32.17;                    % ft/s
v_to            = 1200;                     % ft/s
mach_to         = v_to/a;                   
%%
units='US';
[rho,a,T,P,nu]  = stdatmo(100,[],units)
q = 0.5*rho*V^2;
M = v_to/a;
T0 = T*(1+(1.4-1)/2*M^2);
%% CRUISE CLIMB (alpha, beta, rho are treated here as constants)
v_cruise_kts    = 458;                      % cruise velocity [kts]
v_cruise_fts    = v_cruise_kts*kts_to_fts;  % cruise velocity [ft/s]
%m_cruise        = v_cruise_fts*fts_to_mach; % cruise mach number
%altitude changes as it is cruise climb
h1              = 35400;                    % ft
h2              = 38700;                    % ft
%range covered during cc
r_cruise_nm     = 550;                      % nautical miles
r_cruise_ft     = r_cruise_nm*nm_to_ft;

beta=0.8;
alpha=0.33; % funcation of TR

[w_s, t_w] = cruise_climb(h1,h2,v_cruise_fts,r_cruise_ft,k1,k2,cd0,alpha,beta);

plot(w_s,t_w)
%% CONSTANT SPEED TURN
v_cruise_kts    = 458;                      % cruise velocity [kts]
v_cruise_fts    = v_cruise_kts*kts_to_fts;  % cruise velocity [ft/s]
%m_cruise        = v_cruise_fts*fts_to_mach; % cruise mach number
%altitude changes as it is cruise climb
h1              = 35400;                    % ft
beta=0.8;
alpha=0.33; % funcation of TR
n=2;
[w_s, t_w] = constant_speed_turn(h1,v_cruise_fts,n,k1,k2,cd0,alpha,beta);
plot(w_s,t_w)
%% 