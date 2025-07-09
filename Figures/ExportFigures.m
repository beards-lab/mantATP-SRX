% File: make_plots.m
addpath('c:\Program Files\Dymola 2025x\Mfiles\dymtools\')

def_aux;
saveFigs = false;
%%

cf = figure(2);

modelName = 'DefaultH';
data_src = ' (Hooijman et al.)';
labelPosVariant = 1;
markP_S = '';
Figure2;

add_panel_labels(["(C)", "(D)", "(B)", "(A)"], 0, [], [-40, 5]);


if saveFigs
    saveas(gca, "../figures/Figure2.fig")
    saveas(gca, "../figures/Figure2.png")
end
%%
figure(3)
modelName = 'DefaultW';
modelName = 'XBCycling_Walklate2022Fig1A';
% modelName = 'XBCycling_Walklate_CalcADPDil_kADP01_fixedDil';
% modelName = 'XBCycling_Walklate_CalcADPDil_kADP10_fixedDil';
% modelName = 'XBCycling_Walklate_CalcADPDil_kADP01_fixedDil';
% modelName = 'mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP01_fixedDil_60000';
% modelName = 'mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP10_fixedDil_60000';
% modelName = 'mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP1_fixedDil_60000';

data_src = ' (Walklate et al.)';

labelPosVariant = 2;
markP_S = '*';
markP_S = '';
Figure2;

add_panel_labels(["(C)", "(D)", "(B)", "(A)"], 0, [], [-40, 5]);


if saveFigs
    saveas(gca, "../figures/Figure3.fig")
    saveas(gca, "../figures/Figure3.png")
    % saveas(gca, "../figures/Figure4.fig")
    % saveas(gca, "../figures/Figure4.png")
end

%% Output the table of kinetic params

datafile = '../Modelica/DefaultH.mat';
% datafile = '../Modelica/XBCycling_Walklate2022Fig1A.mat';
% datafile = '../Modelica/Walklate_80.mat';
% datafile = '../Modelica/XBCycling_Walklate_PB002.mat';
% datafile = '../Modelica/XBCycling_Walklate_CalcADPDil_kADP1.mat';

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



%% is there a significant trend in the walklate data?
% walklate1D = getWalklateData();
% % Given data
% N = 16;
% SD = walklate1D.SD;
% weights = N ./ (SD .^ 2);  % inverse of variance of the mean
% 
% % Log-transform AgeTime
% logAge = log(walklate1D.AgeTime);
% 
% % Fit weighted linear model
% mdl_w = fitlm(logAge, walklate1D.SRX, 'Weights', weights);
% 
% % Display regression results
% disp(mdl_w);
% 
% % Plot with regression line
% figure;
% errorbar(walklate1D.AgeTime, walklate1D.SRX, SD/sqrt(N), 'o', ...
%     'MarkerFaceColor', 'b', 'LineStyle', 'none'); hold on;
% 
% xfit = linspace(min(walklate1D.AgeTime), max(walklate1D.AgeTime), 100);
% yfit = predict(mdl_w, log(xfit)');
% plot(xfit, yfit, 'r-', 'LineWidth', 2);
% 
% set(gca, 'XScale', 'log');
% xlabel('AgeTime (s)', 'Interpreter', 'latex');
% ylabel('SRX (\%)', 'Interpreter', 'latex');
% title('Weighted regression: SRX vs. AgeTime');
% grid on;
% 
% 
% %% Redraw walklate figure
% clf;
% % Prepare data
% x = categorical(string(walklate1D.AgeTime));  % use AgeTime as categories
% x = reordercats(x, string(walklate1D.AgeTime));  % preserve order
% 
% Y = [walklate1D.SRX, walklate1D.DRX];         % bar heights
% E = [walklate1D.SD, walklate1D.SD_1];         % error bars
% 
% % Plot grouped bar chart
% % figure;
% bh = bar(x, Y, 'grouped'); hold on;
% 
% % Add error bars
% ngroups = size(Y, 1);
% nbars = size(Y, 2);
% groupwidth = min(0.8, nbars/(nbars + 1.5));
% 
% % h = plot(x, modelvals.Var2(1:ngroups)*100, 'd-', LineWidth=2.5, MarkerSize=8, DisplayName='Jou')
% % h.MarkerFaceColor = h.Color;
% 
% for i_pb = 1:nbars
%     % X coordinates for error bars
%     xbar = (1:ngroups) - groupwidth/2 + (2*i_pb-1) * groupwidth / (2*nbars);
%     errorbar(xbar, Y(:,i_pb), E(:,i_pb), 'k', 'linestyle', 'none', 'LineWidth', 1);
% end
% 
% 
% % check the sum is 100%
% % plot(x, walklate1D.SRX + walklate1D.DRX);
% 
% % Labels
% xlabel('Incubation Time (s)');
% ylabel('Relative amplitude (%)');
% legend({'Slow phase','Fast phase', 'Model fast phase'});
% title('SRX and DRX with Standard Deviation');
% 
% fontsize(12, "points")
% 
% if saveFigs
%     saveas(cf, "Figure3.fig")
%     saveas(cf, "Figure3.png")
% end
% 


%% plot Rigor sweep
% cf = figure(4);

data_src = ' (Walklate et al.)';
labelPosVariant = 1;
markP_S = '';

s = {'0', '20', '40', '60', '80','100'};
xax = cellfun(@(sx) str2num([sx]), s);

clear srx_pop srx_2 PB;
for i_rs = 1:length(s)
    figure(100 + i_rs);
    modelName = ['Walklate_A2' s{i_rs}];
    Figure2;
    panelC(i_rs) = ax3;
    srx_2(i_rs) = fitResult2.b/(fitResult2.a+fitResult2.b)*100;
    srx_pop(i_rs) = valAt10min('SRX.pop')*100;
end

for i_rs = 1:length(s)
    cf(i_rs) = figure(100 + i_rs);
    axes(panelC(i_rs));cla reset;hold on;
    bar(srx_pop, 'FaceColor',[1 1 1]*0.8); ylabel('SRX estimation (\%)', Interpreter='latex')
    
    srx_fake = nan(size(srx_pop)); srx_fake(i_rs) = srx_pop(i_rs);
    b = bar(srx_fake, 'FaceColor',[1 1 1]*0.6); ylabel('SRX estimation (\%)', Interpreter='latex')
    
    for j_rs = 1:length(srx_pop)
        text(j_rs, srx_pop(j_rs) + 0.01, sprintf('%.0f', srx_pop(j_rs)), ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 12);
    end
    
    
    set(panelC(i_rs), 'XTickLabel', xax, 'XTick', 1:length(s), 'TickLabelInterpreter', 'latex');
    xlabel('$P_{A2,0}$ (\%)', Interpreter='latex');
    ylabel('SRX fraction (\%)', Interpreter='latex');

    fontsize(12, 'points')
    add_panel_labels(["(C)", "(D)", "(B)", "(A)"], 0, [], [-40, 5]);

end

if saveFigs
    selFig = 5;
    saveas(cf(selFig), "../figures/Figure5.fig")
    saveas(cf(selFig), "../figures/Figure5.png")
end

%% Plot PB sweep

% cf = figure(4);

data_src = ' (Walklate et al.)';
labelPosVariant = 1;
markP_S = '';

s = {"0", "0001", "0005","001","002","005"};
xax = cellfun(@(sx) 1/(str2num(["0." + sx])), s);

clear srx_pop srx_2 PB;
for i_pb = 1:length(s)
    figure(100 + i_pb);clf;
    modelName = ['XBCycling_Walklate_PB' char(s{i_pb})];
    Figure2;
    panelC(i_pb) = ax3;
    srx_2(i_pb) = fitResult2.b/(fitResult2.a+fitResult2.b)*100;
    srx_pop(i_pb) = valAt10min('SRX.pop')*100;
    PB(i_pb) = valAt10min('photobleaching')*100;
    k_PB(i_pb) = getVal('k_pb'); %s-1
end
%%
for i_pb = 1:length(s)
    cf(i_pb) = figure(100 + i_pb);
    axes(panelC(i_pb));cla reset;hold on;
    bar(srx_pop, 'FaceColor',[1 1 1]*0.8); ylabel('SRX estimation (\%)', Interpreter='latex')
    
    srx_fake = nan(size(srx_pop)); srx_fake(i_pb) = srx_pop(i_pb);
    b = bar(srx_fake, 'FaceColor',[1 1 1]*0.6); ylabel('SRX estimation (\%)', Interpreter='latex')

    for j_rs = 1:length(srx_pop)
        text(j_rs, srx_pop(j_rs) + 0.01, sprintf('%.0f', srx_pop(j_rs)), ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 12);
        text(j_rs, srx_pop(j_rs)/2, sprintf('$B_{10m}$\n$%.0f\\%%$', 100-PB(j_rs)), ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'Interpreter', 'latex', ...
            'FontSize', 10);
    end
    
    % Create LaTeX-formatted tick labels
    xtick_labels = arrayfun(@(val) ...
    conditionalLabel(val), 1./k_PB, 'UniformOutput', false);
    xtick_labels = 1./k_PB;


    % xtick_labels(k_PB == 0) = {'0'};

    % Apply to axis (assuming panelC is your axis handle)
set(panelC(i_pb), 'XTickLabel', xtick_labels, 'XTick', 1:length(s), 'TickLabelInterpreter', 'latex');
    xlabel('$T_{pb}$ (s)', Interpreter='latex');
    ylabel('SRX fraction');
    xlim([0.5, length(s) + 0.5]);

    fontsize(12, 'points')
    add_panel_labels(["(C)", "(D)", "(B)", "(A)"], 0, [], [-40, 5]);
end

if saveFigs
    selFig = 5;
    saveas(cf(selFig), "../figures/Figure6.fig")
    saveas(cf(selFig), "../figures/Figure6.png")
end

%% Plot ADP effect sweep

% cf = figure(4);

data_src = ' (Walklate et al.)';
labelPosVariant = 1;
markP_S = '';

s = {"01", "1","10","100"};
% xax = cellfun(@(sx) str2num([sx]), s);

clear srx_pop srx_2 C_ADP;
for i_ADP = 1:length(s)
    figure(100 + i_ADP);clf;
    modelName = ['XBCycling_Walklate_CalcADPDil_kADP' char(s{i_ADP})];
    Figure2;
    panelC(i_ADP) = ax3;
    srx_2(i_ADP) = fitResult2.b/(fitResult2.a+fitResult2.b)*100;
    srx_pop(i_ADP) = valAt10min('SRX.pop')*100;
    C_ADP(i_ADP) = valAt10min('dilutionEffect.y')*1000; % uM
    Eff_ADP(i_ADP) = 100 - valAt10min('inverseProportionalFactor.effect')*100; % (%)
    Ki(i_ADP) = getVal('Ki_ADP')*1e3; % uM
end

for i_ADP = 1:length(s)
    cf(i_ADP) = figure(100 + i_ADP);
    axes(panelC(i_ADP));cla reset;
    % hold on;
    % set(gca, 'XTick', [], 'YTick', [])
    bar(srx_pop, 'FaceColor',[1 1 1]*0.8); ylabel('SRX estimation (\%)', Interpreter='latex')
    
    srx_fake = nan(size(srx_pop)); srx_fake(i_ADP) = srx_pop(i_ADP);
    hold on;
    b = bar(srx_fake, 'FaceColor',[1 1 1]*0.6); ylabel('SRX estimation (\%)', Interpreter='latex')

    for j_rs = 1:length(srx_pop)
        text(j_rs, srx_pop(j_rs) + 0.01, sprintf('%.0f', srx_pop(j_rs)), ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 12);
            % sprintf('$\\hat{k}_{D_D}$\n$%.0f\\%%$', Eff_ADP(j_rs)), ...

        text(j_rs, srx_pop(j_rs)/2, ...
             sprintf('$\\Delta\\hat{k}_{D_D,\\%%}$\n$%.0f\\%%$', Eff_ADP(j_rs)), ...
             'HorizontalAlignment', 'center', ...
             'VerticalAlignment', 'middle', ...
             'Interpreter', 'latex', ...
             'FontSize', 10);
    end
    
    set(panelC(i_ADP), 'XTickLabel', Ki, 'XTick', 1:length(s), 'TickLabelInterpreter', 'latex');
    xlim([0.5 4.5]);
    xlabel('$K_i$ ($\mu$M)', Interpreter='latex');
    ylabel('SRX fraction');

    fontsize(12, 'points')
    add_panel_labels(["(C)", "(D)", "(B)", "(A)"], 0, [], [-40, 5]);
end

if saveFigs
    selFig = 2;
    saveas(cf(selFig), "../figures/Figure7.fig")
    saveas(cf(selFig), "../figures/Figure7.png")
end

%% retrieve all simulations from DYmola

figure(4);clf;
% nexttile;hold on; 
% List of filenames based on the suffixes used in your Dymola runs  
% Incubation time with mATP
ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60, 120, 300, 600, 1200];
ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60, 120, 240, 300, 400, 450, 500, 600, 1200];
ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60, 120, 300, 600, 900, 1200, 3600];
ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60, 120, 300, 600, 900];
ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60, 120, 300, 600, 900, 1200, 3600];
ageTimes = [0.2000,   60.0000,  120.0000,  300.0000,  900.0000];
ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60.0000,  120.0000,  300.0000,  900.0000];
ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60.0000];

