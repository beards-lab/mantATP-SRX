% File: make_plots.m
addpath('c:\Program Files\Dymola 2025x\Mfiles\dymtools\')

def_aux;
saveFigs = false;
%%

figure(2);
modelName = 'DefaultH';
Figure2;

if saveFigs
    saveas(gca, "../figures/Figure2.fig")
    saveas(gca, "../figures/Figure2.png")
end

figure(3)
modelName = 'DefaultW';
Figure2;

if saveFigs
    saveas(gca, "../figures/Figure3.fig")
    saveas(gca, "../figures/Figure3.png")
    % saveas(gca, "../figures/Figure4.fig")
    % saveas(gca, "../figures/Figure4.png")
end

%% Output the table of kinetic params

datafile = '../Modelica/DefaultH.mat';
datafile = '../Modelica/DefaultW.mat';
dl = dymload(datafile);

time_conv = 1/60;
getVals = @(s) dymget(dl, s);
getVal = @(s) tail(getVals(s), 1);

% Get all values first to determine the correct size  
values = [getVal('kH.rate');   
          getVal('kH_m.rate');   
          getVal('k_srx_p.rate');  
          getVal('k_srx_m.rate');             
          head(getVals('A2.pop'), 1);
          getVal('ageTime')
          ];  

% Now create matching params and units arrays  
params = {'k_H', 'k_DRX_D', 'k_SRX_P', 'k_SRX_M', 'P_A2', 'ageTime'};  % Note the transpose  
units = {'s-1'; 's-1'; 's-1'; 's-1'; '1'; 's'};  % Must match number of rows  

kinetic_table = table(values, units, ...  
                    'RowNames', params, ...  
                    'VariableNames', {'Value', 'Unit'});  

% Display with title  
disp('Cardiac Myosin Kinetic Parameters:');  
disp(kinetic_table);  




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
clf;
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

% Define the model as a sum of two exponential decays
model1 = fittype('1 - a*(1 - exp(-t/t1)) - b*(1 - exp(-t/t2))', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2'});

model2 = fittype('a*(exp(-t/t1)) + b*(exp(-t/t2)) + o', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2', 'o'});

% Set initial guesses for the parameters
initialGuess = [0.5, 0.5, 14, 140]; % Adjust these based on your data
opts = fitoptions('StartPoint', initialGuess, 'Method', 'NonlinearLeastSquares','Lower',[0 0, 0, 0],'Upper',[1, 1, 100, 1000]);

initialGuess = [0.5, 0.5, 14, 140, 0]; % Adjust these based on your data
opts2 = fitoptions('StartPoint', initialGuess, 'Method', 'NonlinearLeastSquares','Lower',[0 0, 0, 0, -0.2],'Upper',[1, 1, 100, 1000, 0.2]);

figure(4);clf;
% nexttile;hold on; 
% List of filenames based on the suffixes used in your Dymola runs  
% Incubation time with mATP
ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60, 120, 300, 600, 1200];
ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60, 120, 240, 300, 400, 450, 500, 600, 1200];
ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60, 120, 300, 600, 900, 1200, 3600];
ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60, 120, 300, 600, 900];
rigorFrac = [0, 20, 40, 60, 80, 95];


