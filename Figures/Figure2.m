% Time vector
% t = linspace(-5, 5, 1000);

% Generate timecourses
% cf = figure(); clf; 
cf = gcf; clf;
aspect = 1.2;
figscale = 1.0;
cf.Position = [300 60 figscale*7.2*96 figscale*7.2*96/aspect];

tiledlayout(1, 5, 'TileSpacing','compact', 'Padding', 'compact')

if exist('modelName', 'var')
    datafile = ['../Modelica/' modelName '.mat'];
else
    % default for figure2
    datafile = '../Modelica/DefaultH.mat';
end

% datafile = '../Modelica/DefaultH.mat';
% datafile = '../Modelica/XBCycling_Hooijman_A280.mat'
% datafile = '../Modelica/XBCycling_Hooijman_A240.mat'
% datafile = '../Modelica/DefaultW.mat';
% datafile = '../Modelica/mantATP.LabelLib.Figures.DefaultW_60000A2_40.mat';


dl = dymload(datafile);

time_conv = 1/60;
time = dymget(dl, 'Time')*time_conv;
getVals = @(s) dymget(dl, s);
getVal = @(s) tail(getVals(s), 1);
getValsToPerc = @(s) getVals(s)*100;

agetime = getVals('ageTime');
xl = [-3, 10]*60*time_conv;
% Coordinates for the marker
x_marker = -agetime(1)*time_conv;

%% pre-allocate axes
% cf = clf;
tiledlayout(2, 2, 'TileSpacing','compact', 'Padding', 'compact')

% Step 1: Create flow layout and 3 panels
p1 = nexttile(1, [1 1]);
xlabel("Placeholder", Interpreter="latex");ylabel("placeholder", Interpreter="latex");
p2 = nexttile(2, [1 1]);
xlabel("Placeholder", Interpreter="latex");ylabel("placeholder", Interpreter="latex");
p3 = nexttile(3, [1 1]);
xlabel("Placeholder", Interpreter="latex");ylabel("placeholder", Interpreter="latex");
p4 = nexttile(4, [1 1]);
xlabel("Placeholder", Interpreter="latex");ylabel("placeholder", Interpreter="latex");

fontsize(12, "points");


% Step 2: Grab their positions (in pixels, relative to figure)
vspc = 0.03;
pos1 = p1.Position + [0 0 0 -vspc];
pos2 = p2.Position + [0 0 0 -vspc];
pos3 = p3.Position + [0 vspc 0 -vspc];
pos4 = p4.Position  +[0 vspc 0 -vspc];;

% clear;
clf;

% Step 4: Recreate using axes with stored positions
ax1 = axes(cf, 'Position', pos1);
% title(ax1, 'Axes 1');

ax2 = axes(cf, 'Position', pos2);
% title(ax2, 'Axes 2');

ax3 = axes(cf, 'Position', pos3);
% title(ax3, 'Axes 3');

ax4 = axes(cf, 'Position', pos4);
% title(ax3, 'Axes 3');



%% Panel A
% nexttile(1, [1 2]);hold on;
axes(ax1);cla;hold on;
ax1.TickLabelInterpreter = 'latex';

% Add shaded regions for phases
color_rigor = [1 1 1]*0.7;
color_incubation = [1 1 1]*0.85;
color_chase = [1 1 1];
fill([xl(1) x_marker x_marker xl(1)], [0 0 100 100], color_rigor, 'EdgeColor', 'none', 'FaceAlpha', 1); % steady state
fill([x_marker 0 0 x_marker], [0 0 100 100], color_incubation, 'EdgeColor', 'none', 'FaceAlpha', 1);   % rise
% fill([0 5 5 0], [0 0 100 100], color_chase, 'EdgeColor', 'none', 'FaceAlpha', 1);     % decay

rng = time > xl(1) & time < 10;
clip = @(A) A(rng);

lw = 2.5;
p1 = plot(clip(time), clip(getValsToPerc('SRXpop')), '-', 'Color', [0 0 0], LineWidth=lw, DisplayName='$P_{SRX}$');
p2 = plot(clip(time), clip(getValsToPerc('DRX_T.pop'))*1000, ':', 'Color', [0 0 0], LineWidth=lw, DisplayName='$P_{DRX_{ATP}}$x10$^3$');
p3 = plot(clip(time), clip(getValsToPerc('DRX_D.pop')), '--', 'Color', [1 1 1]*0, LineWidth=lw, DisplayName='$P_{DRX_{ADP}}$');
p4 = plot(clip(time), clip(getValsToPerc('A2.pop')), '-', 'Color', [1 1 1]*0.5, LineWidth=lw, DisplayName='$P_{A2}$');
% plot([time(1) time(end)], max(getValsToPerc('SRX_fraction'))*[1 1], ':', LineWidth=2, DisplayName='Slow-phase')



