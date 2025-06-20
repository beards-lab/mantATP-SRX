clear;clf;

% Save time
    walklate1D = table([0.2; 0.5; 1; 2; 5; 10; 30; 60], ...
              [27.88; 25.69; 21.84; 23.73; 18.36; 18.36; 22.27; 17.02], ...
              [7.08; 7.63; 2.44; 4.76; 2.81; 4.64; 1.04; 1.53], ...
              [72; 74.37; 78.16; 76.27; 81.57; 81.45; 77.79; 82.98], ...
              [7.14; 7.69; 2.56; 4.76; 2.81; 4.64; 1.1; 1.59], ...
              'VariableNames', {'AgeTime','SRX','SD','DRX','SD_1'});


def_aux;
saveFigs = false;

ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60.0000,  120.0000,  300.0000,  900.0000];

rigorFrac = 40;

%% Fadp = 0.1%
figure(1);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP01_ADP01_%d.mat', firstDim);
outS(1, 1) = load_sim_results(ageTimes*1000, [10], filenameFun);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP1_ADP01_%d.mat', firstDim);
outS(2, 1) = load_sim_results(ageTimes*1000, [10], filenameFun);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP10_ADP01_%d.mat', firstDim);
outS(3, 1) = load_sim_results(ageTimes*1000, [10], filenameFun);

figure(231);clf;
lw = 1;
semilogx(ageTimes, outS(1, 1).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
hold on;
semilogx(ageTimes, outS(2, 1).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
semilogx(ageTimes, outS(3, 1).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
xticks(ageTimes)
errorbar(walklate1D.AgeTime, walklate1D.SRX, walklate1D.SD, 's-', LineWidth=lw, MarkerSize=8);
title('ADP is 0.1% in ATP solution');

%% Fadp = 0.5%
figure(1);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP01_%d.mat', firstDim);
outS(1, 2) = load_sim_results(ageTimes*1000, [10], filenameFun);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP1_%d.mat', firstDim);
outS(2, 2) = load_sim_results(ageTimes*1000, [10], filenameFun);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP10_%d.mat', firstDim);
outS(3, 2) = load_sim_results(ageTimes*1000, [10], filenameFun);

figure(232);clf;
lw = 1;
semilogx(ageTimes, outS(1, 2).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
hold on;
semilogx(ageTimes, outS(2, 2).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
semilogx(ageTimes, outS(3, 2).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
xticks(ageTimes)
errorbar(walklate1D.AgeTime, walklate1D.SRX, walklate1D.SD, 's-', LineWidth=lw, MarkerSize=8);
title('ADP is 0.5% in ATP solution');

%% Fadp = 5%
figure(1);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP01_ADP5_%d.mat', firstDim);
outS(1, 3) = load_sim_results(ageTimes*1000, [10], filenameFun);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP1_ADP5_%d.mat', firstDim);
outS(2, 3) = load_sim_results(ageTimes*1000, [10], filenameFun);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP10_ADP5_%d.mat', firstDim);
outS(3, 3) = load_sim_results(ageTimes*1000, [10], filenameFun);

figure(233);clf;
lw = 1;
semilogx(ageTimes, outS(1, 3).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
hold on;
semilogx(ageTimes, outS(2, 3).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
semilogx(ageTimes, outS(3, 3).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
xticks(ageTimes)
errorbar(walklate1D.AgeTime, walklate1D.SRX, walklate1D.SD, 's-', LineWidth=lw, MarkerSize=8);
title('ADP is 5% in ATP solution');

%% COmpare per fADP

figure(235);clf;
semilogx(ageTimes, outS(2, 1).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
hold on;
semilogx(ageTimes, outS(2, 2).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
semilogx(ageTimes, outS(2, 3).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);

xticks(ageTimes)
errorbar(walklate1D.AgeTime, walklate1D.SRX, walklate1D.SD, 's-', LineWidth=lw, MarkerSize=8);
title('ADP is 5% in ATP solution');
