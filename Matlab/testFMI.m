% download and extract the distribution archive to the current folder
unzip(['https://github.com/CATIA-Systems/FMIKit-Simulink/releases/' ...
  'download/v3.1/FMIKit-Simulink-3.1.zip'], 'FMIKit-Simulink-3.1')

% add the folder to the MATLAB path
addpath(fullfile(pwd, 'FMIKit-Simulink-3.1'))

% initialize FMI Kit
FMIKit.initialize()

% open the Bouncing Ball demo
fmikit_demo_BouncingBall

% open the documentation
web('FMIKit-Simulink-3.1/html/index.html')

%%

simOut = sim('fmikit_demo_BouncingBall', 'SimulationMode', 'normal', 'StopTime', '10');

plot(simOut.logsout.getElement('height').Values.Time, simOut.logsout.getElement('height').Values.Data)

%% 

set_param('fmikit_demo_BouncingBall/FMU', 'h', '0.9')
set_param('fmikit_demo_BouncingBall/Constant', 'Value', '2')
plot(tout, yout)