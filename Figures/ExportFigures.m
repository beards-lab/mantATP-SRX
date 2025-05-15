% File: make_plots.m
addpath('c:\Program Files\Dymola 2025x\Mfiles\dymtools\')

def_aux;

%% Fig result baseline A
cf = figure(1); clf; 
tiledlayout(1, 3, 'TileSpacing','Tight')

datafile = '../Modelica/CrossBridgeCycling.mantATP.LabelLib.Figures.DefaultH.mat';
datafile = '../Modelica/DefaultH.mat';

dl = dymload(datafile);

time_conv = 1/60;
time = dymget(dl, 'Time')*time_conv;
getVals = @(s) dymget(dl, s);
getValsToPerc = @(s) getVals(s)*100;

agetime = getVals('ageTime');
xl = [-5, 10]*60*time_conv;
% Coordinates for the marker
x_marker = -agetime(1)*time_conv;


nexttile;hold on;
plot(time, getValsToPerc('SRX.pop'), LineWidth=1, DisplayName='$P_{SRX}$');
plot(time, getValsToPerc('DRX_T.pop')*1000, '--', LineWidth=1, DisplayName='$P_{DRX_{ATP}}$x10$^3$');
plot(time, getValsToPerc('DRX_D.pop'), LineWidth=1, DisplayName='$P_{DRX_{ADP}}$');
plot(time, getValsToPerc('A2.pop'), LineWidth=1, DisplayName='$P_{A2}$');
% plot([time(1) time(end)], max(getValsToPerc('SRX_fraction'))*[1 1], ':', LineWidth=2, DisplayName='Slow-phase')
legend(interpreter = "latex", Orientation="vertical", Location="northeast");
xlim(xl);
ylim([0 100])
xlabel('Time (min)', Interpreter='latex');ylabel('Population (\%)', Interpreter='latex')
placeMarker(x_marker);


nexttile; hold on;
plot(time, getValsToPerc('SRXLabel.y'), LineWidth=1.5, DisplayName='$A_{SRX}$');
plot(time, getValsToPerc('DRXLabel.y'), LineWidth=1.5, DisplayName='$A_{DRX}$');
plot(time, getValsToPerc('totalLabel.y'), LineWidth=2, DisplayName='$A_{Tot}$');
xlim(xl);ylim([0, 100])

xlabel('Time (min)', Interpreter='latex');ylabel('Fluorescence (\% of max)', Interpreter='latex')
plot([0 0], [0 max(getValsToPerc('totalLabel.y'))*1.1], 'k--', LineWidth=0.5, DisplayName="$t_0$");
legend(interpreter = "latex", Orientation="vertical", Location="northeast");
placeMarker(x_marker);

% fit to ctrl from Julia and Alison
% data_control1 = [0,1; 18,0.704575;       27.994,0.628669; 37.988,0.532319; 47.982,0.519323; 57.976,       0.463446; 67.97,0.443831; 77.964,0.402628; 87.958,0.347676;       97.952,0.306668; 107.946,0.254855; 117.94,0.222877; 127.935,       0.186469; 137.929,0.190436; 147.923,0.191677; 157.917,0.158652;       167.911,0.150694; 177.905,0.135556; 187.899,0.143831; 197.893,       0.121392; 207.887,0.11779; 217.881,0.105232; 227.875,0.111073;       237.869,0.099732; 247.863,0.107471; 257.857,0.104673; 267.851,       0.090801; 277.845,0.0734; 287.839,0.09944; 297.833,0.0734;       307.827,0.08019; 317.822,0.068654; 327.816,0.072937; 337.81,       0.074179; 347.804,0.077659; 357.798,0.093332; 367.792,0.055245;       377.786,0.081747; 387.78,0.060088; 397.774,0.062521; 407.768,       0.057532; 417.762,0.066488; 427.756,0.047165; 437.75,0.076856;       447.744,0.044512; 457.738,0.042346; 467.732,0.060793; 477.726,       0.045534; 487.72,0.03816; 497.714,0.03378; 507.708,0.030129;       517.703,0.03962; 527.697,0.010416; 537.691,0.034826; 547.685,       0.028304; 557.679,0.00202; 567.673,0.034802; 577.667,0.017985;       587.661,-0.00431; 597.655,0.024556; 607.649,0.021514; 617.643,-0.00358];
% plot(data_control1(:, 1)*time_conv, data_control1(:, 2)*max(getVals('totalLabel.y'))*100, '.', MarkerSize=15, DisplayName='Data Ctrl1')
xfit = data_control1(:, 1); yfit = data_control1(:, 2);

% fit to exp from hooijman
xfit = dymget(dl, 'Time');
Lxfit = sum(xfit >= 0);
xfit = tail(xfit, Lxfit);
yfit = tail(getValsToPerc('totalLabel.y'), Lxfit);
% scale
yfit = yfit/max(yfit);

% Define the model as a sum of two exponential decays
model1 = fittype('1 - a*(1 - exp(-t/t1)) - b*(1 - exp(-t/t2))', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2'});

model2 = fittype('a*(exp(-t/t1)) + b*(exp(-t/t2))', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2'});

% Set initial guesses for the parameters
initialGuess = [0.5, 0.5, 14, 140]; % Adjust these based on your data
opts = fitoptions('StartPoint', initialGuess, 'Method', 'NonlinearLeastSquares','Lower',[0 0, 0, 0],'Upper',[1, 1, 100, 1000]);
% Perform the fit
[fitResult1, gof] = fit(xfit, yfit, model1, opts);
[fitResult2, gof2] = fit(xfit, yfit, model2, opts);


scale = max(dymget(dl, 'totalLabel.y'));

% data
% plot(xfit/60, yfit*100*scale, 'd', ...
%     xfit/60, fitResult1(xfit)*100*scale, '--', ...
%     xfit/60, fitResult2(xfit)*100*scale, '--', LineWidth=1.5)
% timecourse both
% plot(xfit/60, fitResult1(xfit)*100*scale, '--', ...
%     xfit/60, fitResult2(xfit)*100*scale, '--', LineWidth=1.5)
% timecourse only model 1 - they are the same
plot([0 ; xfit]/60, fitResult1([0 ; xfit])*100*scale, '--', LineWidth=3.5, DisplayName="Fit eq. 1")



% bar_cats = ["fast phase - eq. 1", "fap2", "SRX label fraction", "SRX population"];
% bars = [fitResult1.b, fitResult2.b, tail(dymget(dl, 'SRX_fraction'), 1), tail(dymget(dl, 'SRX.pop'), 1)]
% bar_cats = ["Slow phase - eq. 1", "SRX label fraction", "SRX population"];

bar_cats = ["$A_2$ (eq. 1)", "$A_{SRX}$  / $A_{tot}$", "$P_{SRX}$"];
bars = [fitResult1.b, tail(dymget(dl, 'SRX_fraction'), 1), tail(dymget(dl, 'SRX.pop'), 1)]

x = categorical(bar_cats);
x = reordercats(x, bar_cats)

nexttile; bar(x, bars); ylabel('Fraction (-)', Interpreter='latex')
ax = gca;  ax.TickLabelInterpreter = 'latex';  
fontsize(12, 'points')

% Add value labels atop each bar
for i = 1:length(bars)
    text(x(i), bars(i) + 0.01, sprintf('%.2f', bars(i)), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 12);
end

%% Output the table of kinetic params
getVal = @(s) tail(getVals(s), 1);

% Get all values first to determine the correct size  
values = [getVal('kH.rate');   
          getVal('kH_m.rate');   
          getVal('k_srx_p.rate');  
          getVal('k_srx_m.rate');   
          head(getVals('A2.pop'), 1)];  

% Now create matching params and units arrays  
params = {'k_H', 'k_DRX_D', 'k_SRX_P', 'k_SRX_M', 'P_A2'}';  % Note the transpose  
units = {'s-1'; 's-1'; 's-1'; 's-1'; '1'};  % Must match number of rows  

kinetic_table = table(values, units, ...  
                    'RowNames', params, ...  
                    'VariableNames', {'Value', 'Unit'});  

% Display with title  
disp('Cardiac Myosin Kinetic Parameters:');  
disp(kinetic_table);  

%% second plot with longer age time

% datafile = '../CrossBridgeCycling.mantATP.LabelLib.Figures.Default_ageTime.mat';
% dl = dymload(datafile);
% 
% time_conv = 1/60;
% time = dymget(dl, 'Time')*time_conv;
% getVals = @(s) dymget(dl, s);
% getValsToPerc = @(s) getVals(s)*100;
% 
% agetime = getVals('ageTime');
% % Coordinates for the marker
% x_marker = -agetime(1)*time_conv;
% 
% 
% nexttile;hold on;
% plot(time, getValsToPerc('SRX.pop'), LineWidth=1, DisplayName='SRX');
% plot(time, getValsToPerc('DRX_T.pop')*1000, '--', LineWidth=1, DisplayName='DRX$_{ATP}$x10$^3$');
% plot(time, getValsToPerc('DRX_D.pop'), LineWidth=1, DisplayName='DRX$_{ADP}$');
% plot(time, getValsToPerc('A2.pop'), LineWidth=1, DisplayName='A2');
% plot([time(1) time(end)], max(getValsToPerc('SRX_fraction'))*[1 1], ':', LineWidth=2, DisplayName='Slow-phase')
% legend(interpreter = "latex", Orientation="vertical", Location="northeast");
% xlim(xl);
% xlabel('Time (min)');ylabel('Population (%)')
% placeMarker(x_marker);
% 
% 
% nexttile; hold on;
% plot(time, getValsToPerc('SRXLabel.y'), LineWidth=1, DisplayName='SRX');
% plot(time, getValsToPerc('DrxLabel.y'), LineWidth=1, DisplayName='DRX');
% plot(time, getValsToPerc('totalLabel.y'), LineWidth=1, DisplayName='Total');
% xlim(xl);ylim([0, 80])
% xlabel('Time (min)');ylabel('Fluorescence (% of max)')
% plot(data_control1(:, 1)*time_conv, data_control1(:, 2)*max(getVals('totalLabel.y'))*100, '.', MarkerSize=15, DisplayName='Data Ctrl1')
% plot([0 0], [0 max(getValsToPerc('totalLabel.y'))*1.1], 'k--', LineWidth=0.5, DisplayName="$t_0$");
% legend(interpreter = "latex", Orientation="vertical", Location="east");
% placeMarker(x_marker);

fontsize(12, 'points');
if saveFigs
    saveas(cf, "../figures/Figure2.fig")
    saveas(cf, "../figures/Figure2.png")
end

%% Fig 3
walklate1D = readtable('../data/Walklate J Biol Chem 2022 Fig 1D.csv')
modelvals = readtable('../ModelResults/SRX_DRX label fractions_sweep agetime.csv')
cf = figure(3);clf;hold on;

% Sample data (copy this if needed)
walklate1D = table([0.2; 0.5; 1; 2; 5; 10; 30; 60], ...
          [27.88; 25.69; 21.84; 23.73; 18.36; 18.36; 22.27; 17.02], ...
          [7.08; 7.63; 2.44; 4.76; 2.81; 4.64; 1.04; 1.53], ...
          [72; 74.37; 78.16; 76.27; 81.57; 81.45; 77.79; 82.98], ...
          [7.14; 7.69; 2.56; 4.76; 2.81; 4.64; 1.1; 1.59], ...
          'VariableNames', {'AgeTime','SRX','SD','DRX','SD_1'});

%% is there a significant trend?

% Given data
N = 16;
SD = walklate1D.SD;
weights = N ./ (SD .^ 2);  % inverse of variance of the mean

% Log-transform AgeTime
logAge = log(walklate1D.AgeTime);

% Fit weighted linear model
mdl_w = fitlm(logAge, walklate1D.SRX, 'Weights', weights);

% Display regression results
disp(mdl_w);

% Plot with regression line
figure;
errorbar(walklate1D.AgeTime, walklate1D.SRX, SD/sqrt(N), 'o', ...
    'MarkerFaceColor', 'b', 'LineStyle', 'none'); hold on;

xfit = linspace(min(walklate1D.AgeTime), max(walklate1D.AgeTime), 100);
yfit = predict(mdl_w, log(xfit)');
plot(xfit, yfit, 'r-', 'LineWidth', 2);

set(gca, 'XScale', 'log');
xlabel('AgeTime (s)', 'Interpreter', 'latex');
ylabel('SRX (\%)', 'Interpreter', 'latex');
title('Weighted regression: SRX vs. AgeTime');
grid on;


%%
% Prepare data
x = categorical(string(walklate1D.AgeTime));  % use AgeTime as categories
x = reordercats(x, string(walklate1D.AgeTime));  % preserve order

Y = [walklate1D.SRX, walklate1D.DRX];         % bar heights
E = [walklate1D.SD, walklate1D.SD_1];         % error bars

% Plot grouped bar chart
% figure;
bh = bar(x, Y, 'grouped'); hold on;

% Add error bars
ngroups = size(Y, 1);
nbars = size(Y, 2);
groupwidth = min(0.8, nbars/(nbars + 1.5));

h = plot(x, modelvals.Var2(1:ngroups)*100, 'd-', LineWidth=2.5, MarkerSize=8, DisplayName='Jou')
h.MarkerFaceColor = h.Color;

for i = 1:nbars
    % X coordinates for error bars
    xbar = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(xbar, Y(:,i), E(:,i), 'k', 'linestyle', 'none', 'LineWidth', 1);
end


% check the sum is 100%
% plot(x, walklate1D.SRX + walklate1D.DRX);

% Labels
xlabel('Incubation Time (s)');
ylabel('Relative amplitude (%)');
legend({'Slow phase','Fast phase', 'Model fast phase'});
title('SRX and DRX with Standard Deviation');

fontsize(12, "points")

if saveFigs
    saveas(cf, "Figure3.fig")
    saveas(cf, "Figure3.png")
end

%% retrieve all simulations from DYmola

figure(4);clf;
% nexttile;hold on; 
% List of filenames based on the suffixes used in your Dymola runs  
fileSuffixes = [.2, .5, 1, 2, 5, 10, 30, 60, 120, 300, 600, 1200];
fileSuffixes = [.2, .5, 1, 2, 5, 10, 30, 60, 120, 240, 300, 400, 450, 500, 600, 1200];
fileSuffixes = [.2, .5, 1, 2, 5, 10, 30, 60, 120, 300, 600, 900, 1200, 3600];
fastPhase1 = [];
fastPhase2 = [];
slowPhase1 = [];
slowPhase2 = [];
slowPhase1_background = [];
SRX_labelFraction = [];
SRX_pop = [];

% Initialize a cell array to store the data  
dataCells = cell(length(fileSuffixes), 1);  

% Loop to load each file  
for i = 1:length(fileSuffixes)  
    filename = sprintf('../Modelica/mantATP.LabelLib.Figures.DefaultH_%dA2_0.mat', fileSuffixes(i)*1000);  
    if exist(filename, 'file')  

        dl = dymload(filename);
        time = dymget(dl, 'Time');
        validTime = sum(time>=0);
        time = tail(time, validTime);

        label = tail(dymget(dl, 'totalLabel.y'), validTime);

        DRX_label = tail(dymget(dl, 'DrxLabel.y'), validTime);
        SRX_label = tail(dymget(dl, 'SRXLabel.y'), validTime);

        SRX_labelFraction(i) = tail(dymget(dl, 'SRX_fraction'), 1);
        SRX_pop(i) = tail(dymget(dl, 'SRX.pop'), 1);
        
        scale = max(label);
        bckg = scale*0.1;
        labelWBckg = (label + bckg)/(scale + bckg);

        label = label/scale;

        % validTime = sum(time>0);
        % label = label(validTime)/scale;
        % time = time(validTime);

        % Perform the fit
        [fitResult1, gof] = fit(time, label, model1, opts);
        [fitResult2, gof2] = fit(time, label, model2, opts);
        [fitResultWBckg, gof2_5] = fit(time, labelWBckg, model1, opts);
        %% fit state labels separately
        opts_single = opts;
        opts_single.TolFun = 1e-9;
        opts_single.Upper = [1 0 400 1000];
        opts_single.StartPoint = [0.5 0 5 100];
        [fitResult_singleDrx, gof3] = fit(time, DRX_label, model2, opts_single);
        opts_single.StartPoint = [0.5 0 150 100];
        [fitResult_singleSrx, gof4] = fit(time, SRX_label, model2, opts_single);

        
        % nexttile;        hold on;
        % plot(time, label, '-', time, fitResult1(time), '--', time, fitResult2(time), ':', LineWidth=2); 
        % plot(time, label, '-', LineWidth=1.5);
        % plot(time, DRX_label, '-', time, fitResult_singleDrx(time), '--', time, SRX_label, '-', time, fitResult_singleSrx(time),'--', LineWidth=1.5);
        % plot(time, labelWBckg, '-', time,fitResultWBckg(time), '--',  LineWidth=1.5);
        % title(sprintf("Incubation %g s", fileSuffixes(i))); 


        fastPhase1(i) = fitResult1.a;
        fastPhase2(i) = fitResult2.a;
        slowPhase1(i) = fitResult1.b;
        slowPhase2(i) = fitResult2.b;
        slowPhase1_background(i) = fitResultWBckg.b;

    else  
        warning('File %s not found!', filename);  
    end  
end  
 
figure(2);clf;
semilogx(fileSuffixes, slowPhase1, 's-', fileSuffixes, slowPhase2, 'd-', fileSuffixes, SRX_labelFraction, 'x-', fileSuffixes, SRX_pop, 'o-',LineWidth=1.5, MarkerSize=8);
hold on;
plot(fileSuffixes, slowPhase1_background, '+-', LineWidth=1.5);
errorbar(walklate1D.AgeTime, walklate1D.SRX/100, walklate1D.SD/100);
ylim([0 1])

% Now, dataCells contains all the loaded structures.  
% You can access each loaded data with dataCells{1}, dataCells{2}, etc.

function placeMarker(x_marker)

    % Add a triangle character as x-tick label
    ax = gca;
    xt = ax.XTick;

    if ~ismember(x_marker, xt)
        xt = sort([xt, x_marker]);
    end
    
    ax.XTick = xt;
    xt = ax.XTick;
    
    
    xticklabels = string(ax.XTickLabel);
    
    % Find the index of -60
    idx = find(xt == x_marker);
    if ~isempty(idx)
        xticklabels(idx) = "▲";  % Unicode upward triangle
    end
    
    ax.XTickLabel = xticklabels;
end