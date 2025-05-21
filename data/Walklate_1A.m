model_walklate = fittype('a*(exp(-t/t1)) + b*(exp(-t/t2))', ...
                'independent', 't', ...
                'coefficients', {'a', 'b', 't1', 't2'});

xfit = 0:1:1000;

dataResult = feval(model_walklate, 5.6, 1.6, 1/0.027, 1/0.0038, xfit);

figure(101); clf; 
img_Walklate1A = imread('../data/walklate fig 1A x 0-1000 y 98 - 107.png');

imagesc([0 1000], [107 98], img_Walklate1A);
set(gca, 'YDir', 'normal');  % Correct vertical flip
hold on;

% Plot your data
plot(xfit, dataResult + 99, LineWidth=2.5)

% Adjust axes
xlim([0 1000]);
ylim([98 107]);

xlabel('X axis');
ylabel('Y axis');
title('Correctly Aligned Data over Image');