ageTimesSubSel = [1 8 9 10 12];
ageTimesSubSel = 1:length(ageTimes);

rigorFrac = [0, 20, 40, 60, 80, 95];
rigorFrac = [0, 40, 80, 95];
rigorFrac = [40];

k_adp = [0];
k_adp = [0.0100, 0.0215, 0.0464, 0.1000, 0.2154, 0.4642, 1.0000, 2.1544, 4.6416, 10.0000, 100, 1000];
k_adp = [0.0100, 0.1000, 0.2154, 0.4642, 1.0000, 2.1544, 4.6416, 10.0000];
k_adp = [0.1000, 0.2154, 0.5, 1.0000, 10.0000];
k_adp = [0.1000, 0.1143, 0.1286, 0.1429, 0.1571, 0.1714, 0.1857, 0.2000, 0.2055, 0.2111, 0.2169, 0.2228, 0.2289, 0.2352, 0.2417, 0.2483, 0.2551, 0.2621, 0.2693, 0.2766, 0.2842, 0.2920, 0.3000];
% k_adp = [0.0200, 0.0229, 0.0257, 0.0286, 0.0314, 0.0343, 0.0371, 0.0400];
rigorFrac = k_adp;

% filename = sprintf('../Modelica/mantATP.LabelLib.Figures.DefaultW_%dA2_%d.mat', ageTimes(i)*1000, rigorFrac(j));  
% filename = sprintf('../Modelica/mantATP.LabelLib.Figures.Walklate_PB_%dA2_%d.mat', ageTimes(i)*1000, rigorFrac(j));  
% filename = sprintf('../Modelica/mantATP.LabelLib.Figures.Walklate_CalcMantADP_%dA2_%d.mat', ageTimes(i)*1000, rigorFrac(j));  
% filename = sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_%dA2_40kAdp_%g.mat', ageTimes(i)*1000, k_adp(j));  
% filename = sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDilAffinity_%dA2_40kAdp_%g.mat', ageTimes(i)*1000, k_adp(j));  

filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_%dA2_40kAdp_%g.mat', firstDim, secondDim);
outS = load_sim_results(ageTimes*1000, rigorFrac, filenameFun);
%% Figure n. 4: age-time-sweep
clear;
clf;
def_aux;
saveFigs = false;


ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60.0000,  120.0000,  300.0000,  900.0000, 3600];
rigorFrac = [0, 20, 40, 60, 80, 95];
rigorFrac = [0, 40, 80];
ageTimesSubSel = [1 8 9 10 12];
walklate1D = getWalklateData();

filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Figures.DefaultW_%dA2_%d.mat', firstDim, secondDim);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Figures.DefaultW_%dA2_%d.mat', firstDim, secondDim);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Figures.DefaultW_%dA2_%d.mat', firstDim, secondDim);
% filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP02_%dA2_%d.mat', firstDim, secondDim);
outS = load_sim_results(ageTimes*1000, rigorFrac, filenameFun);
%% just plot Fig 4
cf = figure(5);clf;
aspect = 2;
% aspect = 1.0;
figscale = 1.0;
cf.Position = [300 60 figscale*7.2*96 figscale*7.2*96/aspect];

% tiledlayout(3, 2, 'TileSpacing','loose', 'Padding','compact')
tiledlayout(1, 2, 'TileSpacing','compact', 'Padding','compact')
lw = 1.5;
ms = 8;

ub_40 = find(rigorFrac == 40, 1);
% ub_40 = []
if isempty(ub_40)
    ub_40 = 1:size(outS.fit2_A, 2);
end


% nexttile(1, [2 2]);

ax2 = nexttile;
% panelB
% nexttile; 
cla;
% clf;r
selectedPlots = [3 7];
pl = gobjects(1, numel(selectedPlots));  % preallocate plot handles
pls = cell(1, numel(selectedPlots));     % preallocate legend strings
linestyles = {'k:', 'k-.', 'k--', 'k-.'};

ax2.TickLabelInterpreter = 'latex';

for i = 1:numel(selectedPlots)
    sp = selectedPlots(i);
    pl(i) = plot(outS.Time{sp, ub_40}/60, outS.Mtot{sp, ub_40}*100, linestyles{i}, LineWidth=2.5); hold on;
    pls{i} = sprintf('$M_{tot}$, $T_{incubation}$ = %gs', ageTimes(sp));
