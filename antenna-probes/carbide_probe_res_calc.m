% Carbide probe specifications, treat entire probe as one long rod to get
% conservative estimate of cantilever beam resonance (radial resonance)
%clear; clc

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

% http://www.roymech.co.uk/Useful_Tables/Vibrations/Natural_Vibrations.html
p = 14.5*1000; % gm/cm^3 -> kg/m^3

% Pa = kg*m^-1*s^-2
E = 593*1E9; % Gpa -> pa

% Len inches... b/n .65 and 1.03
Lin = [1.03 .74];
L = Lin.*2.54/100; % in->m

% Diameter inches;
Din = 0.07/1;
D = Din*2.54/100;

M = A*L*p./L; % mass kg/m

% Mass moment of inertia of a rod
I = (pi/64)*D^4;

% Frequency in Hertz
f = 3.52./(2*pi*L.^2) .* sqrt(E*I/(p*A));
fprintf('%fkHz\n',f/1000)

% likely somewhere between 1.5kHz and 2kHz