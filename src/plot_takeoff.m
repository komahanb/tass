function [  ] = plot_takeoff(h_to, dT,s_to,  h_obs, c_l_max_to)
%% TAKEOFF

global_constants();

% h_to            = 0;                        % runway at sealevel (given)
T_to            = 90;                       % F (given)
T_std           = 59;                       % F (given)
g0              = 32.17;                    % ft/s (known)

[rho,a,~,~,~,~] = stdatmo(h_to,dT,'US');

%s_to            = 4400;                     % take off distance (given)
k_to            = 1.2;                      % safety factor mattingly
mu_to           = 0.05;                     % friction coefficient Mattingly (Assumed)
%h_obs           = 50;                       % height of obstacle ft (given)
dh_dt           = 90;                       % rate of climb max (given)

v_to            = 0.1*a*k_to;

% lift-drag polar
%c_l_max_landing = 1.0;                     % Mattingly page 35  1.6 with leading edge slat
%c_l_max_to      = 0.8*c_l_max_landing;     % Mattingly page 30

%c_l_to          = 0.8*c_l_max_to;           % Mattingly page 35
%c_l_landing     = 0.8*c_l_max_landing;      % Mattingly page 35

beta            = 1.0;                      % not much fuel is burnt
alpha           = thrust_lapse(v_to,h_to,T_to-T_std,'max');

time_rot        = 3.0;                      % time of rotation [s] (assumed)

%s_obs = v_to^2*sin(dh_dt/v_to)/(g0*(0.8*k_to*k_to -1))

t_obs = h_obs/dh_dt;
the_c = asin(dh_dt/v_to);
s_obs  = v_to*cos(the_c)*t_obs;

s_to = s_to - s_obs ;

% Mattingly equation for takeoff
t_w             = thrust_loading();

%c_dr=0;
%c_l=0;
%c_d             = cd0 + k1.*(1./(0.5*rho*(0.1*a)^2))^2;
%zeta_to         = c_d + c_dr -mu_to*c_l;
%denom           = (alpha*t_w/beta -mu_to)*c_l_max_to/k_to^2;
%A               =-(beta./rho.*g0.*zeta_to).*log( 1- zeta_to./denom)

A               = (k_to .*beta).^2./(rho.*g0.*c_l_max_to.*alpha*t_w);
B               = time_rot * k_to*( (2*beta) / (rho*c_l_max_to) )^0.5;
C               = s_to;

w_s             = ( (-B+(B.^2+4.*A.*C).^0.5) ./ (2.*A) ).^2;
draw_constraint(w_s,t_w);
%plot(w_s,t_w)
%% Mattingly equation for takeoff
%t_w             = thrust_loading();
%A               = (k_to .*beta).^2./(rho.*g0.*c_l_max_to.*alpha_wet.*t_w);
%denom           = (alpha*t_w/beta -mu_to)*c_l_max_to/k_to^2;
%A               =-(beta/rho*g0*zeta_to)*log( 1- zeta_to/denom)
%B               = time_rot * k_to*( (2*beta) / (rho*c_l_max_to) )^0.5;
%C               = s_to;
%w_s             = ( (-B+(B.^2+4.*A.*C).^0.5) ./ (2.*A) ).^2;
%plot(w_s,t_w)
end