end
legend(pl, pls, 'Interpreter', 'latex');
xlim([-1, 10]);ylim([0, 80])
xlabel('$t$ (min)', Interpreter='latex');ylabel('Fluorescence (\% of max)', Interpreter='latex')


nexttile;
% semilogx(fileSuffixes, slowPhase1, 's-', fileSuffixes, slowPhase2, 'd-', fileSuffixes, SRX_labelFraction, 'x-', fileSuffixes, SRX_pop, 'o-',LineWidth=1.5, MarkerSize=8);
% semilogx(ageTimes, fit1_B(:, ub_40), 's-', ...
% without the eq1
semilogx(ageTimes, outS.fit2_B(:, ub_40)*100, '-', Color=[1 1 1]*0, LineWidth=lw, MarkerSize=ms);
hold on;
% semilogx(ageTimes, outS.SRX_pop(:, ub_40)*100, 'x-', Color=[1 1 1]*0, LineWidth=lw*2, MarkerSize=ms);
errorbar(walklate1D.AgeTime, walklate1D.SRX, walklate1D.SD, 's-', Color=[1 1 1]*0.5, LineWidth=lw*2, MarkerSize=8);
semilogx(ageTimes, outS.fit2_A(:, ub_40)*100, ':', Color=[1 1 1]*0, LineWidth=lw, MarkerSize=ms); 
% semilogx(ageTimes, outS.DRX_pop(:, ub_40)*100, 'x:', Color=[1 1 1]*0, LineWidth=lw*2, MarkerSize=ms);
errorbar(walklate1D.AgeTime, walklate1D.DRX, walklate1D.SD_1,'s:', Color=[1 1 1]*0.5, LineWidth=lw*2, MarkerSize=8);
ylim([0 100])
xlim([0.2, 3600])
% legend('$C_{slow}$ (model)', '$P_S$ (Model)', '$C_{slow}$ (Walklate 2022)', '$C_{fast}$ (model)', '$P_{D_D}$ + $P_{D_T}$ (Model)', '$C_{fast}$ (Walklate 2022)', Location='northeast', interpreter = "latex")
% xl = xlabel('mant-ATP incubation duration (s)', Interpreter='latex', HorizontalAlignment='center');
xl = xlabel('$T_{incubation}$ (s)', Interpreter='latex', HorizontalAlignment='center');
ylabel('Fraction (\%)', Interpreter='latex');
% xl.Position = xl.Position + [0 -2 0];

% xticks([ageTimes]);
xticks([0.2, 1, 10, 60, 900])

vd = 2;
% text(3600, outS.SRX_pop(end)*100 - vd, '$P_{S}$ (Model)', FontSize=12, HorizontalAlignment='right', VerticalAlignment='top', Interpreter='latex')
text(0.5, 2, 'Estimated $SRX$', FontSize=12, HorizontalAlignment='left', VerticalAlignment='bottom', Interpreter='latex')
text(120, outS.fit2_B(9)*100, '(model)', FontSize=12, HorizontalAlignment='left', VerticalAlignment='top', Interpreter='latex')
text(0.7, walklate1D.SRX(3) + walklate1D.SD(3) + 5, '(Walklate 2022)', FontSize=12, HorizontalAlignment='left', VerticalAlignment='bottom', Interpreter='latex')

% text(2, outS.DRX_pop(end)*100 + vd, '$P_{D_D} + P_{D_T}$ (Model)', FontSize=12, HorizontalAlignment='left', VerticalAlignment='bottom', Interpreter='latex')
text(0.5, 98, 'Estimated $DRX$', FontSize=12, HorizontalAlignment='left', VerticalAlignment='top', Interpreter='latex')
text(120, outS.fit2_A(9)*100, '(model)', FontSize=12, HorizontalAlignment='left', VerticalAlignment='bottom', Interpreter='latex')
text(0.7, walklate1D.DRX(3) - walklate1D.SD_1(3) - 5 , '(Walklate 2022)', FontSize=12, HorizontalAlignment='left', VerticalAlignment='top', Interpreter='latex')

fontsize(12, "points")

% %% Panel B - rigor fraction
% nexttile(5);
% hold on;
% lws = [0.5 1 1.5 2 4];
% ms = 5;
% for ilw = length(ageTimesSubSel):-1:1
%     plot(rigorFrac, outS.fit2_B(ageTimesSubSel(ilw), :)*100, 'kx-',LineWidth=lws(ilw), MarkerSize = ms);
% end
% hLegend = legend(strcat(string(fliplr(ageTimes(ageTimesSubSel))), " s"), Location="best");
% hLegend.Title.String = 'Incubation time'; % Set the title string
% 
% xlabel('Initial rigor fraction $A2_0$', Interpreter='latex')
% ylabel('Slow phase fraction', Interpreter='latex')
% ylim([10 55])
% 
% % Difference between max and min rigor fraction
% [100*(outS.fit2_B(:, end) - outS.fit2_B(:, 1))./outS.fit2_B(:, end) , ageTimes'/60]

% %% Panel C - label amount
% nexttile(6); 
% lws = [0.5 1 1.5 2 3 4];
% for ilw = size(outS.maxLabel, 2):-1:1
%     semilogx(ageTimes, outS.maxLabel(:, ilw)*100, 'k+-', LineWidth=lws(ilw), MarkerSize=ms);
%     hold on;   
% end
% 
% xlabel('mant-ATP incubation time (s)', Interpreter='latex');ylabel('Max $M_{tot}$ (\% of max)', Interpreter='latex')
% hLegend = legend(string(fliplr(rigorFrac)), Location="best");
% hLegend.Title.String = 'A2_{0}'; % Set the title string

add_panel_labels(["(B)", "(A)"], 0, [], [-42.5, -10]);

if exist('saveFigs') && saveFigs
    saveas(gcf, "../figures/Figure4.fig")
    saveas(gcf, "../figures/Figure4.png")
end

fontsize(12, "points")
%% plot fig 5
clear;clf;
def_aux;
saveFigs = false;

ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60.0000,  120.0000,  300.0000,  900.0000];

k_adp = [0.2154];

rigorFrac = 40;
walklate1D = getWalklateData();

filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_%dA2_40kAdp_%g.mat', firstDim, secondDim);  
outS = load_sim_results(ageTimes*1000, k_adp, filenameFun);
%% Test fit
ageTimes = [0.2, 1, 2, 5, 10, 30, 60.0000,  120.0000,  300.0000,  900.0000];

filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_%d.mat', firstDim);
outS = load_sim_results(ageTimes*1000, rigorFrac, filenameFun);

%%
cf = figure(4);clf;
aspect = 1.5;
figscale = 1.0;
cf.Position = [300 60 figscale*7.2*96 figscale*7.2*96/aspect];

tiledlayout('flow', 'TileSpacing','compact', 'Padding','compact')
lw = 1.5;
ms = 8;
nexttile();
% semilogx(fileSuffixes, slowPhase1, 's-', fileSuffixes, slowPhase2, 'd-', fileSuffixes, SRX_labelFraction, 'x-', fileSuffixes, SRX_pop, 'o-',LineWidth=1.5, MarkerSize=8);
ub_40 = find(rigorFrac == 40, 1);
if isempty(ub_40)
    ub_40 = 1:size(fit2_A, 2);
end
% semilogx(ageTimes, fit1_B(:, ub_40), 's-', ...
% without the eq1
semilogx(ageTimes, outS.fit2_B(:, ub_40)*100, 's-', Color=[1 1 1]*0, LineWidth=lw, MarkerSize=ms);
hold on;
semilogx(ageTimes, outS.SRX_pop(:, ub_40)*100, 'x-', Color=[1 1 1]*0, LineWidth=lw*2, MarkerSize=ms);
errorbar(walklate1D.AgeTime, walklate1D.SRX, walklate1D.SD, 's-', Color=[1 1 1]*0.5, LineWidth=lw*2, MarkerSize=8);
semilogx(ageTimes, outS.fit2_A(:, ub_40)*100, 's:', Color=[1 1 1]*0, LineWidth=lw, MarkerSize=ms); 
semilogx(ageTimes, outS.DRX_pop(:, ub_40)*100, 'x:', Color=[1 1 1]*0, LineWidth=lw*2, MarkerSize=ms);
errorbar(walklate1D.AgeTime, walklate1D.DRX, walklate1D.SD,'s:', Color=[1 1 1]*0.5, LineWidth=lw*2, MarkerSize=8);
ylim([0 100])
xlim([0.2, 300])
% legend('$C_{slow}$ (model)', '$P_S$ (Model)', '$C_{slow}$ (Walklate 2022)', '$C_{fast}$ (model)', '$P_{D_D}$ + $P_{D_T}$ (Model)', '$C_{fast}$ (Walklate 2022)', Location='northeast', interpreter = "latex")
xl = xlabel('mant-ATP incubation duration (s)', Interpreter='latex', HorizontalAlignment='center');
ylabel('Fraction (\%)', Interpreter='latex');
% xl.Position = xl.Position + [0 -2 0];

xticks([ageTimes]);

vd = 2;
text(2, outS.SRX_pop(4)*100 - vd, '$P_{S}$ (Model)', FontSize=12, HorizontalAlignment='left', VerticalAlignment='top', Interpreter='latex')
text(300 - 50, outS.fit2_B(10)*100, '$C_{slow}$ (model)', FontSize=12, HorizontalAlignment='right', VerticalAlignment='bottom', Interpreter='latex')
text(70, walklate1D.SRX(end), ['$C_{slow}$' newline '(Walklate 2022)'], FontSize=12, HorizontalAlignment='left', VerticalAlignment='middle', Interpreter='latex')

text(2, outS.DRX_pop(end)*100, '$P_{D_D} + P_{D_T}$ (Model)', FontSize=12, HorizontalAlignment='left', VerticalAlignment='bottom', Interpreter='latex')
text(300-50, outS.fit2_A(10)*100, '$C_{fast}$ (model)', FontSize=12, HorizontalAlignment='right', VerticalAlignment='top', Interpreter='latex')
text(70, walklate1D.DRX(end), ['$C_{fast}$' newline '(Walklate 2022)'], FontSize=12, HorizontalAlignment='left', VerticalAlignment='middle', Interpreter='latex')

fontsize(12, "points")

if exist('saveFigs') && saveFigs
    saveas(gcf, "../figures/Figure6.fig")
    saveas(gcf, "../figures/Figure6.png")
end
%% test ADPDil and identify the k_adp
clear;
def_aux;
saveFigs = false;

ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60.0000,  120.0000,  300.0000,  900.0000];

k_adp = [0.1000, 0.2154, 0.5, 1.0000, 10.0000];
% k_adp = [0.1000, 0.1143, 0.1286, 0.1429, 0.1571, 0.1714, 0.1857, 0.2000, 0.2055, 0.2111, 0.2169, 0.2228, 0.2289, 0.2352, 0.2417, 0.2483, 0.2551, 0.2621, 0.2693, 0.2766, 0.2842, 0.2920, 0.3000];

rigorFrac = 40;
walklate1D = getWalklateData();

filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_%dA2_40kAdp_%g.mat', firstDim, secondDim);  
outS = load_sim_results(ageTimes*1000, k_adp, filenameFun);

ub_40 = 1:size(outS.fit2_A, 2)
err = sum((outS.fit2_B(1:8, ub_40) - walklate1D.SRX/100).^2, 1);
err_w = sum(((outS.fit2_B(1:8, ub_40) - walklate1D.SRX/100).^2)./walklate1D.SD.^2, 1);

[~, e_min_i] = min(err); e_min_v = k_adp(e_min_i);
[~, e_min_i_w] = min(err_w); e_min_v_w = k_adp(e_min_i_w);



figure(2322);
clf;nexttile;
% semilogx(ageTimes, fit2_B(:, ub_40), 'd--', LineWidth=lw/2, MarkerSize=8/2);
% hold on;


% semilogx(ageTimes, fit2_B(:, [e_min_i, e_min_i_w]), 'd-', ...
semilogx(ageTimes, outS.fit2_B(:, e_min_i), 'd-', ...
    LineWidth=lw, MarkerSize=8);
hold on;
% plot(fileSuffixes, slowPhase1_background, '+-', LineWidth=1.5);

errorbar(walklate1D.AgeTime, walklate1D.SRX/100, walklate1D.SD/100, 's-', LineWidth=lw, MarkerSize=8);

semilogx(...
    ageTimes, outS.SRX_pop(:, e_min_i), 'x-', ...
    LineWidth=lw, MarkerSize=8);

% ylim([0 inf])
xlim([0.2, 60])
k_adp_val = k_adp(e_min_i)*100;
legend(sprintf('Slow phase eq. 2, k_{adp} = %g nM', k_adp_val), 'Data (Walklate 2022)', 'SRX population', Location='best')
xlabel('mATP incubation time (s)', Interpreter='latex');ylabel('Slow phase fraction (\%)', Interpreter='latex')
xticks([ageTimes])

% plot the population
% nexttile;
% semilogx(...
%     ageTimes, SRX_pop(:, e_min_i), 'x-', ...
%     LineWidth=lw, MarkerSize=8);
% 
% hold on;
% % plot(fileSuffixes, slowPhase1_background, '+-', LineWidth=1.5);
% errorbar(walklate1D.AgeTime, walklate1D.SRX/100, walklate1D.SD/100, 's-', LineWidth=lw, MarkerSize=8);
% ylim([0 1])
% xlim([0.2, 900])
% legend('Slow phase eq. 2', 'SRX population', 'Data (Walklate 2022)', Location='best')
% xlabel('mATP incubation time (s)', Interpreter='latex');ylabel('Slow phase fraction (\%)', Interpreter='latex')
% xticks([ageTimes])

nexttile;
plot(k_adp, err, 'x-', k_adp, err_w*10, 'o-', [e_min_v, e_min_v], [min(err), max(err)], 'k--',[e_min_v_w, e_min_v_w], [min(err), max(err)], 'k--')

%% Fit Walklate 2022 fig1A at k_ADP
figure(13);
% modelName = sprintf('mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_%d', 60*1000);
modelName = sprintf('mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP02_%d', 60*1000);
% modelName = sprintf('mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP01_900000');

% modelName = sprintf('XBCycling_Walklate_CalcADPDilHooijman');

data_src = ' (Walklate et al., ADP)';
Figure2;

%%
figure; hold on;
p2 = plot(tail(time, Lxfit), tail(getValsToPerc('integratedSquaredDeviation.u1'), Lxfit));
p1 = plot(tail(time, Lxfit), tail(getValsToPerc('integratedSquaredDeviation.u2'), Lxfit));


%%
clear;clf;
def_aux;
saveFigs = false;

ageTimes = [.2, .5, 1, 2, 5, 10, 30, 60.0000,  120.0000,  300.0000,  900.0000];

rigorFrac = 40;
walklate1D = getWalklateData();

% filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.mantADPAffinity_DoubleMix.XBCycling_Walklate_CalcADPDilAffinity_Ki01_%d.mat', firstDim);  
% outS(1) = load_sim_results(ageTimes*1000, [10], filenameFun);
% filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.mantADPAffinity_DoubleMix.XBCycling_Walklate_CalcADPDilAffinity_Ki1_%d.mat', firstDim);  
% outS(2) = load_sim_results(ageTimes*1000, [10], filenameFun);
% filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.mantADPAffinity_DoubleMix.XBCycling_Walklate_CalcADPDilAffinity_Ki10_%d.mat', firstDim);  
% outS(3) = load_sim_results(ageTimes*1000, [10], filenameFun);
% filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.mantADPAffinity_DoubleMix.XBCycling_Walklate_CalcADPDilAffinity80_Ki01_%d.mat', firstDim);  
% outS(4) = load_sim_results(ageTimes*1000, [10], filenameFun);

% filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.DataMatched.Walklate.Photobleaching.XBCycling_Walklate_PB0005_%d.mat', firstDim);  
% outS(1) = load_sim_results(ageTimes*1000, [10], filenameFun);
% filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.DataMatched.Walklate.Photobleaching.XBCycling_Walklate_PB001_%d.mat', firstDim);  
% outS(2) = load_sim_results(ageTimes*1000, [10], filenameFun);
% filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.DataMatched.Walklate.Photobleaching.XBCycling_Walklate_PB002_%d.mat', firstDim);  
% outS(3) = load_sim_results(ageTimes*1000, [10], filenameFun);


filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilMaxAffinity_Ki01_%d.mat', firstDim);  
outS(1) = load_sim_results(ageTimes*1000, [10], filenameFun);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilMaxAffinity_Ki1_%d.mat', firstDim);  
outS(2) = load_sim_results(ageTimes*1000, [10], filenameFun);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilMaxAffinity_Ki10_%d.mat', firstDim);  
outS(3) = load_sim_results(ageTimes*1000, [10], filenameFun);


%%
figure(211);clf;
outZ = outS(1);
semilogx(ageTimes, outZ.fit2_T1, ageTimes, outZ.fit2_T2);
hold on;
xlabel('incubation time (s)');ylabel('Time concstant (s)')
plot(ageTimes, [outZ.gof.rmse]*1e6);
legend('T1', 'T2', 'rmse * 1e6')

%%
% err1 = sum((outS(1).fit2_B(1:8, 1) - walklate1D.SRX/100).^2./walklate1D.SD.^2, 1)
% err2 = sum((outS(2).fit2_B(1:8, 1) - walklate1D.SRX/100).^2./walklate1D.SD.^2, 1)
% err3 = sum((outS(3).fit2_B(1:8, 1) - walklate1D.SRX/100).^2./walklate1D.SD.^2, 1)
% err4 = sum((outS(4).fit2_B(1:8, 1) - walklate1D.SRX/100).^2./walklate1D.SD.^2, 1)


% err_w = sum(((outS.fit2_B(1:8, ub_40) - walklate1D.SRX/100).^2)./walklate1D.SD.^2, 1);

% [~, e_min_i] = min(err); e_min_v = k_adp(e_min_i);
% [~, e_min_i_w] = min(err_w); e_min_v_w = k_adp(e_min_i_w);

% 
figure(232);clf;
lw = 1;
semilogx(ageTimes, outS(1).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
hold on;
semilogx(ageTimes, outS(2).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
semilogx(ageTimes, outS(3).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
% semilogx(ageTimes, outS(4).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);

set(gca,'ColorOrderIndex',1)
semilogx(ageTimes, outS(1).SRX_pop*100, 'x--', LineWidth=lw, MarkerSize=ms);
semilogx(ageTimes, outS(2).SRX_pop*100, 'x--', LineWidth=lw, MarkerSize=ms);
semilogx(ageTimes, outS(3).SRX_pop*100, 'x--', LineWidth=lw, MarkerSize=ms);

set(gca,'ColorOrderIndex',1)
semilogx(ageTimes, outS(1).SRX_popAt0*100, '+:', LineWidth=lw, MarkerSize=ms);
semilogx(ageTimes, outS(2).SRX_popAt0*100, '+:', LineWidth=lw, MarkerSize=ms);
semilogx(ageTimes, outS(3).SRX_popAt0*100, '+:', LineWidth=lw, MarkerSize=ms);

% semilogx(ageTimes, outS(4).fit2_B(:, 1)*100, 's-', LineWidth=lw, MarkerSize=ms);
xticks(ageTimes)

walklate1D = getWalklateData();
errorbar(walklate1D.AgeTime, walklate1D.SRX, walklate1D.SD, 's-', LineWidth=lw, MarkerSize=8);

legend('C_2, Ki = 0.1 uM','C_2, Ki = 1 uM','C_2, Ki = 10 uM',...
    'SRX @ 10m','SRX @ 10m','SRX @ 10m', ...
    'SRX @ 0','SRX @ 0','SRX @ 0', ...
    'Data Walklate, Fig 1D', Location='northwest');
xlabel('Incubation time');
ylabel('Fraction (%)')

%% Photobleaching incubation time sweep
figure(1);
filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_PB001_%d.mat', firstDim);
outS(1) = load_sim_results(ageTimes*1000, [10], filenameFun);

filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Figures.DefaultW_%dA2_40.mat', firstDim);
outS(2) = load_sim_results(ageTimes*1000, [10], filenameFun);

filenameFun = @(firstDim, secondDim) sprintf('../Modelica/mantATP.LabelLib.Experiments.XBCycling_Walklate_PB001_T0_%d.mat', firstDim);
outS(3) = load_sim_results(ageTimes*1000, [10], filenameFun);

figure(232);clf;
lw = 1;
semilogx(ageTimes, outS(1).fit2_B(:, 1)*100, 's-', ageTimes, outS(1).SRX_pop*100, LineWidth=lw, MarkerSize=ms);

hold on;
semilogx(ageTimes, outS(2).fit2_B(:, 1)*100, 's-', ageTimes, outS(2).SRX_pop*100, LineWidth=lw, MarkerSize=ms);
semilogx(ageTimes, outS(3).fit2_B(:, 1)*100, 's-', ageTimes, outS(3).SRX_pop*100, LineWidth=lw, MarkerSize=ms);

xticks(ageTimes)

walklate1D = getWalklateData();
errorbar(walklate1D.AgeTime, walklate1D.SRX, walklate1D.SD, 's-', LineWidth=lw, MarkerSize=8);

legend('C_2, Ki = 0.1 uM','C_2, Ki = 1 uM','C_2, Ki = 10 uM','SRX @ 10m','SRX @ 10m','SRX @ 10m', 'Data Walklate, Fig 1D', Location='northwest');
xlabel('Incubation time');
ylabel('Fraction (%)')

%% photobleaching levels
cf = figure(2);

modelName = 'DefaultW';
data_src = ' 0';
labelPosVariant = 1;
markP_S = '';
Figure2;

s = {'0', '0001', '0005', '001', '002','005'};

xax = cellfun(@(sx) str2num(['0.' sx]), s);

clear srx_pop srx_2 PB;
for i_pb = 1:length(s)
    figure(3 + i_pb);
    modelName = ['XBCycling_Walklate_PB' s{i_pb}];
    data_src = [' PB ' s{i_pb} 's-1'];
    Figure2;
    srx_2(i_pb) = fitResult2.b/(fitResult2.a+fitResult2.b)*100;
    srx_pop(i_pb) = valAt10min('SRX.pop')*100;
    PB(i_pb) = valAt10min('photobleaching')*100;
end

figure(101);clf;
bar([srx_2;srx_pop]');
set(gca, 'XTickLabel', round(100-PB));
xlabel('Photobleached at 10 mins (%)');
ylabel('SRX fraction');
legend('Eq2', 'Model', Location='best');

%% Rigor fraction levels - need to identify first

cf = figure(2);

labelPosVariant = 1;
markP_S = '';

s = {'0', '20', '40', '60', '80', '100'};

xax = cellfun(@(sx) str2num(sx), s);

clear srx_pop srx_2 PB;
for i_rig = 1:length(s)
    figure(3 + i_rig);
    modelName = ['Walklate_' s{i_rig}];
    data_src = [' A2 ' s{i_rig}];
    Figure2;
    srx_2(i_rig) = fitResult2.b/(fitResult2.a+fitResult2.b)*100;
    srx_pop(i_rig) = valAt10min('SRX.pop')*100;
end

figure(101);clf;
bar([srx_2;srx_pop]');
set(gca, 'XTickLabel', xax);
xlabel('Initial rigor fraction (%)');
ylabel('SRX fraction');
legend('Eq2', 'Model', Location='best');

%% ADP Ki - need to identify first

cf = figure(2);

labelPosVariant = 1;
markP_S = '';

s = {'0', '20', '40', '60', '80', '95'};

xax = cellfun(@(sx) str2num(sx), s);

clear srx_pop srx_2 PB;
for i_rig = 1:length(s)
    figure(3 + i_rig);
    modelName = ['mantATP.LabelLib.Figures.DefaultW_60000A2_' s{i_rig}];
    data_src = [' A2 ' s{i_rig}];
    Figure2;
    srx_2(i_rig) = fitResult2.b/(fitResult2.a+fitResult2.b)*100;
    srx_pop(i_rig) = valAt10min('SRX.pop')*100;
end

figure(101);clf;
bar([srx_2;srx_pop]');
set(gca, 'XTickLabel', xax);
xlabel('Initial rigor fraction (%)');
ylabel('SRX fraction');
legend('Eq2', 'Model', Location='best');

%% Test the individual decays

model_single = fittype('a*(exp(-t/t1)) + o', ...
                'independent', 't', ...
                'coefficients', {'a', 't1','o'});

% Set initial guesses for the parameters
opts2 = fitoptions('StartPoint', [0.5, 14, 0], 'Method', 'NonlinearLeastSquares','Lower',[0 0, -1],'Upper',[1, 1000, 1]);
% Perform the fit


time = getVals('Time');
valids = sum(time>0);
xfit = tail(time, valids);
srx = tail(getVals('SRXLabel.y'), valids);
drx = tail(getVals('DRXLabel.y'), valids);
[fitResult_srx, gof_srx] = fit(xfit, drx, model_single, opts2);

figure;
plot(xfit, drx, '-', xfit, (fitResult_srx(xfit)), '--');



function out = conditionalLabel(val)
eps = 1e-6;
    if val == 0
        out = '0';
    else
        mant = val / 10^floor(log10(val)+eps);
        expn = floor(log10(val)+eps);
        if abs(mant - 1) < eps
            out = sprintf('$10^{%d}$', expn);
        else
            out = sprintf('$%.0f\\times10^{%d}$', mant, expn);
        end
    end
end

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


function walklate1D = getWalklateData()
    % walklate1D = readtable('../data/Walklate J Biol Chem 2022 Fig 1D.csv')
    % modelvals = readtable('../ModelResults/SRX_DRX label fractions_sweep agetime.csv')
    % cf = figure(3);clf;hold on;
    
    % Save time
    walklate1D = table([0.2; 0.5; 1; 2; 5; 10; 30; 60], ...
              [27.88; 25.69; 21.84; 23.73; 18.36; 18.36; 22.27; 17.02], ...
              [7.08; 7.63; 2.44; 4.76; 2.81; 4.64; 1.04; 1.53], ...
              [72; 74.37; 78.16; 76.27; 81.57; 81.45; 77.79; 82.98], ...
              [7.14; 7.69; 2.56; 4.76; 2.81; 4.64; 1.1; 1.59], ...
              'VariableNames', {'AgeTime','SRX','SD','DRX','SD_1'});
end

function add_panel_labels(labelList, shrinkPixels, skipLabel, shift)
    % Adds panel labels (A, B, C, ...) to current figure's axes or tiles
    % labelList: optional cell array of custom labels {'A','B','C',...}
    % shrinkPixels: vertical space (in pixels) to subtract from each axis for label
    % skipLabel: logical array indicating which axes to skip labeling (but still shrink)    

    if nargin < 1 || isempty(labelList)
        labelList = arrayfun(@(x) char(64 + x), 1:26, 'UniformOutput', false); % Default: 'A', 'B', ...
    end
    if nargin < 2
        shrinkPixels = 10; % Default shrink amount in pixels
    end

    fig = gcf;
    figPos = getpixelposition(fig); % [left bottom width height] in pixels
    figHeight = figPos(4);
    figWidth = figPos(3);

    allAxes = findall(fig, 'Type', 'axes');
    % Ignore legends, colorbars etc.
    allAxes = allAxes(~arrayfun(@(a) isa(a, 'matlab.graphics.illustration.Legend') || ...
                                  strcmp(get(a, 'Tag'), 'Colorbar'), allAxes));

    % Sort axes by position (top to bottom, left to right)
    axPos = arrayfun(@(a) get(a, 'Position'), allAxes, 'UniformOutput', false);
    axPos = cat(1, axPos{:});
    [A, idx] = sortrows(axPos, [2,1]);  % Top to bottom, then left to right
    allAxes = allAxes(idx);
    labelList = labelList(idx);    
    
    if nargin < 3 || isempty(skipLabel)
         skipLabel = cellfun(@isempty, labelList);
    end

    if nargin < 4
         shift = [0, 0];
    end

    % Convert pixel height to normalized units
    shrinkNorm = shrinkPixels / figHeight;

    for i = 1:length(allAxes)
        ax = allAxes(i);
        pos = get(ax, 'Position');

        % Shrink height by fixed normalized amount
        newPos = pos;
        newPos(4) = max(pos(4) - shrinkNorm, 0); % Don't let it go negative

        set(ax, 'Position', newPos);

        if ~skipLabel(i)
            % Add label in the freed vertical space
            labelHeightNorm = shrinkPixels / figHeight;
            labelBox = [newPos(1) - 10 / figWidth + shift(1)/figWidth, newPos(2) + newPos(4) + shift(2)/figHeight, 0.03, labelHeightNorm];

            annotation('textbox', labelBox, ...
                'String', labelList{i}, ...
                'FontWeight', 'bold', ...
                'FontSize', 14, ...
                'EdgeColor', 'none', ...
                'VerticalAlignment', 'bottom', ...
                'HorizontalAlignment', 'left');
        end
    end
end
