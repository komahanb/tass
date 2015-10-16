function [] = axes_and_label()
axis([0 100 0 2.0]);
%box on;
%title('\textbf{Constraint Analysis}','Interpreter','latex','fontsize',14);
xlabel('$\textrm{Wing Loading}~\frac{W_{TO}}{S}~[\frac{lb}{ft^2}]$','Interpreter','latex','fontsize',14);
ylabel('$\textrm{Thrust Loading}~\frac{T_{SL}}{W_{TO}}$','Interpreter','latex','fontsize',14);

end