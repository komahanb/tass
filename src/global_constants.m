
% Conversion factors and constants
kts_to_fts      = 1.68781;                  % converts kts to fts
fts_to_mach     = 0.00088863;               % convert ft/s to sea level mach number
kts_to_mach     = kts_to_fts/fts_to_mach;   % convert knots to mach
nm_to_ft        = 6076.12;                  % convert nautical mile to foot

% drag polar
k1              = 0.12;                     % Fig 2.10 Mattingly
k2              = 0;                        % Mattingly
cd0             = 0.018;                    % Fig 2.11 Mattingly