model_walklate = fittype('a*(exp(-t/t1)) + b*(exp(-t/t2)) + o', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2', 'o'});

model_walklate = fittype('(a*(exp(-t/t1)) + b*(exp(-t/t2)) + o)', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2', 'o'});


xfit = 0:1:1000;

a = 5.6;b = 1.6;t1 = 1/0.027;t2 = 1/0.0038; o = 99;
% dataResult = feval(model_walklate, a/(a+b)*100, b/(a+b)*100, 1/0.027, 1/0.0038, o, xfit);
dataResult = feval(model_walklate, a, b, t1, t2, o, xfit);

model1 = fittype('1 - a*(1 - exp(-t/t1)) - b*(1 - exp(-t/t2)) + o*0', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2', 'o'});



figure(101); clf; 
img_Walklate1A = imread('../data/walklate fig 1A x 0-1000 y 98 - 107.png');

imagesc([0 1000], [107 98], img_Walklate1A);
set(gca, 'YDir', 'normal');  % Correct vertical flip
hold on;

% Plot your data
plot(xfit, dataResult,'y-',  LineWidth=2.5)
plot(xfit, fitResult3(xfit), '--', LineWidth=2.5)

legend('Reported fit', 'Actual fit')

% b/(a + b)
% fitResult3.b/(fitResult3.a + fitResult3.b)

% plot(xfit, 6.2 + 100*feval(model1, a/100, b/100, t1, t2, 106.2, xfit), '--', LineWidth=2.5);

% Adjust axes
% xlim([0 1000]);
% ylim([98 107]);
ylim([-inf inf])

xlabel('X axis');
ylabel('Y axis');
title('Correctly Aligned Data over Image');
%%
tb = readtable('../data/walklate fig 1A.csv');

scatter(tb.Var1, tb.Var2)

xfit = tb.Var1;
yfit = tb.Var2;
% scale
yma = max(yfit);
ymi = min(yfit);
yfit_minmax = (yfit-ymi)/(yma -ymi);

yfit_norm = yfit/yma;

% Define the model as a sum of two exponential decays
model1 = fittype('1 - a*(1 - exp(-t/t1)) - b*(1 - exp(-t/t2))', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2'});

model2 = fittype('a*(exp(-t/t1)) + b*(exp(-t/t2)) + o', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2', 'o'});

model3 = fittype('a*(exp(-t/t1)) + b*(exp(-t/t2)) + o', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2', 'o'});

% Set initial guesses for the parameters
opts = fitoptions('StartPoint', [0.5, 0.5, 14, 140], 'Method', 'NonlinearLeastSquares','Lower',[0 0, 0, 0],'Upper',[1, 1, 100, 1000]);
opts2 = fitoptions('StartPoint', [0.5, 0.5, 14, 140, 0], 'Method', 'NonlinearLeastSquares','Lower',[0 0, 0, 0, -1],'Upper',[1, 1, 100, 1000, 1]);
opts2 = fitoptions('StartPoint', [5, 2, 30, 300, 99], 'Method', 'NonlinearLeastSquares','Lower',[0 0, 0, 0, -1],'Upper',[100, 100, 100, 1000, 100]);
% Perform the fit
[fitResult1, gof] = fit(xfit, yfit_norm, model1, opts);
[fitResult2, gof2] = fit(xfit, yfit_norm, model2, opts2);
[fitResult3, gof3] = fit(xfit, yfit, model3, opts2);

figure(102);clf;hold on;
scatter(xfit, yfit_norm);
scatter(xfit, fitResult1(xfit));
scatter(xfit, fitResult2(xfit));
scatter(xfit, fitResult3(xfit)/yma);
