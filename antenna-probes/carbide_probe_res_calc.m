% Carbide probe specifications, treat entire probe as one long rod to get
% conservative estimate of cantilevered beam resonance (radial resonance)

% From email:
% Tungsten Carbide Material Properties
% Properties                    Units            Test            Grade C10 (10% Cobalt Binder)
% Density                       gm/cm3           ASTM-C20        14.5
% Hardness                      HRA              ASTM-E18        92.0
% Grain Size (Average)          ?                ?               SUBMICRON
% Color                         ?                ?               GRAY
% Transverse Rupture Strength   MPa (psi x 103)  ASTM-B406       3585 (520)
% Compressive Strength          MPa (psi x 103)  ASTM-C773       4171 (605)
% Elastic Modulus 20 °C         Gpa (psi x 106)  ASTM-C848       593 (86)
% Poisson's Ratio 20° C         ?                ASTM-C848       0.22
% Thermal Conductivity 20 °C    W/m °K           ASTM-C408       85

% Double check source:
% http://www.roymech.co.uk/Useful_Tables/Vibrations/Natural_Vibrations.html

% Density
p = 14.5*1000; % gm/cm^3 -> kg/m^3

% Pa = kg*m^-1*s^-2
E = 593*1E9; % Gpa -> pa

% Length in inches
% Lin = [1.03 .731]; % Rev 1, Design 1
% Lin = [.933 .650]; % Rev 2, Design 1
% Design 2 has additonal ~1-2mm of insulating washer w/nylon threaded bridging adapter
Lin = [.990 .692] + 0.07 ; % Rev 1, Design 2
L = Lin.*2.54/100; % in->m

% Diameter inches
% Din = 0.07; % Rev 1
% Din = 0.05/1; % Rev 2
Din = 0.05; % Rev 1, D2
D = Din*2.54/100;

% Area meters^2
A = pi*(D/2)^2;

% Mass per length, kg/m
M = A*L*p./L; 

% Mass moment of inertia of a rod (at end)
I = (pi/64)*D^4;

% Frequency in Hertz
f = 3.52./(2*pi*L.^2) .* sqrt(E*I/(p*A));
fprintf('Probe radial resonant frequency range:\n')
fprintf('%fkHz\n',f/1000)

% likely somewhere above 2.3kHz for Rev 1, 2kHz for Rev 2
% photodiode or inferometer to check in lab

%% Resonance of the Piezo
% PI P-840.6 90um travel piezo
% only want to use ~1/3 the resonant frequency in stimulation

% nominal unloaded resonance * tolerance
f0 = 6000*0.8;

% unloaded mass estimate (very conservative)
m0 = 28; % grams

% measured Rev 1 probe mass
m1 = 2.4; % grams

f1 = f0*sqrt(m0/(m0+m1));
fprintf('Piezo axial resonant frequency with load:\n%fkHz\n',f1/1000)

% the radial resonant frequency will be high due to the wide stacks