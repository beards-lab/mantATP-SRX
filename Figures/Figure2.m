% Time vector
t = linspace(-5, 5, 1000);

% Generate timecourses
cf = figure(1); clf; 
tiledlayout(1, 5, 'TileSpacing','Tight')

datafile = '../Modelica/DefaultH.mat';
datafile = '../Modelica/XBCycling_Hooijman_A280.mat'
datafile = '../Modelica/XBCycling_Hooijman_A240.mat'
dl = dymload(datafile);

time_conv = 1/60;
time = dymget(dl, 'Time')*time_conv;
getVals = @(s) dymget(dl, s);
getValsToPerc = @(s) getVals(s)*100;

agetime = getVals('ageTime');
xl = [-5, 10]*60*time_conv;
% Coordinates for the marker
x_marker = -agetime(1)*time_conv;

%% Panel A
nexttile(1, [1 2]);hold on;
% Add shaded regions for phases
color_rigor = [1 1 1]*0.7;
color_incubation = [1 1 1]*0.85;
color_chase = [1 1 1];
fill([-5 -2 -2 -5], [0 0 100 100], color_rigor, 'EdgeColor', 'none', 'FaceAlpha', 1); % steady state
fill([-2 0 0 -2], [0 0 100 100], color_incubation, 'EdgeColor', 'none', 'FaceAlpha', 1);   % rise
% fill([0 5 5 0], [0 0 100 100], color_chase, 'EdgeColor', 'none', 'FaceAlpha', 1);     % decay

lw = 2.5;
p1 = plot(time, getValsToPerc('SRX.pop'), '-', 'Color', [0 0 0], LineWidth=lw, DisplayName='$P_{SRX}$');
p2 = plot(time, getValsToPerc('DRX_T.pop')*1000, ':', 'Color', [0 0 0], LineWidth=lw, DisplayName='$P_{DRX_{ATP}}$x10$^3$');
p3 = plot(time, getValsToPerc('DRX_D.pop'), '--', 'Color', [1 1 1]*0, LineWidth=lw, DisplayName='$P_{DRX_{ADP}}$');
p4 = plot(time, getValsToPerc('A2.pop'), '-', 'Color', [1 1 1]*0.5, LineWidth=lw, DisplayName='$P_{A2}$');
% plot([time(1) time(end)], max(getValsToPerc('SRX_fraction'))*[1 1], ':', LineWidth=2, DisplayName='Slow-phase')



