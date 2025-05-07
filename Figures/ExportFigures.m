% File: make_plots.m
addpath('c:\Program Files\Dymola 2025x\Mfiles\dymtools\')

def_aux;

%% Fig result baseline A
cf = figure(1); clf; 
tiledlayout('flow', 'TileSpacing','compact')

datafile = '../CrossBridgeCycling.mantATP.LabelLib.Figures.Default.mat';
dl = dymload(datafile);

time_conv = 1/60;
time = dymget(dl, 'Time')*time_conv;
getVals = @(s) dymget(dl, s);
getValsToPerc = @(s) getVals(s)*100;

agetime = getVals('ageTime');
xl = [-180, inf]*time_conv;
% Coordinates for the marker
x_marker = -agetime(1)*time_conv;


nexttile;hold on;
plot(time, getValsToPerc('SRX.pop'), LineWidth=1, DisplayName='SRX');
plot(time, getValsToPerc('DRX_T.pop')*1000, '--', LineWidth=1, DisplayName='DRX$_{ATP}$x10$^3$');
plot(time, getValsToPerc('DRX_D.pop'), LineWidth=1, DisplayName='DRX$_{ADP}$');
plot(time, getValsToPerc('A2.pop'), LineWidth=1, DisplayName='A2');
plot([time(1) time(end)], max(getValsToPerc('SRX_fraction'))*[1 1], ':', LineWidth=2, DisplayName='Slow-phase')
legend(interpreter = "latex", Orientation="vertical", Location="northeast");
xlim(xl);
xlabel('Time (min)');ylabel('Population (%)')
placeMarker(x_marker);


nexttile; hold on;
plot(time, getValsToPerc('SRXLabel.y'), LineWidth=1, DisplayName='SRX');
plot(time, getValsToPerc('DrxLabel.y'), LineWidth=1, DisplayName='DRX');
plot(time, getValsToPerc('totalLabel.y'), LineWidth=1, DisplayName='Total');
xlim(xl);ylim([0, 80])
xlabel('Time (min)');ylabel('Fluorescence (% of max)')
plot(data_control1(:, 1)*time_conv, data_control1(:, 2)*max(getVals('totalLabel.y'))*100, '.', MarkerSize=15, DisplayName='Data Ctrl1')
plot([0 0], [0 max(getValsToPerc('totalLabel.y'))*1.1], 'k--', LineWidth=0.5, DisplayName="$t_0$");
legend(interpreter = "latex", Orientation="vertical", Location="east");
placeMarker(x_marker);

% % %

datafile = '../CrossBridgeCycling.mantATP.LabelLib.Figures.Default_ageTime.mat';
dl = dymload(datafile);

time_conv = 1/60;
time = dymget(dl, 'Time')*time_conv;
getVals = @(s) dymget(dl, s);
getValsToPerc = @(s) getVals(s)*100;

agetime = getVals('ageTime');
% Coordinates for the marker
x_marker = -agetime(1)*time_conv;


nexttile;hold on;
plot(time, getValsToPerc('SRX.pop'), LineWidth=1, DisplayName='SRX');
plot(time, getValsToPerc('DRX_T.pop')*1000, '--', LineWidth=1, DisplayName='DRX$_{ATP}$x10$^3$');
plot(time, getValsToPerc('DRX_D.pop'), LineWidth=1, DisplayName='DRX$_{ADP}$');
plot(time, getValsToPerc('A2.pop'), LineWidth=1, DisplayName='A2');
plot([time(1) time(end)], max(getValsToPerc('SRX_fraction'))*[1 1], ':', LineWidth=2, DisplayName='Slow-phase')
legend(interpreter = "latex", Orientation="vertical", Location="northeast");
xlim(xl);
xlabel('Time (min)');ylabel('Population (%)')
placeMarker(x_marker);


nexttile; hold on;
plot(time, getValsToPerc('SRXLabel.y'), LineWidth=1, DisplayName='SRX');
plot(time, getValsToPerc('DrxLabel.y'), LineWidth=1, DisplayName='DRX');
plot(time, getValsToPerc('totalLabel.y'), LineWidth=1, DisplayName='Total');
xlim(xl);ylim([0, 80])
xlabel('Time (min)');ylabel('Fluorescence (% of max)')
plot(data_control1(:, 1)*time_conv, data_control1(:, 2)*max(getVals('totalLabel.y'))*100, '.', MarkerSize=15, DisplayName='Data Ctrl1')
plot([0 0], [0 max(getValsToPerc('totalLabel.y'))*1.1], 'k--', LineWidth=0.5, DisplayName="$t_0$");
legend(interpreter = "latex", Orientation="vertical", Location="east");
placeMarker(x_marker);

fontsize(12, 'points');
if saveFigs
    saveas(cf, "Figure1.fig")
    saveas(cf, "Figure1.png")
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