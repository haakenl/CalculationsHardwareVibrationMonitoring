clear all
close all
clc

%battery_capacity = 500e-3;                     % Battery capacity [AH]
Minimum_battery_lifetime = 2;                 % Battery lifetime [År]
Consum_mux = 0e-6                           % Battery drain [A]

Consum_ATTINY816_am = 2.8e-3;                   %   Consumption ATTINY816 active mode [A]
Consum_ATTINY816_sm = 1.2e-6 + 0.71e-6;         % Consumption ATTINY816 sleep mode [A]


Runtime_ATTINY816_sm = Minimum_battery_lifetime*365*24; % Run time when sleep mode

Runtim_ATTINY816_to = 1/3600 * 20e-6;                   % Run time when timer overflow [s]
N_ATTINY816_to = (2*365*24*60*60)/(2^16/1.024e3)        % Estimate on timeroverflows

Runtim_ATTINY816_ii = 1/3600 *100e-3;           % Run time when impact interrupt [s]
N_ATTINY816_ii = 50;                            % Estimate on impact interrupts

Consum_ADXL372_mm = 22e-6;                      % Consumption ADXL317 measurement mode [A]
Consum_ADXL372_iom = 1.4e-6;                    % Consumption ADXL317 instant on mode [A]
Runtim_ADXL372_i = 110e-3;                      % Run time when impact [s]


energy_sm = (Consum_ATTINY816_sm + Consum_ADXL372_iom + Consum_mux) * Runtime_ATTINY816_sm   %Consumption sleep mode [AH]

energy_to = N_ATTINY816_to * (Consum_ATTINY816_am * Runtim_ATTINY816_to)        %Consumption timer overflow [AH]  

energy_ii = N_ATTINY816_ii * ((Consum_ATTINY816_am * Runtim_ATTINY816_ii) + (Consum_ADXL372_mm * Runtim_ADXL372_i)) %Consumption impact interrupt [AH]

tot_energy_requirement = (energy_sm + energy_to + energy_ii) *10^3        % Total consumption [mAH] 


tot_energy_requierment_dcdc = tot_energy_requirement*1.10        % dc/dc with 90% efficiency