% Add triangular markers
maxY = 99; % top y-value for markers
m1 = plot(-2, maxY, 'v', 'MarkerEdgeColor', [0.4 0.4 0.4], 'MarkerFaceColor', color_incubation, 'MarkerSize', 8,DisplayName='Incubation'); % gray triangle
m2 = plot(0, maxY, 'v', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', color_chase, 'MarkerSize', 8, DisplayName='Chase'); % black triangle


% Labels and formatting
xlim(xl);
ylim([0 100])
xlabel('Time (min)', Interpreter='latex');ylabel('Population (\%)', Interpreter='latex')

% title('Overlapping Timecourses with Phase Highlighting');
% legend(interpreter = "latex", Orientation="vertical", Location="northeast");
legend([p1 p2 p3 p4], ...
    {'$P_{SRX}$', '$P_{DRX_{ATP}}$x10$^3$', '$P_{DRX_{ADP}}$', '$P_{A2}$'}, ...
     'Location', 'northeast', Interpreter='latex');

grid on;
hold off;


%% Panel B
% nexttile(2); cla;hold on;
nexttile(3, [1 2]);cla;hold on;

fill([-5 -2 -2 -5], [0 0 100 100], color_rigor, 'EdgeColor', 'none', 'FaceAlpha', 1); % steady state
fill([-2 0 0 -2], [0 0 100 100], color_incubation, 'EdgeColor', 'none', 'FaceAlpha', 1);   % incubation
% fill([0 5 5 0], [0 0 100 100], color_chase, 'EdgeColor', 'none', 'FaceAlpha', 1);     % chase

p3 = plot(time, getValsToPerc('totalLabel.y'), '-', 'Color', [1 1 1]*0.5, LineWidth=lw*2, DisplayName='$A_{tot}$');
p1 = plot(time, getValsToPerc('SRXLabel.y'), '-', 'Color', [0 0 0], LineWidth=lw, DisplayName='$A_{SRX}$');
p2 = plot(time, getValsToPerc('DRXLabel.y'), '-.', 'Color', [0 0 0], LineWidth=lw, DisplayName='$A_{DRX}$');


xlim(xl);ylim([0, 100])

xlabel('Time (min)', Interpreter='latex');ylabel('Fluorescence (\% of max)', Interpreter='latex')

% plot([0 0], [0 max(getValsToPerc('totalLabel.y'))*1.1], 'k--', LineWidth=0.5, DisplayName="$t_0$");
legend(interpreter = "latex", Orientation="vertical", Location="northeast");

% Add triangular markers
maxY = 99; % top y-value for markers
m1 = plot(-2, maxY, 'v', 'MarkerEdgeColor', [0.4 0.4 0.4], 'MarkerFaceColor', color_incubation, 'MarkerSize', 8,DisplayName='Incubation'); % gray triangle
m2 = plot(0, maxY, 'v', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', color_chase, 'MarkerSize', 8, DisplayName='Chase'); % black triangle


% fit to ctrl from Julia and Alison
% data_control1 = [0,1; 18,0.704575;       27.994,0.628669; 37.988,0.532319; 47.982,0.519323; 57.976,       0.463446; 67.97,0.443831; 77.964,0.402628; 87.958,0.347676;       97.952,0.306668; 107.946,0.254855; 117.94,0.222877; 127.935,       0.186469; 137.929,0.190436; 147.923,0.191677; 157.917,0.158652;       167.911,0.150694; 177.905,0.135556; 187.899,0.143831; 197.893,       0.121392; 207.887,0.11779; 217.881,0.105232; 227.875,0.111073;       237.869,0.099732; 247.863,0.107471; 257.857,0.104673; 267.851,       0.090801; 277.845,0.0734; 287.839,0.09944; 297.833,0.0734;       307.827,0.08019; 317.822,0.068654; 327.816,0.072937; 337.81,       0.074179; 347.804,0.077659; 357.798,0.093332; 367.792,0.055245;       377.786,0.081747; 387.78,0.060088; 397.774,0.062521; 407.768,       0.057532; 417.762,0.066488; 427.756,0.047165; 437.75,0.076856;       447.744,0.044512; 457.738,0.042346; 467.732,0.060793; 477.726,       0.045534; 487.72,0.03816; 497.714,0.03378; 507.708,0.030129;       517.703,0.03962; 527.697,0.010416; 537.691,0.034826; 547.685,       0.028304; 557.679,0.00202; 567.673,0.034802; 577.667,0.017985;       587.661,-0.00431; 597.655,0.024556; 607.649,0.021514; 617.643,-0.00358];
% plot(data_control1(:, 1)*time_conv, data_control1(:, 2)*max(getVals('totalLabel.y'))*100, '.', MarkerSize=15, DisplayName='Data Ctrl1')
% xfit = data_control1(:, 1); yfit = data_control1(:, 2);

% fit to exp from hooijman
xfit = dymget(dl, 'Time');
Lxfit = sum(xfit >= 0);
xfit = tail(xfit, Lxfit);
yfit = tail(getValsToPerc('totalLabel.y'), Lxfit);
% scale
yma = max(yfit);
ymi = min(yfit);
yfit_minmax = (yfit-ymi)/(yma -ymi);

yfit = yfit/yma;

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
[fitResult2, gof2] = fit(xfit, yfit_minmax, model2, opts);

dataResult = feval(model1, 0.66, 0.27, 14, 144, xfit);

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

% plot(xfit/60, fitResult1(xfit)*100*scale, '-.', ...
%     xfit/60, (fitResult2(xfit))*(yma-ymi) + ymi, '--', LineWidth=2.5)
% 

p4 = plot(xfit/60, dataResult*scale*100, 'k:', LineWidth=lw*1.2, DisplayName="Fit eq. 1")

legend([p1 p2 p3 p4 m1 m2], ...
    {'$A_{SRX}$', '$A_{DRX}$', '$A_{tot}$', 'Data', ...
     'Incubation', 'Chase'}, ...
     'Location', 'northeast', Interpreter='latex');
grid on;
%% panel C
nexttile(5, [1 1]);hold on;


bar_cats = ["$A_2$ (eq. 1)", "$A_2$ (eq. 2)", "$A_{SRX}$  / $A_{tot}$", "$P_{SRX}$"];
bars = [fitResult1.b, tail(dymget(dl, 'SRX_fraction'), 1), tail(dymget(dl, 'SRX.pop'), 1)]*100;
bars = [fitResult1.b, fitResult2.b, tail(dymget(dl, 'SRX_fraction'), 1), tail(dymget(dl, 'SRX.pop'), 1)]*100;

x = categorical(bar_cats);
x = reordercats(x, bar_cats)

bar(x, bars, 'FaceColor',[1 1 1]*0.8); ylabel('SRX estimation (\%)', Interpreter='latex')
ax = gca;  ax.TickLabelInterpreter = 'latex';  
fontsize(12, 'points')
% ylim([0 100])

% Add value labels atop each bar
for i = 1:length(bars)
    text(x(i), bars(i) + 0.01, sprintf('%.0f', bars(i)), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 12);
end

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
