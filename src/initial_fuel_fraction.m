function [fuel_frac,wni_wn, beta] = initial_fuel_fraction(v_cruise_kts, R_nm, loiter_time_min,p_res, C_cruise, C_loiter, C_combat, time_combat)

switch nargin
    case 8

    otherwise
        %disp('Using default values for beta estimation')
        v_cruise_kts = 458;
        R_nm         = 550;
        loiter_time_min  = 10;
        p_res        = 10;
        C_cruise     = 1.2;
        C_loiter     = 0.6;
        C_combat     = 2.0;
        time_combat = 10;
end

nm_to_ft   = 6.0761e+03;
kts_to_fts = 1.6878;
v_cruise_fts = v_cruise_kts*kts_to_fts;
R = R_nm*nm_to_ft;
loiter_time = loiter_time_min*60;
% loiter_time
wni_wn=[1:1:12];
wni_wn(1) = 1.0;
%% 0-1 Warmup and Takeoff
ff_to    =  0.9703; % Raymer Table 2.1
%% 1-2 Climb
wni_wn(2) = ff_to;
ff_climb1 = 0.985;    
%% 2-3 Cruise
wni_wn(3) = ff_climb1;
C_cruise = C_cruise/3600; %;1.45/3600;
L_D_max_est = 7;
%R  = 550*nm_to_ft;
%v_cruise_fts = 458*kts_to_fts;
ff_cruise1= exp(-(R*C_cruise)/(L_D_max_est*v_cruise_fts));
%% 3-4  loiter
wni_wn(4) = ff_cruise1;
%loiter_time    = 10*60; %[s] 10 min loiter reserve fuel
L_D_loiter_est = 9; % Table 2.2 Raymer
C_loiter = C_loiter/3600; % Table 2.2 Raymer
ff_loiter1 =exp(-(loiter_time)*C_loiter/(L_D_loiter_est));
%% 4-5 Climb to combat altitude
wni_wn(5) = ff_loiter1;
ff_climb2 = 0.985;
%% 5-6 Combat: 5min 536 kts max power
wni_wn(6) = ff_climb2;
time_combat    = time_combat*60; %[s] 10 min loiter reserve fuel
L_D_combat_est = 5; % Table 2.2 Raymer
C_combat = C_combat/3600; % Engine at max power
ff_combat =exp(-(time_combat)*C_combat/(L_D_combat_est));
%% 2, 3 ,4 ,5 are repeated
wni_wn(7) = ff_combat;


ff_descent1=1.0;       % no fuel burnt 6-7
wni_wn(8) = ff_descent1;


%ff_cruise2=ff_cruise1; % 7-8
C_cruise_back=1.2/3600;%normal power
ff_cruise2= exp(-(R*C_cruise_back)/(L_D_max_est*v_cruise_fts));
wni_wn(9) = ff_cruise2;


ff_descent2=1.0;       % 8-9 no fuel burnt

ff_loiter2=ff_loiter1; % 9 -10
wni_wn(10) = ff_loiter1;
%%
wni_wn(11) = ff_descent2;
%% 10 - 11 Landing and shutoff
ff_landing = 0.995;
wni_wn(12) = ff_landing;
%% Put together the legs
fuel_frac= ff_to*ff_climb1*ff_cruise1*ff_loiter1*ff_climb2*ff_combat*ff_descent1...
    *ff_cruise2*ff_descent2*ff_loiter2*ff_landing;
beta = [1:1:12];
for i = 1:length(wni_wn)
    beta(i) = prod(wni_wn(1:i));
end
fuel_frac=(1+p_res/100)*1.06*(1-fuel_frac); % 10 percent reserve fuel RFP , 6% trapped
end