% Add triangular markers
% maxY = 99; % top y-value for markers
% m1 = plot(x_marker, maxY, 'v', 'MarkerEdgeColor', [0.4 0.4 0.4], 'MarkerFaceColor', color_incubation, 'MarkerSize', 8,DisplayName='Incubation'); % gray triangle
% m2 = plot(0, maxY, 'v', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', color_chase, 'MarkerSize', 8, DisplayName='Chase'); % black triangle


% Labels and formatting
xlim(xl);
ylim([0 100])
xlabel('$t$ (min)', Interpreter='latex');ylabel('Population (\%)', Interpreter='latex')

% title('Overlapping Timecourses with Phase Highlighting');
% legend(interpreter = "latex", Orientation="vertical", Location="northeast");
% legend([p1 p2 p3 p4], ...
%     {'$P_{SRX}$', '$P_{DRX_{ATP}}$x10$^3$', '$P_{DRX_{ADP}}$', '$P_{A2}$'}, ...
%      'Location', 'northeast', Interpreter='latex');

% grid on;
% hold off;

vd = 2;
hd = 0.5;
r = 15;
text((-4 + x_marker)/2, 103, 'Rigor', FontSize=12, Rotation=r, Interpreter='latex')
text(x_marker/2, 103, 'Incubation', FontSize=12, Rotation=r, Interpreter='latex')
text(4, 103, 'Chase', FontSize=12, Rotation=r, Interpreter='latex')

if labelPosVariant == 1
    text(10 - hd, tail(getValsToPerc('SRXpop'), 1) - vd, '$P_{S}$', FontSize=12, HorizontalAlignment='right', VerticalAlignment='top', Interpreter='latex')
    text(10 - hd, tail(getValsToPerc('DRX_T.pop'), 1)*1000 - vd, '$P_{D_{T}}$x10$^3$', FontSize=12, HorizontalAlignment='right', VerticalAlignment='top', Interpreter='latex')
    text(10 - hd, tail(getValsToPerc('DRX_D.pop'), 1) + vd, '$P_{D_{D}}$', FontSize=12, HorizontalAlignment='right', VerticalAlignment='bottom', Interpreter='latex')
    text(5 - hd, tail(getValsToPerc('A2.pop'), 1) + vd, '$P_{A2}$', FontSize=12, HorizontalAlignment='right', VerticalAlignment='bottom', Interpreter='latex')
elseif labelPosVariant == 2
    text(10 - hd, tail(getValsToPerc('SRXpop'), 1) + 2*vd, '$P_{S}$', FontSize=12, HorizontalAlignment='right', VerticalAlignment='bottom', Interpreter='latex')
    text(10 - hd, tail(getValsToPerc('DRX_T.pop'), 1)*1000 + vd, '$P_{D_{T}}$x10$^3$', FontSize=12, HorizontalAlignment='right', VerticalAlignment='bottom', Interpreter='latex')
    text(10 - hd, tail(getValsToPerc('DRX_D.pop'), 1) + vd, '$P_{D_{D}}$', FontSize=12, HorizontalAlignment='right', VerticalAlignment='top', Interpreter='latex')
    text(5 - hd, tail(getValsToPerc('A2.pop'), 1) + vd, '$P_{A2}$', FontSize=12, HorizontalAlignment='right', VerticalAlignment='bottom', Interpreter='latex')
end

% quiver(x_marker, 95, 0 - x_marker, 0, 'Color', 'k', 'LineWidth', 3, 'MaxHeadSize', 4);
% quiver(0, 95, x_marker, 0, 'Color', 'k', 'LineWidth', 3, 'MaxHeadSize', 4);

% quiver(0, 95, 10, 0, 0.9, 'Color', 'k', 'LineWidth', 3, 'MaxHeadSize', 1);
% quiver(10, 95, -10, 0, 1, 'Color', 'k', 'LineWidth', 3, 'MaxHeadSize', 1);

% box on;
ax = gca; xl = ax.XLim;        yl = ax.YLim;

% Define box corners
x = [xl(1) xl(2) xl(2) xl(1) xl(1)]; y = [yl(1) yl(1) yl(2) yl(2) yl(1)];

% Draw box using line
line(x, y, 'Color', 'k', 'LineWidth', 0.25);
%% Panel B
% nexttile(2); cla;hold on;
% nexttile(3, [1 2]);cla;hold on;
axes(ax2);cla;hold on;
ax2.TickLabelInterpreter = 'latex';
text((-4 + x_marker)/2, 103, 'Rigor', FontSize=12, Rotation=r, Interpreter='latex')
text(x_marker/2, 103, 'Incubation', FontSize=12, Rotation=r, Interpreter='latex')
text(4, 103, 'Chase', FontSize=12, Rotation=r, Interpreter='latex')


fill([xl(1) x_marker x_marker xl(1)], [0 0 100 100], color_rigor, 'EdgeColor', 'none', 'FaceAlpha', 1); % steady state
fill([x_marker 0 0 x_marker], [0 0 100 100], color_incubation, 'EdgeColor', 'none', 'FaceAlpha', 1);   % incubation
% fill([0 5 5 0], [0 0 100 100], color_chase, 'EdgeColor', 'none', 'FaceAlpha', 1);     % chase

if exist('plotPhotobleaching', 'var') && plotPhotobleaching
    p1 = plot(time, getValsToPerc('SRXLabel.y'), ':', 'Color', [1 1 1]*0.5, LineWidth=lw, DisplayName='$M_{SRX}$');
    p2 = plot(time, getValsToPerc('DRXLabel.y'), '-.', 'Color', [1 1 1]*0.5, LineWidth=lw, DisplayName='$M_{DRX}$');
    p3 = plot(time, getValsToPerc('totalLabel.y'), '-', 'Color', [1 1 1]*0.5, LineWidth=lw, DisplayName='$M_{tot}$');
    p4 = plot(time, getValsToPerc('totalLabel_PB'), '-', 'Color', [1 1 1]*0, LineWidth=lw, DisplayName='$\hat{M}_{tot}$');
    legend(interpreter = "latex", Orientation="vertical", Location="northeast", AutoUpdate='off');
    legend([p1 p2 p3 p4], ...
    {'$M_{S}$', '$M_{D}$', '$M_{tot}$', '$\hat{M}_{tot}$'}, ...
     'Location', 'northeast', Interpreter='latex');
else
    p1 = plot(time, getValsToPerc('SRXLabel.y'), ':', 'Color', [1 1 1]*0, LineWidth=lw, DisplayName='$M_{SRX}$');
    p2 = plot(time, getValsToPerc('DRXLabel.y'), '-.', 'Color', [1 1 1]*0, LineWidth=lw, DisplayName='$M_{DRX}$');
    p3 = plot(time, getValsToPerc('totalLabel.y'), '-', 'Color', [1 1 1]*0, LineWidth=lw, DisplayName='$M_{tot}$');
    legend(interpreter = "latex", Orientation="vertical", Location="northeast", AutoUpdate='off');
    legend([p1 p2 p3], ...
    {'$M_{S}$', '$M_{D}$', '$M_{tot}$'}, ...
     'Location', 'northeast', Interpreter='latex');
end

xlim(xl);ylim([0, 100])

xlabel('$t$ (min)', Interpreter='latex');ylabel('Fluorescence (\%)', Interpreter='latex')

% plot([0 0], [0 max(getValsToPerc('totalLabel.y'))*1.1], 'k--', LineWidth=0.5, DisplayName="$t_0$");
legend(interpreter = "latex", Orientation="vertical", Location="northeast", AutoUpdate='off');

% Add triangular markers
maxY = 99; % top y-value for markers
% m1 = plot(x_marker, maxY, 'v', 'MarkerEdgeColor', [0.4 0.4 0.4], 'MarkerFaceColor', color_incubation, 'MarkerSize', 8,DisplayName='Incubation'); % gray triangle
% m2 = plot(0, maxY, 'v', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', color_chase, 'MarkerSize', 8, DisplayName='Chase'); % black triangle


% fit to ctrl from Julia and Alison
% data_control1 = [0,1; 18,0.704575;       27.994,0.628669; 37.988,0.532319; 47.982,0.519323; 57.976,       0.463446; 67.97,0.443831; 77.964,0.402628; 87.958,0.347676;       97.952,0.306668; 107.946,0.254855; 117.94,0.222877; 127.935,       0.186469; 137.929,0.190436; 147.923,0.191677; 157.917,0.158652;       167.911,0.150694; 177.905,0.135556; 187.899,0.143831; 197.893,       0.121392; 207.887,0.11779; 217.881,0.105232; 227.875,0.111073;       237.869,0.099732; 247.863,0.107471; 257.857,0.104673; 267.851,       0.090801; 277.845,0.0734; 287.839,0.09944; 297.833,0.0734;       307.827,0.08019; 317.822,0.068654; 327.816,0.072937; 337.81,       0.074179; 347.804,0.077659; 357.798,0.093332; 367.792,0.055245;       377.786,0.081747; 387.78,0.060088; 397.774,0.062521; 407.768,       0.057532; 417.762,0.066488; 427.756,0.047165; 437.75,0.076856;       447.744,0.044512; 457.738,0.042346; 467.732,0.060793; 477.726,       0.045534; 487.72,0.03816; 497.714,0.03378; 507.708,0.030129;       517.703,0.03962; 527.697,0.010416; 537.691,0.034826; 547.685,       0.028304; 557.679,0.00202; 567.673,0.034802; 577.667,0.017985;       587.661,-0.00431; 597.655,0.024556; 607.649,0.021514; 617.643,-0.00358];
% plot(data_control1(:, 1)*time_conv, data_control1(:, 2)*max(getVals('totalLabel.y'))*100, '.', MarkerSize=15, DisplayName='Data Ctrl1')
% xfit = data_control1(:, 1); yfit = data_control1(:, 2);

% fit to exp from hooijman
xfit = dymget(dl, 'Time');
Lxfit = sum(xfit > 1e-3);
xfit = tail(xfit, Lxfit);
yfit = tail(getVals('totalLabel.y'), Lxfit);
label = tail(getVals('totalLabelNorm_expr.y'), Lxfit);

% scale
yma = max(yfit);
ymi = min(yfit);
yfit_minmax = (yfit-ymi)/(yma -ymi);

yfit = yfit/yma;

% Define the model as a sum of two exponential decays
model1 = fittype('1 - a*(1 - exp(-t/t1)) - b*(1 - exp(-t/t2)) + o', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2', 'o'});

model2 = fittype('a*(exp(-t/t1)) + b*(exp(-t/t2)) + o', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2', 'o'});

% Set initial guesses for the parameters
opts = fitoptions('StartPoint', [0.5, 0.5, 14, 140, 0], 'Method', 'NonlinearLeastSquares','Lower',[0 0, 0, 0, 0],'Upper',[1, 1, 100, 1000, 100]);
opts2 = fitoptions('StartPoint', [0.5, 0.5, 14, 140, 0], 'Method', 'NonlinearLeastSquares','Lower',[0 0, 0, 0, -1],'Upper',[1, 1, 100, 1000, 1]);
% Perform the fit
[fitResult1, gof] = fit(xfit, yfit, model1, opts);
[fitResult2, gof2] = fit(xfit, tail(label, Lxfit), model2, opts2);
[fitResult3, gof3] = fit(xfit, tail(getVals('timeTable_ATPChase.y'), Lxfit), model2, opts2);
% [fitResult4, gof4] = fit(xfit, tail(getVals('totalLabelNorm'), Lxfit), model2, opts2);

dataResult = feval(model1, 0.66, 0.27, 14, 144, 0, xfit);

scale = max(dymget(dl, 'totalLabel.y'));

% data
% plot(xfit/60, yfit*100*scale, 'd', ...
%     xfit/60, fitResult1(xfit)*100*scale, '--', ...
%     xfit/60, fitResult2(xfit)*100*scale, '--', LineWidth=1.5)
% timecourse both
% plot(xfit/60, fitResult1(xfit)*100*scale, '--', ...
%     xfit/60, fitResult2(xfit)*100*scale, '--', LineWidth=1.5)
% timecourse only model 1 - they are the same
% p4 = plot([0 ; xfit]/60, fitResult1([0 ; xfit])*100*scale, 'k:', LineWidth=lw*1.2, DisplayName="Fit eq. 1")
% just the fits
% plot(xfit/60, fitResult1(xfit)*100*scale, '-.', ...
%     xfit/60, (fitResult2(xfit))*(yma-ymi) + ymi, '--', LineWidth=2.5)
% 

% p4 = plot(xfit/60, dataResult*scale*100, 'k:', LineWidth=lw*1.2, DisplayName="Fit eq. 1")
tails = sum(time>0);
% p4 = plot(tail(time, tails), tail(getValsToPerc('timeTable_ATPChase.y'), tails)*getVal('normFactor'), 'k:', LineWidth=lw*1.2, DisplayName="Fit eq. 1");


% l.Position = l.Position + [0.03 0 0 0];
% box on;
ax = gca; xl = ax.XLim;        yl = ax.YLim;

% Define box corners
x = [xl(1) xl(2) xl(2) xl(1) xl(1)]; y = [yl(1) yl(1) yl(2) yl(2) yl(1)];

% Draw box using line
line(x, y, 'Color', 'k', 'LineWidth', 0.25);

%% panel D
axes(ax4);cla;hold on;
set(ax4, 'Clipping', 'on')
ax4.TickLabelInterpreter = 'latex';
% figure(222);clf; hold on;
lw = 2.5;
% p2 = plot(xfit/60, fitResult2(xfit)*100,'-', 'Color', [1 1 1]*0.5, LineWidth=lw*4, DisplayName='$M_{tot}$');
p2 = plot(tail(time, Lxfit), tail(getValsToPerc('timeTable_ATPChase.y'), Lxfit),'-', 'Color', [1 1 1]*0.5, LineWidth=10);
p1 = plot(tail(time, Lxfit), tail(getValsToPerc('totalLabelNorm'), Lxfit),  'k-',LineWidth=lw);
% plot(xfit*time_conv, fitResult2(xfit)*100);
% plot(xfit*time_conv, fitResult3(xfit)*100);
% plot(xfit*time_conv, fitResult4(xfit)*100);
% legend('Walklate et al., Fig 1A', '$I_{sim}$', interpreter='latex' )

xlabel('$t$ (min)', Interpreter='latex');ylabel('Fluorescence (\%)', Interpreter='latex')

xlim([0 10])

if ~exist('data_src', 'var')
    error("DATA, INFORMATION MISSING! gIVE mE sOME 'data_src' pls");
end

l = legend([p1 p2], ...
    {'$I_{sim}$', ['$I_{obs}$'  data_src]}, ...
     'Location', 'northeast', Interpreter='latex');

box on;
%% panel C
% nexttile(5, [1 1]);hold on;
axes(ax3);cla;hold on;
ax3.TickLabelInterpreter = 'latex';

iAt10min = find(time >= 10, 1);
valAt10min = @(str) tail(head(dymget(dl, str), iAt10min), 1);

% bars = [fitResult1.b, tail(dymget(dl, 'SRX_fraction'), 1), tail(dymget(dl, 'SRX.pop'), 1)]*100;
% bars = [fitResult1.b, fitResult2.b, valAt10min('SRX_fraction'), valAt10min('SRX.pop')]*100;

% bar_cats = ["$C_2$ (Eq. 1)","$SRX_1$ (Eq. 1)", "$SRX_2$ (Eq. 2)", "Data, Eq. 2", "$M_{S}$  / $M_{tot}$", "$P_{S}$"];
% bars = [fitResult1.b, fitResult1.b/(fitResult1.b + fitResult1.a), fitResult2.b/(fitResult2.a+fitResult2.b), fitResult3.b/(fitResult3.a + fitResult3.b), valAt10min('SRX_fraction'), valAt10min('SRX.pop')]*100;

bar_cats = ["$SRX_C$ (Eq. 1)", "$SRX_C$ (Eq. 2)", "$P_{S}$"];
bar_cats = ["Eq. (1)", "Eq. (2)", "$P_{S}$"];
bars = [fitResult1.b, fitResult2.b/(fitResult2.a+fitResult2.b), valAt10min('SRXpop')]*100;

x = categorical(bar_cats);
x = reordercats(x, bar_cats);

bar(x, bars, 'FaceColor',[1 1 1]*0.8); ylabel('SRX estimation (\%)', Interpreter='latex')
ax = gca;  ax.TickLabelInterpreter = 'latex';  
fontsize(12, 'points')

ylim([0 10*ceil(max(bars+3)/10)])

% Add value labels atop each bar
for i = 1:length(bars)
    if i == length(bars) && exist('markP_S') && ~isempty(markP_S)
        addon = markP_S;
    else
        addon = '';
    end
    text(x(i), bars(i) + 0.01, sprintf('%.0f%s', bars(i), addon), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 12);
end

box on;
%% set 12 pts size

fontsize(12, 'points');


% Function to generate timecourse
function y = generate_timecourse(t, start_val, amp, decay_rate, rise_rate)
    y = ones(size(t)) * start_val;

    % Rise phase
    rise_idx = (t >= -2) & (t <= 0);
    y(rise_idx) = start_val + rise_rate * (t(rise_idx) + 2);

    % Decay phase
    decay_idx = t > 0;
    y(decay_idx) = amp * exp(-decay_rate * t(decay_idx));
end
