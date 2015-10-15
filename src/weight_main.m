%% Weight Analysis
function [W] = weight_main(w_p, w_c, A, B, v_cruise_kts, R_nm, loiter_time_min,p_res, C_cruise, C_loiter, C_combat, time_combat,method)
% Calculations

fuel_frac       = initial_fuel_fraction(v_cruise_kts,R_nm,loiter_time_min,p_res,C_cruise, C_loiter, C_combat,time_combat);   % estimated fuel_fraction
w_to            = estimate_takeoff_gross_weight(w_p,w_c,fuel_frac, A, B,method);
w_f             = fuel_frac*w_to;
empty_frac      = get_empty_weight_fraction(A, B, w_to,method);
w_e             = empty_frac*w_to;
W               = [w_p  w_e w_c w_f];
%% plot
if (W(1)>0 && W(2) && W(3) >0 && W(4)>0 )
    h=pie(W);
    title('Weight Breakdown');
    hText = findobj(h,'Type','text'); % text object handles
    percentValues = get(hText,'String'); % percent values

    str = {'Payload: ';'Empty: ';'Crew: ';'Fuel: '}; % strings
    combinedstrings = strcat(str,percentValues); % strings and percent values

    oldExtents_cell = get(hText,'Extent'); % cell array
    oldExtents = cell2mat(oldExtents_cell); % numeric array

    hText(1).String = combinedstrings(1);
    hText(2).String = combinedstrings(2);
    hText(3).String = combinedstrings(3);
    hText(4).String = combinedstrings(4);

    newExtents_cell = get(hText,'Extent'); % cell array
    newExtents = cell2mat(newExtents_cell); % numeric array
    width_change = newExtents(:,3)-oldExtents(:,3);
    % 
    signValues = sign(oldExtents(:,1));
    offset = signValues.*(width_change/2);

    textPositions_cell = get(hText,{'Position'}); % cell array
    textPositions = cell2mat(textPositions_cell); % numeric array
    textPositions(:,1) = textPositions(:,1) + offset; % add offset

    hText(1).Position = textPositions(1,:);
    hText(2).Position = textPositions(2,:);
    hText(3).Position = textPositions(3,:);
    hText(4).Position = textPositions(4,:);
end
%% print a summary of results
%fprintf('------------------------------------\n')
%fprintf('Weights Breakdown:\n')
%fprintf('------------------------------------\n')

%fprintf('Payload Weight | %0.0f [lbs]  | %0.3f\n',w_p,fuel_frac)
%fprintf('Crew Weight    | %0.0f [lbs]  | %0.3f\n',w_c,fuel_frac)
%fprintf('Empty Weight   | %0.0f [lbs]  | %0.3f\n',w_e,fuel_frac)
%fprintf('Fuel Weight    | %0.0f [lbs]  | %0.3f\n',w_f,fuel_frac)
%fprintf('------------------------------------\n')
%fprintf('Gross Weight   | %0.0f [lbs] | %0.3f\n',w_to,fuel_frac)
%fprintf('------------------------------------\n')
end