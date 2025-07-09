function outputStruct = load_sim_results(ageTimes, rigorFrac, filenameFun)
    % Define the model as a sum of two exponential decays
    model1 = fittype('1 - a*(1 - exp(-t/t1)) - b*(1 - exp(-t/t2))', ...
                    'independent', 't', ...
                    'coefficients', {'a', 'b', 't1', 't2'});
    
    model2 = fittype('(a)*(exp(-t/t1)) + b*(exp(-t/t2)) + o', ...
                    'independent', 't', ...
                    'coefficients', {'a', 'b', 't1', 't2', 'o'});
    
    % Set initial guesses for the parameters
    initialGuess = [0.5, 0.5, 14, 140]; % Adjust these based on your data
    opts = fitoptions('StartPoint', initialGuess, 'Method', 'NonlinearLeastSquares','Lower',[0 0, 0, 0],'Upper',[1, 1, 100, 1000]);
    
    initialGuess = [0.05, 0.01, 14, 140, 0.9]; % Adjust these based on your data
    opts2 = fitoptions('StartPoint', initialGuess, 'Method', 'NonLinearLeastSquares', 'Lower',[0 0, 0, 0, 0],'Upper',[1, 1, 100, 1000, 1]);
    
    fit1_A = zeros(size(ageTimes'*rigorFrac));
    fit2_A = zeros(size(fit1_A));
    fit1_B = zeros(size(fit1_A));
    fit2_B = zeros(size(fit1_A));
    slowPhase1_background = zeros(size(fit1_A));
    SRX_labelFraction = zeros(size(fit1_A));
    SRX_pop = zeros(size(fit1_A));
    DRX_pop = zeros(size(fit1_A));
    maxLabel = zeros(size(fit1_A));
    SRX_popAt0 = zeros(size(fit1_A));
    
    % Loop to load each file  
    for i = 1:length(ageTimes)  
        nexttile;        hold on;    
        for j = 1:length(rigorFrac)
            filename = filenameFun(ageTimes(i), rigorFrac(j));
        
            if exist(filename, 'file')  
        
                dl = dymload(filename);
                time = dymget(dl, 'Time');
                timeSinceChase = sum(time>=0);
                ageTime = tail(dymget(dl, 'ageTime'), 1);
                timeSinceInc = sum(time>=-ageTime);
                Abscissa{i, j} = tail(time, timeSinceInc);
                time_chase = tail(time, timeSinceChase);
        
                % label = tail(dymget(dl, 'totalLabel.y'), validTime);
                label = tail(dymget(dl, 'totalLabelNorm_expr.y'), timeSinceChase);
                label_data = tail(dymget(dl, 'timeTable_ATPChase.y'), timeSinceChase);
                
                DRX_label = tail(dymget(dl, 'DRXLabel.y'), timeSinceChase);
                
                SRX_label = tail(dymget(dl, 'SRXLabel.y'), timeSinceChase);
                
                
                Mtot{i, j} = tail(dymget(dl, 'totalLabel.y'), timeSinceInc);
        
                SRX_labelFraction(i, j) = tail(dymget(dl, 'SRX_fraction'), 1);
                SRX_pop(i, j) = tail(dymget(dl, 'SRX.pop'), 1);
                SRX_popAt0(i, j) = head(tail(dymget(dl, 'SRX.pop'), timeSinceChase), 1);
                DRX_pop(i, j) = tail(dymget(dl, 'DRX_D.pop'), 1) + tail(dymget(dl, 'DRX_T.pop'), 1);
                maxLabel(i, j) = tail(dymget(dl, 'normFactor'), 1);
                
                % scale = max(label);
                % bckg = scale*0.05;
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
                [fitResult1, gof1] = fit(time_chase, yfit_norMax, model1, opts);
                % [fitResult2, gof2] = fit(time, yfit_norMinMax, model2, opts2);
                [fitResult2, gof2] = fit(time_chase, label, model2, opts2);
                gof(i, j) = gof2;

                % [fitResult_GT, gof2] = fit(time_chase, label_data, model2, opts2);
                % [fitResultWBckg, gof2_5] = fit(time, labelWBckg, model1, opts);
                %% fit state labels separately
                % opts_single = opts;
                % opts_single.TolFun = 1e-9;
                % opts_single.Upper = [1 0 400 1000];
                % opts_single.StartPoint = [0.5 0 5 100];
                % [fitResult_singleDrx, gof3] = fit(time, DRX_label, model2, opts_single);
                % opts_single.StartPoint = [0.5 0 150 100];
                % [fitResult_singleSrx, gof4] = fit(time, SRX_label, model2, opts_single);
        
                % plot(time_chase, yfit_norMax, '-', time_chase, fitResult1(time_chase), '--', time_chase, label, '-', time_chase, fitResult2(time_chase), ':', LineWidth=2); 
                % plot(time_chase, label, '-', time_chase, label_data, ':', LineWidth=2); 
                plot(time_chase, label, '-', time_chase, fitResult2(time_chase), ':', LineWidth=2); 
                % plot(time, label, '-', LineWidth=1.5);
                % plot(time, DRX_label, '-', time, fitResult_singleDrx(time), '--', time, SRX_label, '-', time, fitResult_singleSrx(time),'--', LineWidth=1.5);
                % plot(time, labelWBckg, '-', time,fitResultWBckg(time), '--',  LineWidth=1.5);
                % title(sprintf("Incubation %g s", ageTimes(i))); 
        
                
                fit1_A(i, j) = fitResult1.a;
                fit1_B(i, j) = fitResult1.b;
                fit1_T1(i, j) = fitResult1.t1;
                fit1_T2(i, j) = fitResult1.t2;
        
                % fit2_A(i, j) = fitResult2.a;
                fit2_A(i, j) = fitResult2.a/(fitResult2.a + fitResult2.b);
                fit2_B(i, j) = fitResult2.b/(fitResult2.a + fitResult2.b);
                fit2_T1(i, j) = fitResult2.t1;
                fit2_T2(i, j) = fitResult2.t2;
                
                % slowPhase1_background(i, j) = fitResultWBckg.b;
        
            else  
                warning('File %s not found!', filename);  
                fit1_A(i, j) = NaN;
                fit1_B(i, j) = NaN;
                fit1_T1(i, j) = NaN;
                fit1_T2(i, j) = NaN;
        
                fit2_A(i, j) = NaN;
                fit2_B(i, j) = NaN;
                fit2_T1(i, j) = NaN;
                fit2_T2(i, j) = NaN;
            end
        end
    end
    outputStruct.Time = Abscissa;
    outputStruct.Mtot = Mtot;
    outputStruct.fit1_A = fit1_A;
    outputStruct.fit2_A = fit2_A;
    outputStruct.fit1_B = fit1_B;
    outputStruct.fit2_B = fit2_B;
    outputStruct.slowPhase1_background = slowPhase1_background;
    outputStruct.SRX_labelFraction = SRX_labelFraction;
    outputStruct.SRX_pop = SRX_pop;
    outputStruct.DRX_pop = DRX_pop;
    outputStruct.maxLabel = maxLabel;
    outputStruct.SRX_popAt0 = SRX_popAt0;
    outputStruct.gof = gof;
    outputStruct.fit2_T1 = fit2_T1;
    outputStruct.fit2_T2 = fit2_T2;

end