fit1_A = zeros(size(ageTimes'*rigorFrac));
fit2_A = zeros(size(fit1_A));
fit1_B = zeros(size(fit1_A));
fit2_B = zeros(size(fit1_A));
slowPhase1_background = zeros(size(fit1_A));
SRX_labelFraction = zeros(size(fit1_A));
SRX_pop = zeros(size(fit1_A));
maxLabel = zeros(size(fit1_A));

% Loop to load each file  
for i = 1:length(ageTimes)  
    nexttile;        hold on;    
    for j = 1:length(rigorFrac)    
    filename = sprintf('../Modelica/mantATP.LabelLib.Figures.DefaultW_%dA2_%d.mat', ageTimes(i)*1000, rigorFrac(j));  
    
    if exist(filename, 'file')  

        dl = dymload(filename);
        time = dymget(dl, 'Time');
        validTime = sum(time>=0);
        time = tail(time, validTime);

        label = tail(dymget(dl, 'totalLabel.y'), validTime);

        DRX_label = tail(dymget(dl, 'DRXLabel.y'), validTime);
        SRX_label = tail(dymget(dl, 'SRXLabel.y'), validTime);

        SRX_labelFraction(i, j) = tail(dymget(dl, 'SRX_fraction'), 1);
        SRX_pop(i, j) = tail(dymget(dl, 'SRX.pop'), 1);
        maxLabel(i, j) = tail(dymget(dl, 'normFactor'), 1);
        
        % scale = max(label);
        bckg = scale*0.05;
        % labelWBckg = (label + bckg)/(scale + bckg);

        % label = label/scale;
        yma = max(label);
        ymi = min(label);
        yfit_norMax = label/yma;
        yfit_norMinMax = (label-ymi)/(yma -ymi);

        % validTime = sum(time>0);
        % label = label(validTime)/scale;
        % time = time(validTime);

        % Perform the fit
        [fitResult1, gof] = fit(time, yfit_norMax, model1, opts);
        [fitResult2, gof2] = fit(time, yfit_norMinMax, model2, opts2);
        % [fitResultWBckg, gof2_5] = fit(time, labelWBckg, model1, opts);
        %% fit state labels separately
        % opts_single = opts;
        % opts_single.TolFun = 1e-9;
        % opts_single.Upper = [1 0 400 1000];
        % opts_single.StartPoint = [0.5 0 5 100];
        % [fitResult_singleDrx, gof3] = fit(time, DRX_label, model2, opts_single);
        % opts_single.StartPoint = [0.5 0 150 100];
        % [fitResult_singleSrx, gof4] = fit(time, SRX_label, model2, opts_single);

        
        
        plot(time, yfit_norMax, '-', time, yfit_norMinMax, '-',time, fitResult1(time), '--', time, fitResult2(time), ':', LineWidth=2); 
        % plot(time, label, '-', LineWidth=1.5);
        % plot(time, DRX_label, '-', time, fitResult_singleDrx(time), '--', time, SRX_label, '-', time, fitResult_singleSrx(time),'--', LineWidth=1.5);
        % plot(time, labelWBckg, '-', time,fitResultWBckg(time), '--',  LineWidth=1.5);
        % title(sprintf("Incubation %g s", ageTimes(i))); 


        fit1_A(i, j) = fitResult1.a;
        fit1_B(i, j) = fitResult1.b;
        fit1_T1(i, j) = fitResult1.t1;
        fit1_T2(i, j) = fitResult1.t2;

        fit2_A(i, j) = fitResult2.a;
        fit2_B(i, j) = fitResult2.b;
        fit2_T1(i, j) = fitResult2.t1;
        fit2_T2(i, j) = fitResult2.t2;
        
        % slowPhase1_background(i, j) = fitResultWBckg.b;

    else  
        warning('File %s not found!', filename);  
    end  
    end
end
%%
figure(2);clf;
tiledlayout('flow', 'TileSpacing','compact')
l2 = 1.5;
nexttile(1, [1 2]);
% semilogx(fileSuffixes, slowPhase1, 's-', fileSuffixes, slowPhase2, 'd-', fileSuffixes, SRX_labelFraction, 'x-', fileSuffixes, SRX_pop, 'o-',LineWidth=1.5, MarkerSize=8);
ub_40 = find(rigorFrac == 40, 1);
semilogx(ageTimes, fit1_B(:, ub_40), 's-', ...
    ageTimes, fit2_B(:, ub_40), 'x-', ...
    ageTimes, SRX_pop(:, ub_40), '+-', ...
    LineWidth=lw, MarkerSize=8);
    % ageTimes, maxLabel(:, 2), 'o-', ...

hold on;
% plot(fileSuffixes, slowPhase1_background, '+-', LineWidth=1.5);
errorbar(walklate1D.AgeTime, walklate1D.SRX/100, walklate1D.SD/100,LineWidth=lw, MarkerSize=8);
ylim([0 inf])
xlim([0.2, 900])
legend('Slow phase eq. 1', 'Slow phase eq. 2', 'SRX population', 'Data (Walklate 2022)', Location='best')
xlabel('mATP incubation time (s)', Interpreter='latex');ylabel('Slow phase fraction (\%)', Interpreter='latex')
xticks([ageTimes])

nexttile();
%
hold on;
ageTimesSubSel = [1 6 7 8 9 10 12];
plot(rigorFrac, fit1_B(ageTimesSubSel, :), 'x-',LineWidth=lw);
% plot(rigorFrac, slowPhase2(ageTimesSubSel, :), '+-');


legend(string(ageTimes(ageTimesSubSel)), Location="best");
xlabel('Initial rigor fraction', Interpreter='latex')
ylabel('Slow phase fraction', Interpreter='latex')

nexttile; 
semilogx(ageTimes, maxLabel, '+-', LineWidth=lw, MarkerSize=8);
xlabel('mATP incubation time (s)', Interpreter='latex');ylabel('Maximal $A_{tot}$ (\% of max)', Interpreter='latex')
legend(string(rigorFrac), Location="best")
% nexttile; 
% plot(rigorFrac, maxLabel(ageTimesSubSel, :));
% legend(string(ageTimes(ageTimesSubSel)), Location="best");

if exist('saveFigs') && saveFigs
    saveas(gcf, "../figures/Figure3.fig")
    saveas(gcf, "../figures/Figure3.png")
end

figure(3);clf;
nexttile;hold on;
% semilogx([0.2],[]);hold on;
errorbar(ageTimes, mean(fit1_T2'), std(fit1_T2'));
errorbar(ageTimes, mean(fit2_T2'), std(fit2_T2'));
ax = gca;
ax.XScale = 'log';
nexttile; hold on;
errorbar(ageTimes, mean(fit1_T1'), std(fit1_T1'));
errorbar(ageTimes, mean(fit2_T1'), std(fit2_T1'));
ax = gca;
ax.XScale = 'log';
% semilogx(ageTimes, fit1_T1)
% plot(rigorFrac, fit1_T1)

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