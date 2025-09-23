%% Fit data with single and double exponential

tab = readtable("../data/Mant-ATP 8-28-25.xlsx", "Sheet","Sheet2");

% repeating row after decay
i_load = find(tab.Load == 0, 1, 'last');

tab_load = tab(1:i_load-1, :);
tab_chase = tab(i_load:end, :);

%% All
clf;
nexttile;
maxPos = table2array(tab(end, 3:end));
vals = table2array(tab(:, 3:end)./maxPos);
times = table2array(tab(:, 1));
times(i_load:end) = times(i_load-1) + times(i_load:end);
% times(i_load) = NaN;
plot(times, vals, '|-');

tab_posname = tab.Properties.VariableNames(3:end);
title('All');
%% Chase only
nexttile;
maxPos = table2array(tab_load(end, 3:end));
vals = table2array(tab_chase(:, 3:end)./maxPos);
times = table2array(tab_chase(:, 1));
plot(times, vals, '|-');

tab_posname = tab.Properties.VariableNames(3:end);
title('Chase');
legend(tab_posname)
%% fit

time_wiggle = 15;
zoom_in_data = true;

% Define the model as a sum of two exponential decays
model_single = fittype('a*0 + b*0 + c*0 + a*exp(-d*(x - x0)) + y0', ...
                'independent', 'x', ...
                'coefficients', {'a', 'b', 'c', 'd', 'x0', 'y0'});


model = fittype('a*exp(-b*(x - x0)) + (c)*exp(-d*(x-x0)) + y0', ...
                'independent', 'x', ...
                'coefficients', {'a', 'b', 'c', 'd', 'x0', 'y0'});

modelHooj = fittype('1 - a*(1 - exp(-b*(x - x0))) - c*(1 - exp(-d*(x-x0))) + y0', ...
                'independent', 'x', ...
                'coefficients', {'a', 'b', 'c', 'd', 'x0', 'y0'});

% Set initial guesses for the parameters
initialGuess = [0.5, 0.001, 0.01, 0, 0, 0]; % Adjust these based on your data

opts = fitoptions('StartPoint', initialGuess, 'Method', 'NonlinearLeastSquares','Lower',[0 0, 0, 0, -time_wiggle, 0],'Upper',[1, 1, 1, 40, time_wiggle, .5]);

num_pos = size(vals, 2);

clf;
for i_pos = 1:num_pos

    y = vals(2:end, i_pos);
    t = times(2:end);

    % Perform the fit
    [fitResult1, gof1] = fit(t, y, model_single, opts);
    
    [fitResult2, gof2] = fit(t, y, model, opts);
    fitResult2_fast = fitResult2;
    fitResult2_fast.a = 0;fitResult2_fast.b = 0;fitResult2_fast.y0 = 0;
    
    t_r = -1000:1:t(end);
    i_1 = find(fitResult2(t_r) >=1, 1, 'last');
    if ~isempty(i_1)
        t_r = t_r(i_1:end);
    end
    nexttile;
    % plot(t, y, '|-', t_r, fitResult1(t_r), '--', [t_r(1) t_r(end)], [fitResult1.y0 fitResult1.y0], ':');
    plot(t, y, '|-', t_r, fitResult1(t_r), '--', t_r, fitResult2(t_r), '-.', t_r, fitResult2_fast(t_r), ':', LineWidth=1.5);

    if zoom_in_data 
        wigg = 1.05;
        xlim([0, t(end)*wigg]);
        ylim([0, max(y)*wigg]);
    else
        ylim([0 1]);
        xlim([t_r(1), t_r(end)]);
    end
    
    title(sprintf('%s: 1expfit diff: +%.0f %%', tab_posname{i_pos}, 100*(gof1.rmse - gof2.rmse)/gof2.rmse), ...
        sprintf('x0_1e: %0.2gs, x0_2e: %0.2gs', fitResult1.x0, fitResult2.x0),... 
        Interpreter="none")
end



