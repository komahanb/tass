clear all;clc;close all;

global k1 k2 cd0
global kts_to_fts fts_to_mach kts_to_mach nm_to_ft

global_constants();
%% 
grid on;
grid minor;
box on;
hold on;
%%
plot_climb();
plot_cruise_climb();
plot_turn();
plot_takeoff();
plot_landing();
plot_max_speed();
plot_service_ceiling();
%plot_rate_of_climb();

axis([0 100 0 2.0]);

hold off;
title('\textbf{Costraint Analysis}','Interpreter','latex','fontsize',14);
xlabel('$\textrm{Wing Loading}~\frac{W_{TO}}{S}~[\frac{lb}{ft^2}]$','Interpreter','latex','fontsize',14);
ylabel('$\textrm{Thrust Loading}~\frac{T_{SL}}{W_{TO}}$','Interpreter','latex','fontsize',14);
legend('Rate of Climb', 'Cruise Climb','Turn','Takeoff', 'Landing','Max Speed', 'Service Ceiling');

%% propulsion
% J47 GE - 33 engine sea level static thrust are below
T_max           = 7650;                     % maximum thrust with afterburners
T_mil           = 5550;                     % maximum thrust without afterburners
T_normal        = 5100;                     % thrust at normal power setting

% TSFC
C_mil_1         = 1.45/3600; % s-1 
C_mil_2         = 1.45/3600; % s-1
C_max           = 2/3600; %s-1

C_loiter        = 0.6/3600; %s-1 Table 2.2 Raymer         