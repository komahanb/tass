%% TAKEOFF
h_to            = 0;                        % runway at sealevel (given)
T_to            = 90;                       % F (given)
T_std           = 59;                       % F (given)
g0              = 32.17;                    % ft/s (known)
[rho,a,~,~,~,~] = stdatmo(h_to,T_to-T_std,'US');

% lift-drag polar
c_l_max_landing = 2.0;                     % Mattingly page 35  1.6 with leading edge slat
c_l_max_to      = 0.8*c_l_max_landing;     % Mattingly page 30

c_l_to          = 0.8*c_l_max_to;           % Mattingly page 35
c_l_landing     = 0.8*c_l_max_landing;      % Mattingly page 35

beta            = 1.0;                      % not much fuel is burnt
alpha           = 1.0;                      % sea level and ignoring the effect of mach number

time_rot        = 3.0;                      % time of rotation [s] (assumed)
s_to            = 4400;                     % take off distance (given)
k_to            = 1.2;                      % safety factor mattingly
mu_to           = 0.05;                     % friction coefficient Mattingly (Assumed)
h_obs           = 50;                       % height of obstacle ft (given)
dh_dt           = 90;                       % rate of climb max (given)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (1) take off ground roll T_SL >> D+R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%w_s             = wing_loading();

w_s  =75.0;

v_stall         = (2*beta*w_s./(rho*c_l_max_to)).^0.5;   % Mattingly page 29
v_to            = k_to*v_stall;                          % Mattingly page 28 (v_Stall is the min speed at which the plane can fly. We need to ensure that we have enough velocity to account for uncertainties)
q               = 0.5*rho*v_to.^2;                       % dynamic pressure at take-off velocity

%s_g             = beta*v_to.^2./(alpha.*t_w*2*g0);         % Mattingly page 28

s_r             = time_rot*v_to; % distance during rotation E 2.26 Mattingly

theta_cl        = asin(dh_dt/v_to);
s_tr            = k_to*k_to*sin(theta_cl)*2*beta*w_s/(g0*(0.8*k_to*k_to -1) *rho*c_l_max_to);

h_tr            = k_to*k_to*(1-cos(theta_cl))*2*beta*w_s/(g0*(0.8*k_to*k_to -1) *rho*c_l_max_to);
s_cl            = (h_obs - h_tr)/tan(theta_cl)

if (h_obs-h_tr) > 0
    s_g             = s_to -(s_r + s_tr + s_cl);
else
    s_g            = s_to -(s_r + s_tr + s_cl)
end

t_w             = beta*v_to.^2./(alpha.*s_g*2*g0);         % Mattingly page 28

%iteratively find t_w ratio for a given wing_loading
s_to            = s_g + s_r + s_tr + s_cl;
%where

%t_w             = beta^2 * k_to^2*w_s  ./(alpha*s_g*rho*g0*c_l_max_to) % Mattingly E 2.22
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (1) take off ground roll T_SL  D+R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q               = 0.05*rho*v_to^2;                      % dynamic pressure at take-off velocity
c_d             = cd0 + k1.*(w_s./q)^2;
zeta_to         = c_d + c_dr -mu_to*c_l;