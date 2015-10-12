
beta            =  1.0;                      % weight fraction
M               = 0.2;
sigma           = 0.5;
alpha_wet       = thrust_lapse(M,sigma,'max');
%cl_max?





%ground roll phase
s_g             = ;
%rotation phase

%transition phase


c_d             = cd0 + k1.*(w_s./(0.5*rho*v_to^2))^2;
zeta_to         = c_d + c_dr -mu_to*c_l;

% Mattingly equation for takeoff
t_w             = thrust_loading();
%A               = (k_to .*beta).^2./(rho.*g0.*c_l_max_to.*alpha_wet.*t_w);
denom           = (alpha*t_w/beta -mu_to)*c_l_max_to/k_to^2;
A               =-(beta/rho*g0*zeta_to)*log( 1- zeta_to/denom)

B               = time_rot * k_to*( (2*beta) / (rho*c_l_max_to) )^0.5;
C               = s_to;
w_s             = ( (-B+(B.^2+4.*A.*C).^0.5) ./ (2.*A) ).^2;
plot(w_s,t_w)
%% Landing performance
k_td            = 1.15;
beta            = 1.0;                      % weight fraction
s_l             = 5000;
% standard atmosphere
h_to            = 0;                        % runway from sealevel
T_to            = 90;                       % F
T_std           = 59;                       % F
[rho,a,~,~,~,~] = stdatmo(h_to,T_to-T_std,'US');
g0              = 32.17;                    % ft/s

% Mattingly equation for takeoff
t_w             = thrust_loading();
denom           = (-alpha*t_w/beta +mu_td)*c_l_max_td/k_td^2;
A               = (beta/rho*g0*zeta_l)*log( 1+  zeta_l/denom)
B               = time_fr * k_td*( (2*beta) / (rho*c_l_max_td) )^0.5;
C               = s_l;
w_s             = ( (-B+(B.^2+4.*A.*C).^0.5) ./ (2.*A) ).^2;

%% propulsion
% J47 GE - 33 engine sea level static thrust are below
T_max           = 7650;                     % maximum thrust with afterburners
T_mil           = 5550;                     % maximum thrust without afterburners
T_normal        = 5100;                     % thrust at normal power setting

% TSFC
C_mil_1         = 1.45/3600; % s-1
C_mil_2         = 1.45/3600; % s-1
C_max           = 2/3600; %s-1
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