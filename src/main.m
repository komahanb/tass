clear all;clc;close all;

global k1 k2 cd0
global kts_to_fts fts_to_mach kts_to_mach nm_to_ft

global_constants();

%% 
close all;
fig=figure

grid on;
grid minor;
box on;
hold on;

plot_climb();
plot_turn();
%plot_takeoff();
%plot_landing();

hold off;
title('\textbf{Costraint Analysis}','Interpreter','latex','fontsize',14);
xlabel('$\textrm{Wing Loading}~\frac{W_{TO}}{S}~[\frac{lb}{ft^2}]$','Interpreter','latex','fontsize',14);
ylabel('$\textrm{Thrust Loading}~\frac{T_{SL}}{W_{TO}}$','Interpreter','latex','fontsize',14);
legend('Cruise Climb','Turn');
%%