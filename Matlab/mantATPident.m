addpath('c:\Program Files\Dymola 2025x\Mfiles\'); % Adjust path based on your installation
addpath('c:\Program Files\Dymola 2025x\Mfiles\dymtools'); % Adjust path based on your installation
addpath('c:\Program Files\Dymola 2025x\Mfiles\traj'); % Adjust path based on your installation

%% prep
dymola(['cd ' strrep(pwd, '\', '/')])
dymola('translateModel("CrossBridgeCycling.mantATP.LabelLib.XBCycling")');
%%
dymola('tune_a = 2');
dymola('simulateModel("CrossBridgeCycling.mantATP.LabelLib.XBCycling",startTime=-1200,stopTime=600, numberOfIntervals=5000,resultFile="XBCycling")')

dym = dymload('XBCycling.mat');
y = dymget(dym, 'integratedSquaredDeviation.y');
x = [1 1 1];
%%
simCommand = '"CrossBridgeCycling.mantATP.LabelLib.XBCycling",startTime=-1200,stopTime=600, numberOfIntervals=5000';
param_names = {'tune_a','tune_b','tune_c'};
param_vals = [1, 1, 1];
outputVar = 'integratedSquaredDeviation.y';
param_sel = [1 2 3];

optimFun = @(x) evalModel(param_names(param_sel), x, simCommand, outputVar);


optimFun([0.3 0.3 0.3])
% x = param_vals(param_sel);
% x = fminsearch(optimFun, x);
%%
[a, b] = dymosim();
%%
% Plot results
plot(time, output);
xlabel('Time');
ylabel('Variable Value');
title('Dymola Model Simulation in MATLAB');

% Close Dymola session
dymola.close();



function c = evalModel(param_names, param_vals, simCommand, outputVar)
    tic;
    for i = 1:length(param_names)
        dymola(sprintf('%s = %g', param_names{i}, param_vals(i)));
        % sprintf('%s = %g', param_names{i}, param_vals(i))
    end
    toc, tic;
    dymola(['simulateModel(' simCommand ',resultFile="dsres")']);
    toc, tic;
    dym = dymload('dsres.mat');
    toc, tic;
    y = dymget(dym, outputVar);
    toc, tic;
    c = y(end);
end