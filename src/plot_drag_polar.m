function [] = plot_drag_polar()
%%
cla
v_fts =100;
dT = 31;
h = 0;

[k1, cd0] = drag_polar(h,dT,v_fts);

cl = linspace(0,2,200);

cd = cd0 + k1.*cl.^2;

plot(cd,cl,'linewidth',2);

title('\textbf{Drag Polar}','interpreter','latex');
ylabel('C_L','linewidth',14, 'fontweight','bold');
xlabel('C_D','linewidth',14, 'fontweight','bold');

hold on;

v_fts=1200;
dT = 0;
h = 0;

[k1, cd0] = drag_polar(h,dT,v_fts);

cl = linspace(0,2,200);

cd = cd0 + k1.*cl.^2;

plot(cd,cl,'linewidth',2);

title('\textbf{Drag Polar}','interpreter','latex');
ylabel('C_L','linewidth',14, 'fontweight','bold');
xlabel('C_D','linewidth',14, 'fontweight','bold');
legend('V=100 ft/s', 'V=1200 ft/s','Location','NorthWest');
hold off
end