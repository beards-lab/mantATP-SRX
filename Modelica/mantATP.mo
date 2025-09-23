within ;
package mantATP
  package Obsolete
    extends Modelica.Icons.Package;
    extends Modelica.Icons.ObsoleteModel;

    model TestXB
      extends Modelica.Icons.Example;
      parameter Real k=0.016666666666666666;
      Bodylight.Population.LabeledPopulation.Components.StateCompartment
        SRX(pop_start(displayUnit="mol"), nPorts=2)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment
        DRX_T(pop_start(displayUnit="mol") = 1 - A2.pop_start, nPorts=4)
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment
        DRX_D(pop_start(displayUnit="mol"), nPorts=2)
        annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition
        k_srx_m(k=0.23295219*k) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,10})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition
        k_srx_p(k=12.128469*k) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-20,10})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH(
          k=k*100)
        annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition
        kH_m(
        k=k*1.1060009,
        useDynamicFlowLabeling=true,
        labelIn=time > -ageTime and time < 0,
        labelOut=time > 0) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={2,-36})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment A2(
         pop_start(displayUnit="mol") = 0.04, nPorts=0) "Attached state"
        annotation (Placement(transformation(extent={{60,40},{40,60}})));
      parameter Modelica.Units.SI.Time ageTime=60;
      Modelica.Blocks.Sources.RealExpression totalLabel(y=SRX.labelAmount + DRX_D.labelAmount
             + DRX_T.labelAmount + A2.labelAmount)
        annotation (Placement(transformation(extent={{-96,78},{-76,98}})));
      Modelica.Blocks.Sources.RealExpression SRXLabel(y=SRX.labelAmount)
        annotation (Placement(transformation(extent={{-96,58},{-76,78}})));
      Modelica.Blocks.Sources.RealExpression DrxLabel(y=DRX_D.labelAmount + DRX_T.labelAmount)
        annotation (Placement(transformation(extent={{-96,38},{-76,58}})));
      Real totalLabelNorm "Label normalized to chase onset";
        Real normFactor(start = 1);
        Real SRX_fraction(start = 0);
    equation
      if time > 0 then
        totalLabelNorm = totalLabel.y/normFactor;
      else
        totalLabelNorm = 1;
      end if;

      when time > 0 then
        normFactor = totalLabel.y;
        SRX_fraction = SRXLabel.y / totalLabel.y;
      end when;

      connect(SRX.lpop[1], k_srx_m.lpop_a) annotation (Line(
          points={{-40.2,40.15},{-30,40.15},{-30,20}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m.lpop_b, DRX_T.lpop[1]) annotation (Line(
          points={{-30,0},{-30,-39.975},{-40.2,-39.975}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_b, SRX.lpop[2]) annotation (Line(
          points={{-20,20},{-20,40},{-40.2,40},{-40.2,40.65}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_a, DRX_T.lpop[2]) annotation (Line(
          points={{-20,0},{-20,-12},{-30,-12},{-30,-39.725},{-40.2,-39.725}},
          color={107,45,134},
          thickness=1));
      connect(DRX_T.lpop[3], kH.lpop_a) annotation (Line(
          points={{-40.2,-39.475},{-40.2,-40},{-20,-40},{-20,-46},{-8,-46}},
          color={107,45,134},
          thickness=1));
      connect(kH.lpop_b, DRX_D.lpop[1]) annotation (Line(
          points={{12,-46},{24,-46},{24,-39.85},{40.2,-39.85}},
          color={107,45,134},
          thickness=1));
      connect(kH_m.lpop_b, DRX_T.lpop[4]) annotation (Line(
          points={{-8,-36},{-20,-36},{-20,-39.225},{-40.2,-39.225}},
          color={107,45,134},
          thickness=1));
      connect(kH_m.lpop_a, DRX_D.lpop[2]) annotation (Line(
          points={{12,-36},{24,-36},{24,-39.35},{40.2,-39.35}},
          color={107,45,134},
          thickness=1));
      annotation (experiment(
          StartTime=-620,
          StopTime=600,
          __Dymola_Algorithm="Dassl"));
    end TestXB;

    model TestXB_Ctrl1
      extends Obsolete.TestXB(
        kH(k=100),
        k_srx_m(k=0.23295219*tune_a),
        k_srx_p(k=12.128469*tune_b),
        kH_m(k=1.1060009*tune_c),
        ageTime=600.0);
      Data.TimeTable_ATPChaseControl1 timeTable_ATPChaseControl1
        annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
      Optimization.Criteria.Signals.IntegratedSquaredDeviation
        integratedSquaredDeviation
        annotation (Placement(transformation(extent={{-6,92},{2,84}})));
      Modelica.Blocks.Sources.RealExpression totalLabelNorm_expr(y=if time > 0
             then totalLabelNorm else 0)
        annotation (Placement(transformation(extent={{-40,72},{-20,92}})));
        parameter Real tune_a = 1, tune_b = 1, tune_c = 1;
    equation
      connect(integratedSquaredDeviation.u1, totalLabelNorm_expr.y) annotation (
          Line(points={{-6.8,85.6},{-19,85.6},{-19,82}}, color={0,0,127}));
      connect(timeTable_ATPChaseControl1.y, integratedSquaredDeviation.u2)
        annotation (Line(points={{-39,90},{-38,90.4},{-6.8,90.4}}, color={0,0,127}));
    end TestXB_Ctrl1;

    model TestXB_Ctrl1_reparam
      "Optimized model parameters of CrossBridgeCycling.mantATP.LabelLib.TestXB_Ctrl1"
      extends mantATP.Obsolete.TestXB_Ctrl1(
        tune_a=1,
        tune_b=1,
        tune_c=1,
        kH_m(k=0.066*tune_c),
        k_srx_m(k=0.014*tune_a),
        k_srx_p(k=48.5*tune_b),
        ageTime=60.0,
        kH(k=80.0));

      /* Automatically generated at Mon Mar 17 18:44:15 2025 */
      /*
    The final optimization result was as follows:
    
    Evaluation #29
        0.5864876635150932        min    integratedSquaredDeviation.y1
    __________________________________________________
        0.5864876635150932       Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="CrossBridgeCycling.mantATP.LabelLib.TestXB_Ctrl1",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=1,
                                min=1e-2,
                                max=100,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=1,
                                min=1e-2,
                                max=100,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=1,
                                min=1e-2,
                                max=100,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="integratedSquaredDeviation.y1",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.sqp,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=1e-3,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-600,
                            stopTime=600,
                            outputInterval=0,
                            numberOfIntervals=5000,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Dassl,
                            integrationTolerance=1e-3,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
      annotation (Documentation(info=
              "<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"),
          experiment(
          StartTime=-600,
          StopTime=618,
          __Dymola_Algorithm="Dassl"));
    end TestXB_Ctrl1_reparam;

    model TestXB_Ctrl1_reparam_optimized
      "Optimized model parameters of CrossBridgeCycling.mantATP.LabelLib.TestXB_Ctrl1_reparam"
      extends mantATP.Obsolete.TestXB_Ctrl1_reparam(
        tune_a=0.3425014844385265,
        tune_b=0.3039679462342411,
        tune_c=0.3016761386731495,
        timeTable_ATPChaseControl1(
          smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
          offset={offset}),
        break connect(timeTable_ATPChaseControl1.y, integratedSquaredDeviation.u2));

      /* Automatically generated at Mon Mar 17 21:03:49 2025 */
      /*
    The final optimization result was as follows:
    
    Evaluation #21
        0.2081755945520871        min    integratedSquaredDeviation.y1
    (   0.2147071134788648       <= 1    SRX_fraction)
    __________________________________________________
        0.2081755945520871       Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="CrossBridgeCycling.mantATP.LabelLib.TestXB_Ctrl1_reparam",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.3,
                                min=0.1,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.13,
                                min=0.1,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.3,
                                min=0.1,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="integratedSquaredDeviation.y1",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s"),
                    Optimization.Internal.Version.V22.Criterion(
                        name="SRX_fraction",
                        active=false,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Inequality,
                        demand=1,
                        unit="1")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.sqp,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=1e-3,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-600,
                            stopTime=600,
                            outputInterval=0,
                            numberOfIntervals=5000,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Dassl,
                            integrationTolerance=1e-3,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
      parameter Real offset=1e-3 "Offsets of output signals";
    equation
      connect(timeTable_ATPChaseControl1.y[1], integratedSquaredDeviation.u2)
        annotation (Line(points={{-39,90},{-12,90},{-12,90.4},{-6.8,90.4}},
            color={0,0,127}));
      annotation (Documentation(info=
              "<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
    end TestXB_Ctrl1_reparam_optimized;

    model TestXB_Ctrl1_kH100
      "Optimized model parameters of CrossBridgeCycling.mantATP.LabelLib.TestXB_Ctrl1"
      extends mantATP.Obsolete.TestXB_Ctrl1(
        tune_a=0.30961658908765416,
        tune_b=0.13154201047488814,
        tune_c=0.2992989266852087,
        kH_m(k=0.066*tune_c),
        k_srx_m(k=0.014*tune_a),
        k_srx_p(k=48.5*tune_b));

      /* Automatically generated at Mon Mar 17 18:44:15 2025 */
      /*
    The final optimization result was as follows:
    
    Evaluation #29
        0.5864876635150932        min    integratedSquaredDeviation.y1
    __________________________________________________
        0.5864876635150932       Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="CrossBridgeCycling.mantATP.LabelLib.TestXB_Ctrl1",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=1,
                                min=1e-2,
                                max=100,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=1,
                                min=1e-2,
                                max=100,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=1,
                                min=1e-2,
                                max=100,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="integratedSquaredDeviation.y1",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.sqp,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=1e-3,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-600,
                            stopTime=600,
                            outputInterval=0,
                            numberOfIntervals=5000,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Dassl,
                            integrationTolerance=1e-3,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
      annotation (Documentation(info=
              "<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
    end TestXB_Ctrl1_kH100;

    model TestXB_Ctrl1_kH_80
      "Optimized model parameters of CrossBridgeCycling.mantATP.LabelLib.TestXB_Ctrl1_optimized80"
      extends mantATP.Obsolete.TestXB_Ctrl1_kH100(
        tune_a=0.3119781015780103,
        tune_b=0.1066006396495426,
        tune_c=0.3004175637648112,
        kH(k=80));

      /* Automatically generated at Mon Mar 17 20:19:18 2025 */
      /*
    The final optimization result was as follows:
    
    Evaluation #25
        0.2053032375897605        min    integratedSquaredDeviation.y1
    __________________________________________________
        0.2053032375897605       Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="CrossBridgeCycling.mantATP.LabelLib.TestXB_Ctrl1_optimized80",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.3557947738901532,
                                min=0.1,
                                max=1,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.1317705722744261,
                                min=1e-2,
                                max=1,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.3598155471745415,
                                min=0.1,
                                max=1,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,3)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="integratedSquaredDeviation.y1",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.sqp,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=1e-3,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-600,
                            stopTime=600,
                            outputInterval=0,
                            numberOfIntervals=5000,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Dassl,
                            integrationTolerance=1e-3,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
      annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"),
          experiment(
          StartTime=-1620,
          StopTime=600,
          __Dymola_NumberOfIntervals=5000,
          __Dymola_Algorithm="Dassl"));
    end TestXB_Ctrl1_kH_80;

    model TestXB_Ctrl1_reparam_optimized_A2
      extends Obsolete.TestXB_Ctrl1_reparam_optimized(A2(nPorts=1, pop_start(
              displayUnit="mol") = 0.4), DRX_T(nPorts=5));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k2(
        k=50,
        useRateInput=true,
        useDynamicFlowLabeling=true,
        labelIn=time > -ageTime and time < 0,
        labelOut=time > 0) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={22,40})));
      Modelica.Blocks.Sources.RealExpression SRXLabel1(y=if time > -ageTime
             and A2.pop > 1e-6 then k2.k else 0)
        annotation (Placement(transformation(extent={{62,58},{42,78}})));
    equation
      connect(SRXLabel1.y,k2. rateInput)
        annotation (Line(points={{41,68},{32,68},{32,44}}, color={0,0,127}));
      connect(k2.lpop_a, A2.lpop[1]) annotation (Line(
          points={{32,40},{32,40.4},{40.2,40.4}},
          color={107,45,134},
          thickness=1));
      connect(k2.lpop_b, DRX_T.lpop[5]) annotation (Line(
          points={{12,40},{6,40},{6,-18},{-30,-18},{-30,-39.975},{-40.2,-39.975},
              {-40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      annotation (experiment(
          StartTime=-600,
          StopTime=618,
          __Dymola_NumberOfIntervals=5000,
          __Dymola_Algorithm="Dassl"));
    end TestXB_Ctrl1_reparam_optimized_A2;

    model XBCycling_A2
      extends DataMatched.Hooijman.XBCycling(
        A2(pop_start=0.4),
        tune_a=0.32209674728815296,
        tune_b=0.2580328344792636,
        tune_c=0.2954172194469952);
    end XBCycling_A2;

    model XBCycling_kH120
      extends Obsolete.XBCycling_A2(
        kH(k=120),
        tune_a=0.31375624657832374,
        tune_b=0.37443405317894396,
        tune_c=0.28187438139777166);
    end XBCycling_kH120;

    model XBCycling_Walklate_CalcADPDilHooijmanKInf
      "Generating ADP, having a slow-down effect on DRX_D to DRX_T transition"
      extends DataMatched.Hooijman.XBCycling(
        CATP(displayUnit="mmol/l") = 1.0,
        CmantATP(displayUnit="mmol/l") = 0.07,
        kH(useRateOutput=true),
        kH_m(
          useRateInput=true,
          useRateOutput=true),
        rateDRXDOut(y=if time > -ageTime then inverseProportionalFactor.y
               else 0),
        offset=0.0003088442661046059,
        tune_a=0.5316918755684544,
        tune_b=0.09369064341187563,
        tune_c=1.0614459881357723
                      );
      Modelica.Blocks.Continuous.Integrator integrator
        annotation (Placement(transformation(extent={{26,-66},{46,-46}})));
      Modelica.Blocks.Sources.Constant const(k=0.066*tune_c)
        annotation (Placement(transformation(extent={{40,8},{60,28}})));
      Bodylight.Blocks.Factors.InverseProportionalFactor inverseProportionalFactor(
          scalingFactor=1,   enabled=true)
        annotation (Placement(transformation(extent={{90,-18},{70,2}})));
      parameter Real IfADP=0.1
        "Intesity of free mADP as a fraction of mATP intensity";
      Modelica.Blocks.Math.Division dillutionEffect "Relative to initial"
        annotation (Placement(transformation(extent={{60,-72},{80,-52}})));
      Modelica.Blocks.Math.Division a_times_u
        annotation (Placement(transformation(extent={{90,-82},{110,-62}})));
      Modelica.Blocks.Sources.Constant K_ADP(k=10e9)
        annotation (Placement(transformation(extent={{60,-92},{74,-78}})));
      Modelica.Blocks.Sources.RealExpression dillutionConst(y=if time > 0 then 4
             elseif time > -ageTime then 2 else 1)
        annotation (Placement(transformation(extent={{24,-96},{38,-82}})));
      parameter Bodylight.Types.Fraction f_load_mix=2;
    equation
      connect(const.y, inverseProportionalFactor.yBase)
        annotation (Line(points={{61,18},{80,18},{80,-6}}, color={0,0,127}));
      connect(kH_m.popChangeOutput, integrator.u) annotation (Line(points={{-10,-28},
              {-18,-28},{-18,-56},{24,-56}},                   color={0,0,127}));
      connect(integrator.y, dillutionEffect.u1)
        annotation (Line(points={{47,-56},{58,-56}}, color={0,0,127}));
      connect(a_times_u.y, inverseProportionalFactor.u) annotation (Line(
            points={{111,-72},{116,-72},{116,-8},{88,-8}}, color={0,0,127}));
      connect(dillutionEffect.y, a_times_u.u1) annotation (Line(points={{81,-62},
              {84,-62},{84,-66},{88,-66}}, color={0,0,127}));
      connect(K_ADP.y, a_times_u.u2) annotation (Line(points={{74.7,-85},{80,
              -85},{80,-78},{88,-78}}, color={0,0,127}));
      connect(dillutionConst.y, dillutionEffect.u2) annotation (Line(points={
              {38.7,-89},{50,-89},{50,-68},{58,-68}}, color={0,0,127}));
      annotation (experiment(
          StartTime=-1500,
          StopTime=1500,
          __Dymola_NumberOfIntervals=5000,
          __Dymola_Algorithm="Dassl"), Diagram(graphics={Line(points={{80,-12},{40,-12},
                  {46,-8}}, color={28,108,200})}));
    end XBCycling_Walklate_CalcADPDilHooijmanKInf;
  end Obsolete;

  package Data
    model Toepfer2020 "Data from PMID: 31983222"

      Real ATPFluorescence = a*exp(-b*x) + c*exp(-d*x);
      Real x = max(0, time);
      parameter Real a = 0.70, b = 0.052, c=0.30, d = 0.0061;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Toepfer2020;

    model ChaseData
      "Control cardiomyocyte mant-ATP chase. Data from experiments of Alison Van Der Roest and Julia Han."
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        tableOnFile=false,
        table=[18,0.704575,0.626512,0.757024,1.175008; 27.994,0.628669,0.505251,
            0.70275,0.945396; 37.988,0.532319,0.405251,0.693936,0.873019; 47.982,
            0.519323,0.329185,0.666516,0.801315; 57.976,0.463446,0.245353,
            0.641676,0.831088; 67.97,0.443831,0.246881,0.592881,0.739397; 77.964,
            0.402628,0.178039,0.563653,0.704748; 87.958,0.347676,0.151591,
            0.522787,0.684761; 97.952,0.306668,0.12387,0.47,0.646423; 107.946,
            0.254855,0.111044,0.434256,0.644883; 117.94,0.222877,0.099013,
            0.402298,0.658037; 127.935,0.186469,0.047836,0.355838,0.627751;
            137.929,0.190436,0.052196,0.320904,0.564196; 147.923,0.191677,
            0.013144,0.295857,0.594931; 157.917,0.158652,0.009866,0.272712,
            0.540969; 167.911,0.150694,0.010948,0.252316,0.525024; 177.905,
            0.135556,0.017791,0.232335,0.524222; 187.899,0.143831,0.020146,
            0.222109,0.504267; 197.893,0.121392,-0.00987,0.213691,0.515143;
            207.887,0.11779,-0.00544,0.184426,0.509432; 217.881,0.105232,0.012826,
            0.180094,0.520404; 227.875,0.111073,0.018141,0.188456,0.490504;
            237.869,0.099732,0.012317,0.183013,0.44761; 247.863,0.107471,-0.01575,
            0.182335,0.438787; 257.857,0.104673,0.016836,0.149605,0.404299;
            267.851,0.090801,-0.02244,0.152015,0.427976; 277.845,0.0734,0.011362,
            0.134407,0.42204; 287.839,0.09944,-0.00328,0.125537,0.419313; 297.833,
            0.0734,0.007829,0.136817,0.358133; 307.827,0.08019,0.012731,0.128004,
            0.347; 317.822,0.068654,0.004042,0.145424,0.319731; 327.816,0.072937,
            0.030108,0.123804,0.319795; 337.81,0.074179,0.018491,0.125838,0.31325;
            347.804,0.077659,0.003405,0.121375,0.290889; 357.798,0.093332,-0.00719,
            0.112448,0.261373; 367.792,0.055245,0.002228,0.114444,0.294514;
            377.786,0.081747,0.012826,0.094539,0.264453; 387.78,0.060088,0.012158,
            0.090603,0.20847; 397.774,0.062521,0.006652,0.107458,0.158486;
            407.768,0.057532,-0.00414,0.091525,0.167918; 417.762,0.066488,
            0.016136,0.090282,0.118993; 427.756,0.047165,0.005124,0.097721,
            0.140488; 437.75,0.076856,0.00261,0.073879,0.128264; 447.744,0.044512,
            -0.00465,0.071224,0.120212; 457.738,0.042346,-0.00185,0.090056,
            0.091274; 467.732,0.060793,-0.00815,0.090207,0.10693; 477.726,
            0.045534,0.004742,0.10322,0.056561; 487.72,0.03816,0.009612,0.10484,
            0.079724; 497.714,0.03378,0.014577,0.0658,0.041931; 507.708,0.030129,
            0.009484,0.071073,0.035194; 517.703,0.03962,0.016136,0.049228,
            0.046198; 527.697,0.010416,-0.01181,0.057608,0.034039; 537.691,
            0.034826,-0.02139,0.037721,0.000834; 547.685,0.028304,0.000764,
            0.045669,0.009721; 557.679,0.00202,0.028517,0.05194,-0.01681; 567.673,
            0.034802,0.018014,0.047514,0.001412; 577.667,0.017985,0.009007,
            0.059831,-0.01344; 587.661,-0.00431,0.004901,0.029887,0.006224;
            597.655,0.024556,0.0155,0.038079,-0.00991; 607.649,0.021514,0.014386,
            0.03823,0.018896; 617.643,-0.00358,0.014449,0.021676,-0.0232],
        tableName="tab",
        fileName="data/tables.mat")
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Interfaces.RealOutput
                 y[combiTimeTable.nout] "Connector of Real output signals" annotation (Placement(
            transformation(extent={{94,-10},{114,10}})));
    equation
      connect(combiTimeTable.y, y)
        annotation (Line(points={{11,0},{104,0}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                    Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            textColor={0,0,255}),
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80,90},{-88,68},{-72,68},{-80,90}}),
        Line(points={{-80,68},{-80,-80}},
          color={192,192,192}),
        Line(points={{-90,-70},{82,-70}},
          color={192,192,192}),
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90,-70},{68,-62},{68,-78},{90,-70}}),
        Rectangle(lineColor={255,255,255},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          extent={{-48,-50},{2,70}}),
        Line(points={{-48,-50},{-48,70},{52,70},{52,-50},{-48,-50},{-48,-20},{52,-20},
                  {52,10},{-48,10},{-48,40},{52,40},{52,70},{2,70},{2,-51}})}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end ChaseData;

    block ATPChaseData_ATPChaseControl1 "Chase control 1 from Van Roest"
      extends ATPChaseData;


      Modelica.Blocks.Sources.CombiTimeTable timeTable(table=[0,1; 18,0.704575;
            27.994,0.628669; 37.988,0.532319; 47.982,0.519323; 57.976,
            0.463446; 67.97,0.443831; 77.964,0.402628; 87.958,0.347676;
            97.952,0.306668; 107.946,0.254855; 117.94,0.222877; 127.935,
            0.186469; 137.929,0.190436; 147.923,0.191677; 157.917,0.158652;
            167.911,0.150694; 177.905,0.135556; 187.899,0.143831; 197.893,
            0.121392; 207.887,0.11779; 217.881,0.105232; 227.875,0.111073;
            237.869,0.099732; 247.863,0.107471; 257.857,0.104673; 267.851,
            0.090801; 277.845,0.0734; 287.839,0.09944; 297.833,0.0734;
            307.827,0.08019; 317.822,0.068654; 327.816,0.072937; 337.81,
            0.074179; 347.804,0.077659; 357.798,0.093332; 367.792,0.055245;
            377.786,0.081747; 387.78,0.060088; 397.774,0.062521; 407.768,
            0.057532; 417.762,0.066488; 427.756,0.047165; 437.75,0.076856;
            447.744,0.044512; 457.738,0.042346; 467.732,0.060793; 477.726,
            0.045534; 487.72,0.03816; 497.714,0.03378; 507.708,0.030129;
            517.703,0.03962; 527.697,0.010416; 537.691,0.034826; 547.685,
            0.028304; 557.679,0.00202; 567.673,0.034802; 577.667,0.017985;
            587.661,-0.00431; 597.655,0.024556; 607.649,0.021514; 617.643,-0.00358])
        annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
    equation
      timeTable.y[1] = y;

      annotation (experiment(StopTime=100, __Dymola_Algorithm="Dassl"));
    end ATPChaseData_ATPChaseControl1;

    block TimeTable_ATPChaseControl2 "Chase control 2 from Van Roest"
     extends Modelica.Blocks.Sources.CombiTimeTable(table=[18,0.626512;
            27.994,0.505251; 37.988,0.405251; 47.982,0.329185; 57.976,
            0.245353; 67.97,0.246881; 77.964,0.178039; 87.958,0.151591;
            97.952,0.12387; 107.946,0.111044; 117.94,0.099013; 127.935,
            0.047836; 137.929,0.052196; 147.923,0.013144; 157.917,0.009866;
            167.911,0.010948; 177.905,0.017791; 187.899,0.020146; 197.893,-0.00987;
            207.887,-0.00544; 217.881,0.012826; 227.875,0.018141; 237.869,
            0.012317; 247.863,-0.01575; 257.857,0.016836; 267.851,-0.02244;
            277.845,0.011362; 287.839,-0.00328; 297.833,0.007829; 307.827,
            0.012731; 317.822,0.004042; 327.816,0.030108; 337.81,0.018491;
            347.804,0.003405; 357.798,-0.00719; 367.792,0.002228; 377.786,
            0.012826; 387.78,0.012158; 397.774,0.006652; 407.768,-0.00414;
            417.762,0.016136; 427.756,0.005124; 437.75,0.00261; 447.744,-0.00465;
            457.738,-0.00185; 467.732,-0.00815; 477.726,0.004742; 487.72,
            0.009612; 497.714,0.014577; 507.708,0.009484; 517.703,0.016136;
            527.697,-0.01181; 537.691,-0.02139; 547.685,0.000764; 557.679,
            0.028517; 567.673,0.018014; 577.667,0.009007; 587.661,0.004901;
            597.655,0.0155; 607.649,0.014386; 617.643,0.014449]);
    end TimeTable_ATPChaseControl2;

    block TimeTable_ATPChaseControl3
     extends Modelica.Blocks.Sources.CombiTimeTable(table=[18,0.757024;
            27.994,0.70275; 37.988,0.693936; 47.982,0.666516; 57.976,0.641676;
            67.97,0.592881; 77.964,0.563653; 87.958,0.522787; 97.952,0.47;
            107.946,0.434256; 117.94,0.402298; 127.935,0.355838; 137.929,
            0.320904; 147.923,0.295857; 157.917,0.272712; 167.911,0.252316;
            177.905,0.232335; 187.899,0.222109; 197.893,0.213691; 207.887,
            0.184426; 217.881,0.180094; 227.875,0.188456; 237.869,0.183013;
            247.863,0.182335; 257.857,0.149605; 267.851,0.152015; 277.845,
            0.134407; 287.839,0.125537; 297.833,0.136817; 307.827,0.128004;
            317.822,0.145424; 327.816,0.123804; 337.81,0.125838; 347.804,
            0.121375; 357.798,0.112448; 367.792,0.114444; 377.786,0.094539;
            387.78,0.090603; 397.774,0.107458; 407.768,0.091525; 417.762,
            0.090282; 427.756,0.097721; 437.75,0.073879; 447.744,0.071224;
            457.738,0.090056; 467.732,0.090207; 477.726,0.10322; 487.72,
            0.10484; 497.714,0.0658; 507.708,0.071073; 517.703,0.049228;
            527.697,0.057608; 537.691,0.037721; 547.685,0.045669; 557.679,
            0.05194; 567.673,0.047514; 577.667,0.059831; 587.661,0.029887;
            597.655,0.038079; 607.649,0.03823; 617.643,0.021676]);
    end TimeTable_ATPChaseControl3;

    block TimeTable_ATPChaseControl4
     extends Modelica.Blocks.Sources.CombiTimeTable(table=[18,0.704575;
            27.994,0.628669; 37.988,0.532319; 47.982,0.519323; 57.976,
            0.463446; 67.97,0.443831; 77.964,0.402628; 87.958,0.347676;
            97.952,0.306668; 107.946,0.254855; 117.94,0.222877; 127.935,
            0.186469; 137.929,0.190436; 147.923,0.191677; 157.917,0.158652;
            167.911,0.150694; 177.905,0.135556; 187.899,0.143831; 197.893,
            0.121392; 207.887,0.11779; 217.881,0.105232; 227.875,0.111073;
            237.869,0.099732; 247.863,0.107471; 257.857,0.104673; 267.851,
            0.090801; 277.845,0.0734; 287.839,0.09944; 297.833,0.0734;
            307.827,0.08019; 317.822,0.068654; 327.816,0.072937; 337.81,
            0.074179; 347.804,0.077659; 357.798,0.093332; 367.792,0.055245;
            377.786,0.081747; 387.78,0.060088; 397.774,0.062521; 407.768,
            0.057532; 417.762,0.066488; 427.756,0.047165; 437.75,0.076856;
            447.744,0.044512; 457.738,0.042346; 467.732,0.060793; 477.726,
            0.045534; 487.72,0.03816; 497.714,0.03378; 507.708,0.030129;
            517.703,0.03962; 527.697,0.010416; 537.691,0.034826; 547.685,
            0.028304; 557.679,0.00202; 567.673,0.034802; 577.667,0.017985;
            587.661,-0.00431; 597.655,0.024556; 607.649,0.021514; 617.643,-0.00358]);
    end TimeTable_ATPChaseControl4;

    block TimeTable_ATPChaseMeanPos "Mean of all 10 POS data from ATP chase"
      extends Modelica.Blocks.Sources.TimeTable(table=[0,1; 5.529,0.927350434;
            11.058,0.863017052; 16.587,0.805839694; 22.116,0.756884973;
            27.645,0.715639075; 33.174,0.678791754; 38.703,0.646107701;
            44.232,0.617961965; 49.761,0.592224941; 55.29,0.569170047; 60.819,
            0.548339118; 66.348,0.530670789; 71.877,0.515357682; 77.406,
            0.499134294; 82.935,0.485184333; 88.464,0.472883152; 93.993,
            0.461307102; 99.523,0.45037915; 105.052,0.438796683; 110.581,
            0.427954043; 116.11,0.418175685; 121.639,0.409314261; 127.168,
            0.400305015; 132.697,0.391518023; 138.226,0.384122444; 143.755,
            0.378596225; 149.284,0.372118237; 154.813,0.364638911; 160.342,
            0.357411109; 165.871,0.34909594; 171.4,0.341757209; 176.929,
            0.336437754; 182.458,0.328506074; 187.987,0.322778604; 193.516,
            0.316864055; 199.045,0.312173634; 204.574,0.307026678; 210.103,
            0.30187899; 215.632,0.295187427; 221.161,0.288818556; 226.69,
            0.283511288; 232.219,0.279540521; 237.748,0.273887428; 243.277,
            0.267194997; 248.806,0.262483913; 254.335,0.256754379; 259.864,
            0.2530259; 265.393,0.247998756; 270.922,0.242715944; 276.451,
            0.237986074; 281.98,0.233339736; 287.509,0.227348635; 293.038,
            0.222794651; 298.568,0.217815087; 304.097,0.212747774; 309.626,
            0.208537212; 315.155,0.204386267; 320.684,0.200575872; 326.213,
            0.195764734; 331.742,0.190628259; 337.271,0.186022245; 342.8,
            0.181696196; 348.329,0.177508906; 353.858,0.172760629; 359.387,
            0.168569088; 364.916,0.164026577; 370.445,0.159551745; 375.974,
            0.155578284; 381.503,0.151677261; 387.032,0.148467245; 392.561,
            0.143711123; 398.09,0.139688572; 403.619,0.136124753; 409.148,
            0.131243394; 414.677,0.125071105; 420.206,0.120561432; 425.735,
            0.116331157; 431.264,0.112238916; 436.793,0.108335361; 442.322,
            0.104607132; 447.851,0.102025517; 453.38,0.09779329; 458.909,
            0.09435339; 464.438,0.091729225; 469.967,0.087877381; 475.496,
            0.083563054; 481.025,0.078837463; 486.554,0.074527306; 492.083,
            0.071352958; 497.613,0.066395998; 503.142,0.062387083; 508.671,
            0.059136577; 514.2,0.05550326; 519.729,0.051741794; 525.258,
            0.048054276; 530.787,0.044747722; 536.316,0.040591287; 541.845,
            0.036577139; 547.374,0.033348047; 552.903,0.029176759; 558.432,
            0.024649809; 563.961,0.020267953; 569.49,0.017217835; 575.019,
            0.013529917; 580.548,0.010135699; 586.077,0.00682139; 591.606,
            0.003805418; 597.135,0]);
    end TimeTable_ATPChaseMeanPos;

    block TimeTable_ATPChaseMavaMeanPos
      "Mean of all four POS data from ATP chase"
      extends Modelica.Blocks.Sources.TimeTable(table=[0,1; 7.818,0.913680654;
            15.636,0.841023599; 23.455,0.777326996; 31.273,0.723555152;
            39.091,0.677882253; 46.909,0.637980255; 54.727,0.603463261;
            62.545,0.572208451; 70.364,0.544891351; 78.182,0.521108872; 86,
            0.498271314; 93.818,0.479165956; 101.636,0.461753789; 109.454,
            0.447710155; 117.273,0.429692055; 125.091,0.414403914; 132.909,
            0.401354049; 140.727,0.387305477; 148.545,0.374654799; 156.363,
            0.36443113; 164.182,0.353251496; 172,0.341742903; 179.818,
            0.332276995; 187.636,0.322722698; 195.454,0.315959531; 203.272,
            0.311113656; 211.091,0.301055514; 218.909,0.293461494; 226.727,
            0.288523875; 234.545,0.276696942; 242.363,0.270475903; 250.181,
            0.263371779; 258,0.255346822; 265.818,0.251000742; 273.636,
            0.243499858; 281.454,0.238475408; 289.272,0.232521991; 297.09,
            0.224779137; 304.909,0.221336147; 312.727,0.212461788; 320.545,
            0.206149839; 328.363,0.20028084; 336.181,0.195653179; 344,
            0.189890889; 351.818,0.184592387; 359.636,0.180791237; 367.454,
            0.178934881; 375.272,0.171880773; 383.09,0.16578103; 390.909,
            0.158030529; 398.727,0.153419729; 406.545,0.148172318; 414.363,
            0.140240898; 422.181,0.134548101; 429.999,0.128192015; 437.818,
            0.119054407; 445.636,0.113645281; 453.454,0.106140443; 461.272,
            0.100521261; 469.09,0.094313316; 476.908,0.086150135; 484.727,
            0.080038679; 492.545,0.075432478; 500.363,0.06983712; 508.181,
            0.064027152; 515.999,0.057104891; 523.817,0.05264343; 531.636,
            0.045766869; 539.454,0.039557303; 547.272,0.033853193; 555.09,
            0.026413981; 562.908,0.021942752; 570.727,0.01773855; 578.545,
            0.010838229; 586.363,0.005683596; 594.181,0]);
    end TimeTable_ATPChaseMavaMeanPos;

    block TimeTable_NormATPChaseMava1
      extends Modelica.Blocks.Sources.TimeTable(table=[0,1; 5.668,0.946332737;
            11.335,0.940780951; 17.003,0.8170995; 22.67,0.821664302; 28.338,
            0.782061563; 34.005,0.67873666; 39.673,0.624884338; 45.34,
            0.645981124; 51.008,0.535870705; 56.675,0.560051817; 62.343,
            0.566097095; 68.01,0.496823145; 73.678,0.440071556; 79.345,
            0.464992906; 85.013,0.427364135; 90.68,0.438652767; 96.348,
            0.391215841; 102.015,0.404355068; 107.683,0.421133798; 113.35,
            0.421874036; 119.018,0.408796496; 124.685,0.450743322; 130.353,
            0.35130467; 136.02,0.345321078; 141.688,0.373635186; 147.355,
            0.381469373; 153.023,0.344272408; 158.69,0.334402566; 164.358,
            0.335883042; 170.025,0.308494232; 175.693,0.281783974; 181.36,
            0.304669669; 187.028,0.32903584; 192.695,0.277157486; 198.363,
            0.274319906; 204.031,0.264018259; 209.698,0.269816791; 215.366,
            0.310283141; 221.033,0.256184073; 226.701,0.282400839; 232.368,
            0.254333477; 238.036,0.198383813; 243.703,0.244710382; 249.371,
            0.248041453; 255.038,0.152920856; 260.706,0.213682068; 266.373,
            0.227623219; 272.041,0.214607365; 277.708,0.246314231; 283.376,
            0.184751095; 289.043,0.220837703; 294.711,0.20868546; 300.378,
            0.228671889; 306.046,0.202085004; 311.713,0.179877861; 317.381,
            0.181234964; 323.048,0.125717106; 328.716,0.212201592; 334.383,
            0.179939547; 340.051,0.205786195; 345.718,0.112577879; 351.386,
            0.149219666; 357.053,0.152612424; 362.721,0.146505459; 368.388,
            0.175004626; 374.056,0.214237246; 379.723,0.169946333; 385.391,
            0.155264944; 391.059,0.092344704; 396.726,0.0598976; 402.394,
            0.176485103; 408.061,0.163839368; 413.729,0.190056135; 419.396,
            0.16717044; 425.064,0.060020973; 430.731,0.102893097; 436.399,
            0.058232065; 442.066,0.08728641; 447.734,0.0077725; 453.401,
            0.019677996; 459.069,0.069767442; 464.736,0.050521251; 470.404,
            0.005798532; 476.071,0.057368454; 481.739,0.066991549; 487.406,
            0.054099069; 493.074,0.059650854; 498.741,0.071988156; 504.409,
            0.04028129; 510.076,0.078588613; 515.744,0.078403553; 521.411,
            0.07050768; 527.079,0.075195855; 532.746,0.079884029; 538.414,
            0.071247918; 544.081,0.101597681; 549.749,0.03392758; 555.416,
            0.126889149; 561.084,0.063043612; 566.751,0.009376349; 572.419,
            0.043674048; 578.086,0.027635556; 583.754,0; 589.422,0.044044168;
            595.089,0.038307322]);
    end TimeTable_NormATPChaseMava1;

    block TimeTable_NormATPChaseControl1
      extends Modelica.Blocks.Sources.TimeTable(table=[0,1; 18,0.704575;
            27.994,0.628669; 37.988,0.532319; 47.982,0.519323; 57.976,
            0.463446; 67.97,0.443831; 77.964,0.402628; 87.958,0.347676;
            97.952,0.306668; 107.946,0.254855; 117.94,0.222877; 127.935,
            0.186469; 137.929,0.190436; 147.923,0.191677; 157.917,0.158652;
            167.911,0.150694; 177.905,0.135556; 187.899,0.143831; 197.893,
            0.121392; 207.887,0.11779; 217.881,0.105232; 227.875,0.111073;
            237.869,0.099732; 247.863,0.107471; 257.857,0.104673; 267.851,
            0.090801; 277.845,0.0734; 287.839,0.09944; 297.833,0.0734;
            307.827,0.08019; 317.822,0.068654; 327.816,0.072937; 337.81,
            0.074179; 347.804,0.077659; 357.798,0.093332; 367.792,0.055245;
            377.786,0.081747; 387.78,0.060088; 397.774,0.062521; 407.768,
            0.057532; 417.762,0.066488; 427.756,0.047165; 437.75,0.076856;
            447.744,0.044512; 457.738,0.042346; 467.732,0.060793; 477.726,
            0.045534; 487.72,0.03816; 497.714,0.03378; 507.708,0.030129;
            517.703,0.03962; 527.697,0.010416; 537.691,0.034826; 547.685,
            0.028304; 557.679,0.00202; 567.673,0.034802; 577.667,0.017985;
            587.661,-0.00431; 597.655,0.024556; 607.649,0.021514; 617.643,-0.00358]);
    end TimeTable_NormATPChaseControl1;

    block TimeTable_ATPChaseHooijman2011
      "Chase control 1 from fig 1 mantATP-ATP chase of Hooijman et al. Biophys J 2011"
      extends ATPChaseData;

      Real x = max(0, time);
      parameter Real P1 = 0.66, T1 = 14, P2=0.27, T2 = 144;
    equation
      maxScale = 1;
      y = 1 - P1*(1 - exp(-x/T1)) - P2*(1 - exp(-x/T2));

      annotation (experiment(StopTime=600, __Dymola_Algorithm="Dassl"));
    end TimeTable_ATPChaseHooijman2011;

    partial block ATPChaseData
      extends Modelica.Blocks.Interfaces.SO;
      parameter Real offset = 0;
      Real maxScale;
      annotation (Icon(graphics={
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-78,100},{-86,78},{-70,78},{-78,100}}),
        Line(points={{-78,78},{-78,-70}},
          color={192,192,192}),
        Line(points={{-88,-60},{84,-60}},
          color={192,192,192}),
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{92,-60},{70,-52},{70,-68},{92,-60}}),
            Line(
              points={{-70,90},{-60,-22},{-18,-34},{74,-38}},
              color={28,108,200},
              smooth=Smooth.Bezier,
              thickness=0.5),               Text(
            extent={{-160,-60},{140,-100}},
            textColor={0,0,255},
              textString="ATP chase")}));
    end ATPChaseData;

    block TimeTable_ATPChaseHooijman2011_Fig1
      extends ATPChaseData;

      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
          table=[0,0.999; 10.556,0.619; 14.778,0.457; 21.112,0.386; 25.757,0.34; 30.401,
            0.306; 34.624,0.281; 40.535,0.259; 46.446,0.242; 50.669,0.225; 56.158,0.21;
            60.38,0.199; 64.602,0.188; 71.358,0.175; 80.647,0.162; 88.248,0.15; 100.07,
            0.139; 109.36,0.131; 116.96,0.123; 125.405,0.117; 134.694,0.111; 144.828,
            0.105; 154.961,0.1; 165.095,0.096; 175.229,0.092; 187.051,0.088; 199.719,
            0.085; 213.23,0.081; 226.742,0.077; 239.409,0.075; 252.498,0.073; 266.01,
            0.071; 279.944,0.068; 294.3,0.067; 307.811,0.064; 323.856,0.062; 339.057,
            0.06; 355.102,0.058; 372.836,0.056; 391.414,0.054; 407.46,0.053; 424.771,
            0.052; 439.55,0.05; 455.172,0.05; 472.906,0.048; 491.907,0.047; 509.641,
            0.046; 525.686,0.045; 543.42,0.043; 561.154,0.042; 578.044,0.041; 594.511,
            0.04])
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    equation
      maxScale = 1;
      connect(combiTimeTable.y[1], y) annotation (Line(
          points={{11,0},{110,0}},
          color={0,0,127},
          smooth=Smooth.Bezier));
    end TimeTable_ATPChaseHooijman2011_Fig1;

    block TimeTable_ATPChaseWalklate1A
      "Chase control from fig 1 A mantATP-ATP from Walklate 2022"
      extends ATPChaseData(y(final quantity="Fraction",final unit="1", displayUnit="%"), offset = 0.99);

      Real x = max(0, time);
      parameter Bodylight.Types.Fraction P1 = 0.056, P2=0.016;

      parameter Bodylight.Types.Time T1 = 1/0.027, T2 = 1/0.0038;
    equation
      maxScale = P1+P2 + offset;
      y = P1*(exp(-x/T1)) + P2*exp(-x/T2) + offset;

      annotation (experiment(StopTime=600, __Dymola_Algorithm="Dassl"));
    end TimeTable_ATPChaseWalklate1A;
  end Data;

  package DataMatched
    package Hooijman

      model XBCycling
        "Default model parametrization to fit Hooijman 2011 mantATP chased by ATP."
        extends Configurations.XBCyclingSrxT;
      end XBCycling;

      package RigorFraction
        model XBCycling_A280 "Retuned for higher initial rigor state"
          import mantATP;
          extends mantATP.DataMatched.Hooijman.XBCycling(
            tune_a=0.47733679799388273,
            tune_b=0.08780130903693892,
            tune_c=1.0251694037888126,
            A2(pop_start=0.8));
        end XBCycling_A280;
      end RigorFraction;

      package Experiments
        model XBCycling_Walklate_CalcADP
          "Generating ADP, having a slow-down effect on DRX_D to DRX_T transition"
          extends Walklate.Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            tune_a=0.2655897929630535,
            tune_b=0.094895195683267,
            tune_c=1.401853257217013,
            kH(useRateOutput=true),
            kH_m(
              k=0.066*tune_c,
              useRateInput=true,
              useRateOutput=true),
            rateDRXDOut(y=if time > -ageTime then inverseProportionalFactor.y
                   else 0));
          Modelica.Blocks.Continuous.Integrator integrator
            annotation (Placement(transformation(extent={{26,-66},{46,-46}})));
          Modelica.Blocks.Sources.Constant const(k=0.066*tune_c)
            annotation (Placement(transformation(extent={{40,8},{60,28}})));
          Bodylight.Blocks.Factors.InverseProportionalFactor inverseProportionalFactor(
              scalingFactor=1,   enabled=true)
            annotation (Placement(transformation(extent={{90,-18},{70,2}})));
          parameter Real IfADP=0.1
            "Intesity of free mADP as a fraction of mATP intensity";
          Modelica.Blocks.Math.Division a_times_u
            annotation (Placement(transformation(extent={{90,-82},{110,-62}})));
          Modelica.Blocks.Sources.Constant K_ADP(k=1)
            annotation (Placement(transformation(extent={{60,-92},{74,-78}})));
        equation
          connect(const.y, inverseProportionalFactor.yBase)
            annotation (Line(points={{61,18},{80,18},{80,-6}}, color={0,0,127}));
          connect(kH_m.popChangeOutput, integrator.u) annotation (Line(points={{-10,-28},
                  {-18,-28},{-18,-56},{24,-56}},                   color={0,0,127}));
          connect(a_times_u.y, inverseProportionalFactor.u) annotation (Line(
                points={{111,-72},{116,-72},{116,-8},{88,-8}}, color={0,0,127}));
          connect(K_ADP.y, a_times_u.u2) annotation (Line(points={{74.7,-85},{80,
                  -85},{80,-78},{88,-78}}, color={0,0,127}));
          connect(integrator.y, a_times_u.u1) annotation (Line(points={{47,-56},{
                  74,-56},{74,-66},{88,-66}}, color={0,0,127}));
          annotation (experiment(
              StartTime=-1500,
              StopTime=1500,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"), Diagram(graphics={Line(points={{80,-12},{40,-12},
                      {46,-8}}, color={28,108,200})}));
        end XBCycling_Walklate_CalcADP;

        model XBCycling_Walklate_CalcMantADP
          "Generating mantADP and adding to the overall label. No significant difference when subtracking the offset at the end"
          extends Walklate.Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            kH(useRateOutput=true),
            kH_m(useRateInput=true, useRateOutput=true),
            totalLabel(y=SRXLabel.y + DRXLabel.y + A2.labelAmount + mADPLabel.y));
          Modelica.Blocks.Math.Product product1
            annotation (Placement(transformation(extent={{46,-80},{66,-60}})));
          Bodylight.Population.LabeledPopulation.Components.LabelMeasure
            labelMeasure
            annotation (Placement(transformation(extent={{38,-50},{18,-70}})));
          Modelica.Blocks.Continuous.Integrator integrator
            annotation (Placement(transformation(extent={{74,-80},{94,-60}})));
          parameter Real IfADP=0.05
            "Intesity of free mADP as a fraction of mATP intensity";
          Modelica.Blocks.Sources.RealExpression mADPLabel(y=integrator.y*IfADP)
            annotation (Placement(transformation(extent={{-96,18},{-76,38}})));
        equation
          connect(kH.lpop_b,labelMeasure. lpop_a) annotation (Line(
              points={{10,-46},{28,-46},{28,-50}},
              color={107,45,134},
              thickness=1,
              smooth=Smooth.Bezier));
          connect(labelMeasure.label,product1. u1) annotation (Line(
              points={{38,-64},{38,-64},{44,-64}},
              color={0,0,127},
              smooth=Smooth.Bezier));
          connect(product1.y,integrator. u) annotation (Line(
              points={{67,-70},{67,-70},{72,-70}},
              color={0,0,127},
              smooth=Smooth.Bezier));
          connect(kH_m.popChangeOutput, product1.u2) annotation (Line(points={{-10,-28},
                  {-14,-28},{-14,-56},{18,-56},{18,-76},{44,-76}},color={0,0,127}));
          annotation (experiment(
              StartTime=-1500,
              StopTime=1500,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"));
        end XBCycling_Walklate_CalcMantADP;

        model XBCycling_ACtive
          extends XBCycling(
            DRX_D(nPorts=3),
            A2(nPorts=2),
            tune_a=50.23781,
            tune_b=0.0927277);
          Bodylight.Population.LabeledPopulation.Components.StateTransition ka(
            k(displayUnit="s-1") = 20,
            allowReverse=true,
            useRateOutput=false) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={30,-90})));
        equation
          connect(DRX_D.lpop[3], ka.lpop_a) annotation (Line(
              points={{40.2,-39.6},{40,-39.6},{40,-90}},
              color={107,45,134},
              thickness=1));
          connect(A2.lpop[2], ka.lpop_b) annotation (Line(
              points={{-40.2,-99.6},{-40.2,-100},{14,-100},{14,-90},{20,-90}},
              color={107,45,134},
              thickness=1));
          annotation (experiment(StopTime=600, __Dymola_Algorithm="Dassl"));
        end XBCycling_ACtive;

        model XBCyclingSrxD_drx2srx
          extends XBCyclingSrxD_A2_0(
            k_srx_p(disableTransition=true),
            DRX_T(nPorts=4),
            SRX(nPorts=3),
            tune_b=0.1,
            DRX_D(nPorts=5),
            A2(nPorts=2));
          Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_p1(
              disableTransition=false, k=48.5*tune_b)
                            annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={-40,14})));
          Bodylight.Population.LabeledPopulation.Components.StateTransition ka(
            k(displayUnit="s-1") = 20,
            allowReverse=true,
            useRateInput=true,
            useRateOutput=false) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={30,-90})));
          Modelica.Blocks.Sources.RealExpression rateA2Out1(y=if time > 0 then
                ka.k else 0)
            annotation (Placement(transformation(extent={{68,-102},{48,-82}})));
        equation
          connect(k_srx_p1.lpop_a, DRX_T.lpop[4]) annotation (Line(
              points={{-40,4},{-40,-40},{-40.2,-40},{-40.2,-39.6}},
              color={107,45,134},
              thickness=1));
          connect(k_srx_p1.lpop_b, SRX.lpop[3]) annotation (Line(
              points={{-40,24},{-40,32},{-40,40.4},{-40.2,40.4}},
              color={107,45,134},
              thickness=1));
          connect(rateA2Out1.y, ka.rateInput) annotation (Line(points={{47,-92},
                  {42,-92},{42,-94},{40,-94}}, color={0,0,127}));
          connect(ka.lpop_a, DRX_D.lpop[5]) annotation (Line(
              points={{40,-90},{40,-44},{40.2,-44},{40.2,-39.6}},
              color={107,45,134},
              thickness=1));
          connect(ka.lpop_b, A2.lpop[2]) annotation (Line(
              points={{20,-90},{14,-90},{14,-104},{-40.2,-104},{-40.2,-99.6}},
              color={107,45,134},
              thickness=1));
        end XBCyclingSrxD_drx2srx;

        model XBCyclingSrxD_A2_0
          "Optimized model parameters of mantATP.DataMatched.Hooijman.Experiments.XBCyclingAlternative_fudgeInit"
          extends
            Configurations.XBCyclingSrxD(
            tune_a=1.0067836787801121,
            tune_b=0.8453168893408061,
            tune_c=1.017840538354438,
            k_srx_m(k=0.014*tune_a*0.523781),
            k_srx_p(k=48.5*tune_b*9.27277E-05),
            A2(pop_start=1e-3));

          /* Automatically generated at Thu Sep 18 17:18:56 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #11
        8.3742329541341998e-8     min    sqDiffIntegrator.y
    __________________________________________________
        8.3742329541341998e-8    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.DataMatched.Hooijman.Experiments.XBCyclingAlternative_fudgeInit",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=1,
                                min=0,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=1,
                                min=0,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=1.08195,
                                min=0,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="sqDiffIntegrator.y",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.sqp,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=9.9999999999999995e-7,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-600,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=9.9999999999999995e-7,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end XBCyclingSrxD_A2_0;

        model XBCyclingSrxD_A2_80
          "Optimized model parameters of mantATP.DataMatched.Hooijman.Experiments.XBCyclingAlternative_fudgeInit"
          extends
            Configurations.XBCyclingSrxD(
            tune_a=0.9995342401118589,
            tune_b=0.7463909821686898,
            tune_c=1.025962629043154,
            k_srx_m(k=0.014*tune_a*0.523781),
            k_srx_p(k=48.5*tune_b*9.27277E-05),
            A2(pop_start=0.8));

          /* Automatically generated at Thu Sep 18 17:18:56 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #11
        8.3742329541341998e-8     min    sqDiffIntegrator.y
    __________________________________________________
        8.3742329541341998e-8    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.DataMatched.Hooijman.Experiments.XBCyclingAlternative_fudgeInit",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=1,
                                min=0,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=1,
                                min=0,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=1.08195,
                                min=0,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="sqDiffIntegrator.y",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.sqp,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=9.9999999999999995e-7,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-600,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=9.9999999999999995e-7,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end XBCyclingSrxD_A2_80;

        model XBCyclingSrxD_Active
          extends XBCyclingSrxD_A2_0(DRX_D(nPorts=5), A2(nPorts=2));
          Bodylight.Population.LabeledPopulation.Components.StateTransition ka(
            k(displayUnit="s-1") = 20,
            allowReverse=true,
            useRateInput=true,
            useRateOutput=false) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={42,-90})));
          Modelica.Blocks.Sources.RealExpression rateA2Out1(y=if time > 0 then
                ka.k else 0)
            annotation (Placement(transformation(extent={{86,-104},{66,-84}})));
        equation
          connect(ka.lpop_a, DRX_D.lpop[5]) annotation (Line(
              points={{52,-90},{56,-90},{56,-44},{40.2,-44},{40.2,-39.6}},
              color={107,45,134},
              thickness=1));
          connect(ka.lpop_b, A2.lpop[2]) annotation (Line(
              points={{32,-90},{16,-90},{16,-104},{-40.2,-104},{-40.2,-99.6}},
              color={107,45,134},
              thickness=1));
          connect(rateA2Out1.y, ka.rateInput)
            annotation (Line(points={{65,-94},{52,-94}}, color={0,0,127}));
        end XBCyclingSrxD_Active;
      end Experiments;

      package Photobleaching
        model XBCycling_Hooijman_PB0005
          "Testing exponential photobleaching, can't fit properly"
          import mantATP;
          extends mantATP.DataMatched.Hooijman.XBCycling(
            k_pb=0.0005,
            tune_a=0.48854000234126166,
            tune_b=0.09201105435689291,
            tune_c=1.0834138419070154
                       );
          annotation (experiment(
              StartTime=-1600,
              StopTime=600,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"));
        end XBCycling_Hooijman_PB0005;

        model XBCycling_Hooijman_PB0005_BoundOnly
          extends XBCycling_Hooijman_PB0005(
            k_pb=0,
            SRX(nPorts=4),
            DRX_D(nPorts=4));
          Bodylight.Population.LabeledPopulation.Components.StateTransition kH_m1(
            k=PB_act,
            allowReverse=true,
            useRateOutput=false,
            useDynamicFlowLabeling=true,
            useRateInput=true) annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={30,50})));
          parameter Bodylight.Types.PopulationChange PB_act(displayUnit="s-1")
             = 0.0005;
          Modelica.Blocks.Sources.RealExpression labelDRX_D1(y=0)
            annotation (Placement(transformation(extent={{-2,54},{18,74}})));
          Bodylight.Population.LabeledPopulation.Components.StateTransition kH_m2(
            k=PB_act,
            allowReverse=true,
            useRateOutput=false,
            useDynamicFlowLabeling=true,
            useRateInput=true) annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={84,-8})));
          Modelica.Blocks.Sources.RealExpression labelDRX_D2(y=0)
            annotation (Placement(transformation(extent={{52,-4},{72,16}})));
          Modelica.Blocks.Sources.RealExpression rateDRXDOut1(y=5e-4*SRX.labelAmount
                /SRX.pop)
            annotation (Placement(transformation(extent={{-30,48},{-10,68}})));
          Modelica.Blocks.Sources.RealExpression rateDRXDOut2(y=5e-4*DRX_D.labelAmount
                /DRX_D.pop)
            annotation (Placement(transformation(extent={{42,-14},{62,6}})));
        equation
          connect(kH_m1.lpop_a, SRX.lpop[3]) annotation (Line(
              points={{20,50},{-34,50},{-34,40},{-40.2,40},{-40.2,40.4}},
              color={107,45,134},
              thickness=1));
          connect(labelDRX_D1.y, kH_m1.labelInput) annotation (Line(points={{19,
                  64},{30,64},{30,58}}, color={0,0,127}));
          connect(kH_m1.lpop_b, SRX.lpop[4]) annotation (Line(
              points={{40,50},{54,50},{54,40.4},{-40.2,40.4}},
              color={107,45,134},
              thickness=1));
          connect(labelDRX_D2.y, kH_m2.labelInput)
            annotation (Line(points={{73,6},{84,6},{84,0}}, color={0,0,127}));
          connect(kH_m2.lpop_a, DRX_D.lpop[3]) annotation (Line(
              points={{74,-8},{66,-8},{66,-44},{40.2,-44},{40.2,-39.6}},
              color={107,45,134},
              thickness=1));
          connect(kH_m2.lpop_b, DRX_D.lpop[4]) annotation (Line(
              points={{94,-8},{94,-68},{42,-68},{42,-39.6},{40.2,-39.6}},
              color={107,45,134},
              thickness=1));
          connect(rateDRXDOut1.y, kH_m1.rateInput) annotation (Line(points={{-9,
                  58},{-6,58},{-6,54},{20,54}}, color={0,0,127}));
          connect(rateDRXDOut2.y, kH_m2.rateInput)
            annotation (Line(points={{63,-4},{74,-4}}, color={0,0,127}));
          annotation (experiment(
              StartTime=-1600,
              StopTime=1000,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"));
        end XBCycling_Hooijman_PB0005_BoundOnly;
      end Photobleaching;

      package ADPEffect
        model XBCycling_Hooijman_CalcADPDil
          "Generating ADP, having a slow-down effect on DRX_D to DRX_T transition"
          extends XBCycling(
            kH(useRateOutput=true),
            kH_m(
              useRateInput=true,
              useRateOutput=true),
            rateDRXDOut(y=if time > -ageTime then inverseProportionalFactor.y
                   else 0),
            tune_a=0.5422585325787762,
            tune_b=0.10103804976851852,
            tune_c=3.043536358648205
                          );
          Modelica.Blocks.Continuous.Integrator integrator
            annotation (Placement(transformation(extent={{26,-66},{46,-46}})));
          Modelica.Blocks.Sources.Constant const(k=0.066*tune_c)
            annotation (Placement(transformation(extent={{40,8},{60,28}})));
          Bodylight.Blocks.Factors.InverseProportionalFactor inverseProportionalFactor(
              scalingFactor=1,   enabled=true)
            annotation (Placement(transformation(extent={{90,-18},{70,2}})));
          parameter Real IfADP=0.1
            "Intesity of free mADP as a fraction of mATP intensity";
          Modelica.Blocks.Math.Division dillutionEffect "Relative to initial"
            annotation (Placement(transformation(extent={{60,-72},{80,-52}})));
          Modelica.Blocks.Math.Division a_times_u
            annotation (Placement(transformation(extent={{90,-82},{110,-62}})));
          Modelica.Blocks.Sources.Constant K_ADP(k=1)
            annotation (Placement(transformation(extent={{60,-92},{74,-78}})));
          Modelica.Blocks.Sources.RealExpression dillutionConst(y=if time > 0 then 4
                 elseif time > -ageTime then 2 else 1)
            annotation (Placement(transformation(extent={{24,-96},{38,-82}})));
          parameter Bodylight.Types.Fraction f_load_mix=2;
        equation
          connect(const.y, inverseProportionalFactor.yBase)
            annotation (Line(points={{61,18},{80,18},{80,-6}}, color={0,0,127}));
          connect(kH_m.popChangeOutput, integrator.u) annotation (Line(points={{-10,-28},
                  {-18,-28},{-18,-56},{24,-56}},                   color={0,0,127}));
          connect(integrator.y, dillutionEffect.u1)
            annotation (Line(points={{47,-56},{58,-56}}, color={0,0,127}));
          connect(a_times_u.y, inverseProportionalFactor.u) annotation (Line(
                points={{111,-72},{116,-72},{116,-8},{88,-8}}, color={0,0,127}));
          connect(dillutionEffect.y, a_times_u.u1) annotation (Line(points={{81,-62},
                  {84,-62},{84,-66},{88,-66}}, color={0,0,127}));
          connect(K_ADP.y, a_times_u.u2) annotation (Line(points={{74.7,-85},{80,
                  -85},{80,-78},{88,-78}}, color={0,0,127}));
          connect(dillutionConst.y, dillutionEffect.u2) annotation (Line(points={
                  {38.7,-89},{50,-89},{50,-68},{58,-68}}, color={0,0,127}));
          annotation (experiment(
              StartTime=-1500,
              StopTime=1500,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"), Diagram(graphics={Line(points={{80,-12},{40,-12},
                      {46,-8}}, color={28,108,200})}));
        end XBCycling_Hooijman_CalcADPDil;
      end ADPEffect;

      package ATPDepletion
        model XBCycling_Hooijman_CalcATPDepl
          "Generating ADP, having a slow-down effect on DRX_D to DRX_T transition"
          extends XBCycling(
            kH(useRateOutput=true),
            kH_m(
              useRateInput=true,
              useRateOutput=true),
            rateDRXDOut(y=if time > -ageTime then inverseProportionalFactor.y
                   else 0),
            tune_a=0.5422585325787762,
            tune_b=0.10103804976851852,
            tune_c=3.043536358648205,
            k2(useRateOutput=true)
                          );
          Modelica.Blocks.Continuous.Integrator integrator
            annotation (Placement(transformation(extent={{26,-66},{46,-46}})));
          Modelica.Blocks.Sources.Constant const(k=0.066*tune_c)
            annotation (Placement(transformation(extent={{40,8},{60,28}})));
          Bodylight.Blocks.Factors.InverseProportionalFactor inverseProportionalFactor(
              scalingFactor=1,   enabled=true)
            annotation (Placement(transformation(extent={{90,-18},{70,2}})));
          parameter Real IfADP=0.1
            "Intesity of free mADP as a fraction of mATP intensity";
          Modelica.Blocks.Math.Division dillutionEffect "Relative to initial"
            annotation (Placement(transformation(extent={{60,-72},{80,-52}})));
          Modelica.Blocks.Math.Division a_times_u
            annotation (Placement(transformation(extent={{90,-82},{110,-62}})));
          Modelica.Blocks.Sources.Constant K_ADP(k=1)
            annotation (Placement(transformation(extent={{60,-92},{74,-78}})));
          Modelica.Blocks.Sources.RealExpression dillutionConst(y=if time > 0 then 4
                 elseif time > -ageTime then 2 else 1)
            annotation (Placement(transformation(extent={{24,-96},{38,-82}})));
          parameter Bodylight.Types.Fraction f_load_mix=2;
          Modelica.Blocks.Math.Add add
            annotation (Placement(transformation(extent={{-14,-58},{-8,-52}})));
        equation
          connect(const.y, inverseProportionalFactor.yBase)
            annotation (Line(points={{61,18},{80,18},{80,-6}}, color={0,0,127}));
          connect(integrator.y, dillutionEffect.u1)
            annotation (Line(points={{47,-56},{58,-56}}, color={0,0,127}));
          connect(a_times_u.y, inverseProportionalFactor.u) annotation (Line(
                points={{111,-72},{116,-72},{116,-8},{88,-8}}, color={0,0,127}));
          connect(dillutionEffect.y, a_times_u.u1) annotation (Line(points={{81,-62},
                  {84,-62},{84,-66},{88,-66}}, color={0,0,127}));
          connect(K_ADP.y, a_times_u.u2) annotation (Line(points={{74.7,-85},{80,
                  -85},{80,-78},{88,-78}}, color={0,0,127}));
          connect(dillutionConst.y, dillutionEffect.u2) annotation (Line(points={
                  {38.7,-89},{50,-89},{50,-68},{58,-68}}, color={0,0,127}));
          connect(k2.popChangeOutput, add.u2) annotation (Line(points={{-28,-56},
                  {-24,-56},{-24,-56.8},{-14.6,-56.8}}, color={0,0,127}));
          connect(kH_m.popChangeOutput, add.u1) annotation (Line(points={{-10,
                  -28},{-10,-53.2},{-14.6,-53.2}}, color={0,0,127}));
          connect(add.y, integrator.u) annotation (Line(points={{-7.7,-55},{-2,
                  -55},{-2,-56},{24,-56}}, color={0,0,127}));
          annotation (experiment(
              StartTime=-1500,
              StopTime=1500,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"), Diagram(graphics={Line(points={{80,-12},{40,-12},
                      {46,-8}}, color={28,108,200})}));
        end XBCycling_Hooijman_CalcATPDepl;
      end ATPDepletion;
    end Hooijman;

    package Walklate

      package Fig1AReported
        model XBCyclingSrxT_Walklate2022Fig1A
          "Additional model parametrization to fit Walklate 2022 fig 1A"
          extends Hooijman.XBCycling(
            rho=0,
            tune_a=0.3061467550165379,
            tune_b=0.1947624404223471,
            tune_c=0.411047421686107,
            DRX_D(pop_start=max(1e-6, 0.95 - A2.pop_start)),
            SRX(pop_start=1e-6),
            kH_m(useRateInput=true),
            ageTime=60.0,
            redeclare Data.TimeTable_ATPChaseWalklate1A timeTable_ATPChase,
            A2(pop_start=0.4));
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"),
              experiment(
              StartTime=-300,
              StopTime=1000,
              __Dymola_Algorithm="Dassl"));
        end XBCyclingSrxT_Walklate2022Fig1A;

        model XBCyclingSrxD_Walklate2022Fig1A
          "Additional model parametrization to fit Walklate 2022 fig 1A"
          extends Configurations.XBCyclingSrxD(
            rho=0,
            tune_a=0.5637507976074201,
            tune_b=0.5024787422559087,
            tune_c=0.3612922249492135,
            DRX_D(pop_start=max(1e-6, 0.95 - A2.pop_start)),
            SRX(pop_start=1e-6),
            kH_m(useRateInput=true),
            ageTime=60.0,
            redeclare Data.TimeTable_ATPChaseWalklate1A timeTable_ATPChase,
            A2(pop_start=0.4));
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"),
              experiment(
              StartTime=-300,
              StopTime=1000,
              __Dymola_Algorithm="Dassl"));
        end XBCyclingSrxD_Walklate2022Fig1A;

        model XBCyclingSrxD_Walklate2022Fig1A_optimized
          "Optimized model parameters of mantATP.DataMatched.Walklate.Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A"
          extends
            mantATP.DataMatched.Walklate.Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A(
            tune_a=0.5637507976074201,
            tune_b=0.5024787422559087,
            tune_c=0.3612922249492135);

          /* Automatically generated at Mon Sep 22 10:39:52 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #201
        2.7935543522299163e-6     min    sqDiffIntegrator.y
    __________________________________________________
        2.7935543522299163e-6    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.DataMatched.Walklate.Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.305452,
                                min=0,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.194352,
                                min=0,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.408956,
                                min=0,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="sqDiffIntegrator.y",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.pattern,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=1.0000000000000001e-5,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=false,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-600,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=1e-4,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info=
                  "<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end XBCyclingSrxD_Walklate2022Fig1A_optimized;
      end Fig1AReported;

      package Fig1AResampled
          model XBCycling_Walklate2022Fig1ASample
            "Additional model parametrization to fit Walklate 2022, for what is actually on the figure"
            extends Hooijman.XBCycling(
            rho=0,
            tune_a=0.47714596212094834,
            tune_b=0.3218660267856397,
            tune_c=0.5102558398635814,
            DRX_D(pop_start=max(1e-6, 0.95 - A2.pop_start)),
            SRX(pop_start=1e-6),
            kH_m(useRateInput=true),
            ageTime=60.0,
            redeclare Data.TimeTable_ATPChaseWalklate1A timeTable_ATPChase(
              offset=0.9904,
              P1=0.04433,
              P2=0.02459,
              T1(displayUnit="s") = 29.75,
              T2(displayUnit="s") = 179.2),
            A2(pop_start=0.4));
            annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"),
                experiment(
                StartTime=-300,
                StopTime=1000,
                __Dymola_Algorithm="Dassl"));
          end XBCycling_Walklate2022Fig1ASample;
      end Fig1AResampled;

      package RigorFraction
        model Walklate_A20
          extends
            Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            A2(pop_start=1e-6),
            tune_a=0.3058400471361393,
            tune_b=0.21476862145794864,
            tune_c=0.4082854046151003);
        end Walklate_A20;

        model Walklate_A220
          extends
            Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            A2(pop_start=0.2, pop(start=0.2, displayUnit="1")),
            tune_a=0.3163674926113997,
            tune_b=0.21133823469097335,
            tune_c=0.4126046836618069,
            DRX_D(pop(start=0.75, displayUnit="1")),
            DRX_T(pop(start=0.049999000000000016, displayUnit="1")),
            SRX(pop(start=1E-06, displayUnit="1")));
        end Walklate_A220;

        model Walklate_A240
          extends
            Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A;
        end Walklate_A240;

        model Walklate_A260
          extends
            Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            A2(pop_start=0.6),
            tune_a=0.30163772576569653,
            tune_b=0.18443964196576076,
            tune_c=0.40920519170412983);
        end Walklate_A260;

        model Walklate_A280
          extends
            Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            A2(pop_start=0.8),
            tune_a=0.30527147286652623,
            tune_b=0.1802006232076229,
            tune_c=0.4108179205162075);
        end Walklate_A280;

        model Walklate_A2100
          extends
            Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            A2(pop_start=1),
            tune_a=0.29924321019171984,
            tune_b=0.17103469345304823,
            tune_c=0.40878820550689926);
        end Walklate_A2100;

        model Walklate_RigorFor300s
          extends
            Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            rateDRXDOut(y=if time > -ageTime or time < -RigorDuration - ageTime then 0.066
                  *tune_c else 0),
            A2(pop_start(displayUnit="1") = 1E-06),
            tune_a=0.3067597203734266,
            tune_b=0.2161271414590823,
            tune_c=0.4089845787410824);
          parameter Real RigorDuration=300.0;
          annotation (experiment(
              StartTime=-6000,
              StopTime=1000,
              __Dymola_NumberOfIntervals=5000,
              Tolerance=1e-05,
              __Dymola_Algorithm="Cvode"));
        end Walklate_RigorFor300s;

        model Walklate_RigorFor120s
          extends
            Walklate_RigorFor300s(RigorDuration=120.0,
            tune_a=0.3063957837352183,
            tune_b=0.2168638192610709,
            tune_c=0.4087731993688888);
          annotation (experiment(
              StartTime=-6000,
              StopTime=1000,
              __Dymola_NumberOfIntervals=5000,
              Tolerance=1e-05,
              __Dymola_Algorithm="Cvode"));
        end Walklate_RigorFor120s;

        model Walklate_RigorFor600s
          extends Walklate_RigorFor300s(RigorDuration=600.0,
            tune_a=0.3069448139661405,
            tune_b=0.21574284955928857,
            tune_c=0.40909296051577354);
        end Walklate_RigorFor600s;

        model Walklate_RigorFor60s
          extends
            Walklate_RigorFor300s(
            RigorDuration=60,
            tune_a=0.30727215077639414,
            tune_b=0.21816494426127417,
            tune_c=0.4091000030032352);
          annotation (experiment(
              StartTime=-6000,
              StopTime=1000,
              __Dymola_NumberOfIntervals=5000,
              Tolerance=1e-05,
              __Dymola_Algorithm="Cvode"));
        end Walklate_RigorFor60s;

        model Walklate_RigorFor6000s
          extends Walklate_RigorFor300s(
            RigorDuration=6000.0,
            tune_a=0.3069448139661405,
            tune_b=0.21574284955928857,
            tune_c=0.40909296051577354);
        end Walklate_RigorFor6000s;

        model WalklateSrxD_A20
          extends
            Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A(
            A2(pop_start=1e-6),
            tune_a=0.5637507976074201,
            tune_b=0.5024787422559087,
            tune_c=0.3612922249492135);
        end WalklateSrxD_A20;

        model WalklateSrxD_A220
          extends
            Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A(
            A2(pop_start=0.2, pop(start=0.2, displayUnit="1")),
            tune_a=0.5637507976074201,
            tune_b=0.5024787422559087,
            tune_c=0.3612922249492135,
            DRX_D(pop(start=0.75, displayUnit="1")),
            DRX_T(pop(start=0.049999000000000016, displayUnit="1")),
            SRX(pop(start=1E-06, displayUnit="1")));
        end WalklateSrxD_A220;

        model WalklateSrxD_A240
          extends
            Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A;
        end WalklateSrxD_A240;

        model WalklateSrxD_A260
          extends
            Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A(
            A2(pop_start=0.6));
        end WalklateSrxD_A260;

        model WalklateSrxD_A280
          extends
            Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A(
            A2(pop_start=0.8));
        end WalklateSrxD_A280;

        model WalklateSrxD_A2100
          extends
            Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A(
            A2(pop_start=1));
        end WalklateSrxD_A2100;

        model WalklateSrxD_A20_optimized
          "Optimized model parameters of mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A20"
          extends mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A20(
            tune_a=0.5876422414550787,
            tune_b=0.5913383933105449,
            tune_c=0.360726521484375);

          /* Automatically generated at Mon Sep 22 13:38:54 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #147
        2.4420393757211812e-8     min    sqDiffIntegrator.y
    __________________________________________________
        2.4420393757211812e-8    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A20",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.563751,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.502479,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.361292,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="sqDiffIntegrator.y",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.pattern,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=1.0000000000000001e-5,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-600,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=1.0000000000000001e-5,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info=
                  "<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end WalklateSrxD_A20_optimized;

        model WalklateSrxD_A220_optimized
          "Optimized model parameters of mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A220"
          extends mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A220(
            tune_a=0.5801333913574218,
            tune_b=0.5482700881890167,
            tune_c=0.3646252965615353);

          /* Automatically generated at Mon Sep 22 13:40:26 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #185
        7.2979411569511777e-8     min    sqDiffIntegrator.y
    __________________________________________________
        7.2979411569511777e-8    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A220",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.5876422414550787,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.5913383933105449,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.360726521484375,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="sqDiffIntegrator.y",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.pattern,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=1.0000000000000001e-5,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-600,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=1.0000000000000001e-5,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info=
                  "<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end WalklateSrxD_A220_optimized;

        model WalklateSrxD_A260_optimized
          "Optimized model parameters of mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A260"
          extends mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A260(
            tune_a=0.6027864064941405,
            tune_b=0.5436306350640165,
            tune_c=0.3784960141541279);

          /* Automatically generated at Mon Sep 22 13:50:10 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #114
        7.6058532035602937e-6     min    sqDiffIntegrator.y
    __________________________________________________
        7.6058532035602937e-6    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A260",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.5801333913574218,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.5482700881890167,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.3646252965615353,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="sqDiffIntegrator.y",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.pattern,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=1.0000000000000001e-5,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-600,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=1.0000000000000001e-5,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info=
                  "<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end WalklateSrxD_A260_optimized;

        model WalklateSrxD_A280_optimized
          "Optimized model parameters of mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A280"
          extends mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A280(
            tune_a=0.571905498291015,
            tune_b=0.4855362991265159,
            tune_c=0.3690439380545906);

          /* Automatically generated at Mon Sep 22 13:52:25 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #101
        7.5357804240683574e-8     min    sqDiffIntegrator.y
    __________________________________________________
        7.5357804240683574e-8    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A280",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.6027864064941405,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.5436306350640165,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.3784960141541279,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="sqDiffIntegrator.y",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.pattern,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=1.0000000000000001e-5,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-600,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=1.0000000000000001e-5,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info=
                  "<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end WalklateSrxD_A280_optimized;

        model WalklateSrxD_A2100_optimized
          "Optimized model parameters of mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A2100"
          extends mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A2100
            (
            tune_a=0.5807580373535152,
            tune_b=0.487134172390405,
            tune_c=0.373326880762924);

          /* Automatically generated at Mon Sep 22 13:53:53 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #82
        5.3158551236541836e-7     min    sqDiffIntegrator.y
    __________________________________________________
        5.3158551236541836e-7    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.DataMatched.Walklate.RigorFraction.WalklateSrxD_A2100",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.571905498291015,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.4855362991265159,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.3690439380545906,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="sqDiffIntegrator.y",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.pattern,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=1.0000000000000001e-5,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-600,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=1.0000000000000001e-5,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info=
                  "<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end WalklateSrxD_A2100_optimized;
      end RigorFraction;

      package Photobleaching
        model XBCycling_Walklate_PB0
          "Optimized model parameters of mantATP.LabelLib.Experiments.XBCycling_Walklate_PB0001"
          extends mantATP.DataMatched.Walklate.Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            k_pb=0.0);
        end XBCycling_Walklate_PB0;

        model XBCycling_Walklate_PB0001
          "Optimized model parameters of mantATP.LabelLib.Experiments.XBCycling_Walklate_PB0001"
          extends mantATP.DataMatched.Walklate.Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            k_pb=0.0001,
            tune_a=0.2999647012702542,
            tune_b=0.1969634880622235,
            tune_c=0.4105968172850947);

          /* Automatically generated at Tue Jun 24 16:49:04 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #199
        5.7321112482966039e-7     min    integratedSquaredDeviation.y1
    __________________________________________________
        5.7321112482966039e-7    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.LabelLib.Experiments.XBCycling_Walklate_PB0001",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.2896065318685678,
                                min=0,
                                max=2,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.0951688822110495,
                                min=0,
                                max=2,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=2.0499921553268061,
                                min=0,
                                max=40,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="integratedSquaredDeviation.y1",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.pattern,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=9.9999999999999995e-7,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-300,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=9.9999999999999995e-7,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=16,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end XBCycling_Walklate_PB0001;

        model XBCycling_Walklate_PB0005
          "Testing exponential photobleaching, can fit perfectly"
          import mantATP;
          extends mantATP.DataMatched.Walklate.Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            k_pb=0.0005,
            tune_a=0.2637990189279383,
            tune_b=0.19599777042865804,
            tune_c=0.40160381563862774
                                    );
          annotation (experiment(
              StartTime=-1600,
              StopTime=1500,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"));
        end XBCycling_Walklate_PB0005;

        model XBCycling_Walklate_PB001
          "Testing exponential photobleaching, can fit perfectly"
          import mantATP;
          extends mantATP.DataMatched.Walklate.Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            k_pb=0.001,
            tune_a=0.22776069898941942,
            tune_b=0.20220343838814298,
            tune_c=0.397167404001727);
          annotation (experiment(
              StartTime=-1600,
              StopTime=1500,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"));
        end XBCycling_Walklate_PB001;

        model XBCycling_Walklate_PB002
          "Testing exponential photobleaching, can fit perfectly"
          import mantATP;
          extends mantATP.DataMatched.Walklate.Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            k_pb=0.002,
            tune_a=0.14554115288972047,
            tune_b=0.20556008636951503,
            tune_c=0.3795216575764358
                                    );
          annotation (experiment(
              StartTime=-1600,
              StopTime=1500,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"));
        end XBCycling_Walklate_PB002;

        model XBCycling_Walklate_PB001_T0
          extends Photobleaching.XBCycling_Walklate_PB001(photobleachingTime=0);
        end XBCycling_Walklate_PB001_T0;

        model XBCycling_Walklate_PB005
          "Testing photobleaching, cant fit anymore"
          extends Photobleaching.XBCycling_Walklate_PB001(
            k_pb=0.005,
            tune_a=1.1728320088683405E-08,
            tune_b=0.29813621580600796,
            tune_c=0.38470060908711257);
        end XBCycling_Walklate_PB005;

        model XBCycling_Walklate_PB01
          "Testing photobleaching, cant fit anymore"
          extends Photobleaching.XBCycling_Walklate_PB001(
            k_pb=0.01,
            tune_a=0.009993407751094915,
            tune_b=0.3036857369135465,
            tune_c=0.39164688836017886);
        end XBCycling_Walklate_PB01;

        model XBCycling_Walklate_PBAlt002
          "Testing exponential photobleaching, can fit perfectly"
          import mantATP;
          extends mantATP.DataMatched.Walklate.Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            k_pb=0.002,
            tune_a=0.14554115288972047,
            tune_b=0.20556008636951503,
            tune_c=0.3795216575764358,
            totalLabel_PB=totalLabel.y*photobleaching2
                                    );
          Real photobleaching2 = exp(-(time+ageTime)*k_pb);
          annotation (experiment(
              StartTime=-1600,
              StopTime=1500,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"));
        equation


        end XBCycling_Walklate_PBAlt002;

        model XBCycling_Walklate_PBAlt2002
          "Testing exponential photobleaching, can fit perfectly"
          import mantATP;
          extends mantATP.DataMatched.Walklate.Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            k_pb=0.000,
            tune_a=0.14554115288972047,
            tune_b=0.20556008636951503,
            tune_c=0.3795216575764358
                                    );
          parameter Real k_bpIsim = 0.002;
          Real totalLabelNorm2 = totalLabelNorm * exp(-(time+ageTime)*k_bpIsim);
          annotation (experiment(
              StartTime=-1600,
              StopTime=1500,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"));
        equation

        end XBCycling_Walklate_PBAlt2002;
      end Photobleaching;

      package ADPEffect

        package ImpureATP "Assuming certain ADP content in the ATP solution"
          model XBCycling_Walklate_CalcADPDil_kADP1
            "Generating ADP, having a slow-down effect on DRX_D to DRX_T transition"
            extends Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
              rho=0,
              ageTime(displayUnit="s"),
              CATP(displayUnit="uM") = 0.25,
              CmantATP(displayUnit="uM") = 0.01,
              tune_a=0.2956462422611227,
              tune_b=0.1409681279823657,
              tune_c=0.7113381277309466,
              kH(useRateOutput=true),
              kH_m(
                useRateInput=true,
                useRateOutput=true),
              rateDRXDOut(y=if time > -ageTime then inverseProportionalFactor.y
                     else 0));
            Modelica.Blocks.Continuous.Integrator integrator(
              k=CMyo,                                        use_reset=false, use_set=false)
              annotation (Placement(transformation(extent={{30,-60},{40,-50}})));
            Modelica.Blocks.Sources.Constant const(k=0.066*tune_c)
              annotation (Placement(transformation(extent={{50,0},{60,10}})));
            Bodylight.Blocks.Factors.InverseProportionalFactor inverseProportionalFactor(
                scalingFactor=1,   enabled=true)
              annotation (Placement(transformation(extent={{80,-20},{60,0}})));
            parameter Real IfADP=0.1
              "Intesity of free mADP as a fraction of mATP intensity";
            Modelica.Blocks.Math.Division dilutionEffect "Relative to initial"
              annotation (Placement(transformation(extent={{82,-66},{92,-56}})));
            Modelica.Blocks.Math.Division a_times_u
              annotation (Placement(transformation(extent={{104,-74},{114,-64}})));
            Modelica.Blocks.Sources.Constant K_ADP(k=Ki_ADP)
              annotation (Placement(transformation(extent={{82,-82},{92,-72}})));
            Modelica.Blocks.Sources.RealExpression singleDilution(y=if time >= 0 then 2
                   elseif time >= -ageTime then 1 else 1)
              annotation (Placement(transformation(extent={{22,-102},{36,-88}})));
            parameter Bodylight.Types.Fraction f_load_mix=2;
            Bodylight.Blocks.BooleanPulseN booleanPulseN(
              nperiod=2,
              period(displayUnit="s") = ageTime,
              startTime(displayUnit="s") = -ageTime)
              annotation (Placement(transformation(extent={{92,-48},{84,-40}})));
            Bodylight.Blocks.Stack stack(startTime(displayUnit="s"), outputVector={0.0,
                  CmantATP*fADP,CATP*fADP})
              annotation (Placement(transformation(extent={{78,-48},{70,-40}})));
            Modelica.Blocks.Math.MultiSum multiSum(nu=2)
              annotation (Placement(transformation(extent={{60,-62},{68,-54}})));
            parameter Bodylight.Types.Fraction fADP(displayUnit="%")=0.005
                                                            "Fraction of ADP in ATP solution";
            parameter Bodylight.Types.Concentration CMyo(displayUnit="nM")=
              0.0001;
            parameter Bodylight.Types.Concentration Ki_ADP(displayUnit="uM")=
              0.001
              "K_DD ADP inhibition constant";
            Modelica.Blocks.Logical.Switch switch1
              annotation (Placement(transformation(extent={{60,-90},{70,-80}})));
            Modelica.Blocks.Sources.RealExpression doubleDilution(y=if time >= 0 then 4
                   elseif time >= -ageTime then 2 else 1)
              annotation (Placement(transformation(extent={{22,-80},{36,-66}})));
            Modelica.Blocks.Sources.BooleanExpression IsDoubleDillution(y=false)
              annotation (Placement(transformation(extent={{30,-92},{44,-78}})));
          equation
            connect(const.y, inverseProportionalFactor.yBase)
              annotation (Line(points={{60.5,5},{70,5},{70,-8}}, color={0,0,127}));
            connect(kH_m.popChangeOutput, integrator.u) annotation (Line(points={{-10,-28},
                    {-16,-28},{-16,-55},{29,-55}},                   color={0,0,127}));
            connect(a_times_u.y, inverseProportionalFactor.u) annotation (Line(
                  points={{114.5,-69},{118,-69},{118,-10},{78,-10}},
                                                                 color={0,0,127}));
            connect(dilutionEffect.y, a_times_u.u1) annotation (Line(points={{
                    92.5,-61},{98,-61},{98,-66},{103,-66}}, color={0,0,127}));
            connect(K_ADP.y, a_times_u.u2) annotation (Line(points={{92.5,-77},{98,-77},
                    {98,-72},{103,-72}},     color={0,0,127}));
            connect(integrator.y, multiSum.u[1]) annotation (Line(points={{40.5,-55},{58,
                    -55},{58,-58.7},{60,-58.7}},
                                            color={0,0,127}));
            connect(multiSum.y, dilutionEffect.u1) annotation (Line(points={{
                    68.68,-58},{81,-58}}, color={0,0,127}));
            connect(booleanPulseN.y, stack.u) annotation (Line(points={{83.6,-44},{84,-44},
                    {84,-44.08},{77.84,-44.08}}, color={255,0,255}));
            connect(stack.y, multiSum.u[2]) annotation (Line(points={{69.6,-44},{56,-44},
                    {56,-57.3},{60,-57.3}},                  color={0,0,127}));
            connect(dilutionEffect.u2, switch1.y) annotation (Line(points={{81,
                    -64},{74,-64},{74,-85},{70.5,-85}}, color={0,0,127}));
            connect(IsDoubleDillution.y, switch1.u2)
              annotation (Line(points={{44.7,-85},{59,-85}}, color={255,0,255}));
            connect(doubleDilution.y, switch1.u1) annotation (Line(points={{36.7,-73},{48,
                    -73},{48,-81},{59,-81}}, color={0,0,127}));
            connect(singleDilution.y, switch1.u3) annotation (Line(points={{36.7,-95},{48,
                    -95},{48,-90},{59,-90},{59,-89}}, color={0,0,127}));
            annotation (experiment(
                StartTime=-1500,
                StopTime=1500,
                __Dymola_NumberOfIntervals=1500,
                Tolerance=1e-06,
                __Dymola_Algorithm="Cvode"), Diagram(coordinateSystem(extent={{-100,-100},
                      {120,100}}),                   graphics={Line(points={{68,-14},{38,
                        -14},{44,-10}},
                                  color={28,108,200})}),
              Icon(coordinateSystem(extent={{-100,-100},{120,100}})));
          end XBCycling_Walklate_CalcADPDil_kADP1;

          model XBCycling_Walklate_CalcADPDil_kADP01
            extends ImpureATP.XBCycling_Walklate_CalcADPDil_kADP1(
              Ki_ADP(displayUnit="uM") = 0.0001,
              tune_a=0.2859567394092948,
              tune_b=0.0846299611786267,
              tune_c=3.7530461609525245);
          end XBCycling_Walklate_CalcADPDil_kADP01;

          model XBCycling_Walklate_CalcADPDil_kADP02
            extends ImpureATP.XBCycling_Walklate_CalcADPDil_kADP1(
              K_ADP(k=0.2),
              tune_a=0.3192617765196558,
              tune_b=0.20151801261682287,
              tune_c=0.39082746183399425,
              timeTable_ATPChase(offset=0.04206972729281415)
                                          );
          end XBCycling_Walklate_CalcADPDil_kADP02;

          model XBCycling_Walklate_CalcADPDil_kADP10
            extends ImpureATP.XBCycling_Walklate_CalcADPDil_kADP1(
              Ki_ADP=0.01,
              tune_a=0.2979426627890374,
              tune_b=0.1855759225075695,
              tune_c=0.4216394469735381);
          end XBCycling_Walklate_CalcADPDil_kADP10;

          model XBCycling_Walklate_CalcADPDil_kADP100
            extends ImpureATP.XBCycling_Walklate_CalcADPDil_kADP1(
              Ki_ADP=0.1,
              tune_a=0.2979426627890374,
              tune_b=0.1855759225075695,
              tune_c=0.4216394469735381);
            Bodylight.Types.RealIO.ConcentrationOutput cADP annotation (Placement(
                  transformation(extent={{100,-54},{112,-42}}), iconTransformation(extent
                    ={{100,-54},{112,-42}})));
          equation
            connect(dilutionEffect.y, cADP) annotation (Line(points={{92.5,-61},
                    {96,-61},{96,-48},{106,-48}}, color={0,0,127}));
          end XBCycling_Walklate_CalcADPDil_kADP100;
        end ImpureATP;

        model XBCycling_Walklate_CalcADPDil_kADP1
          "Generating ADP, having a slow-down effect on DRX_D to DRX_T transition"
          extends Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
            rho=0,
            ageTime(displayUnit="s"),
            CATP(displayUnit="uM") = 0.25,
            CmantATP(displayUnit="uM") = 0.01,
            tune_a=0.3031117177483348,
            tune_b=0.1835814876688861,
            tune_c=0.4418693072806226,
            kH(useRateOutput=true),
            kH_m(
              useRateInput=true,
              useRateOutput=true),
            rateDRXDOut(y=if time > -ageTime then inverseProportionalFactor.y
                   else 0));
          Modelica.Blocks.Continuous.Integrator integrator(
            k=CMyo,                                        use_reset=false, use_set=false)
            annotation (Placement(transformation(extent={{30,-60},{40,-50}})));
          Modelica.Blocks.Sources.Constant const(k=0.066*tune_c)
            annotation (Placement(transformation(extent={{50,0},{60,10}})));
          Bodylight.Blocks.Factors.InverseProportionalFactor inverseProportionalFactor(
              scalingFactor=1,   enabled=true)
            annotation (Placement(transformation(extent={{80,-20},{60,0}})));
          parameter Real IfADP=0.1
            "Intesity of free mADP as a fraction of mATP intensity";
          Modelica.Blocks.Math.Division dilutionEffect "Relative to initial"
            annotation (Placement(transformation(extent={{82,-66},{92,-56}})));
          Modelica.Blocks.Math.Division a_times_u
            annotation (Placement(transformation(extent={{104,-74},{114,-64}})));
          Modelica.Blocks.Sources.Constant K_ADP(k=Ki_ADP)
            annotation (Placement(transformation(extent={{82,-82},{92,-72}})));
          Modelica.Blocks.Sources.RealExpression singleDilution(y=if time >= 0 then 2
                 elseif time >= -ageTime then 1 else 1)
            annotation (Placement(transformation(extent={{22,-102},{36,-88}})));
          parameter Bodylight.Types.Fraction f_load_mix=2;
          Bodylight.Blocks.BooleanPulseN booleanPulseN(
            nperiod=2,
            period(displayUnit="s") = ageTime,
            startTime(displayUnit="s") = -ageTime)
            annotation (Placement(transformation(extent={{92,-48},{84,-40}})));
          Bodylight.Blocks.Stack stack(startTime(displayUnit="s"), outputVector={0.0,
                CmantATP*fADP,CATP*fADP})
            annotation (Placement(transformation(extent={{78,-48},{70,-40}})));
          Modelica.Blocks.Math.MultiSum multiSum(nu=2)
            annotation (Placement(transformation(extent={{60,-62},{68,-54}})));
          parameter Bodylight.Types.Fraction fADP(displayUnit="%")=0
                                                          "Fraction of ADP in ATP solution";
          parameter Bodylight.Types.Concentration CMyo(displayUnit="nM")=0.0001;
          parameter Bodylight.Types.Concentration Ki_ADP(displayUnit="uM")=
            0.001
            "K_DD ADP inhibition constant";
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{60,-90},{70,-80}})));
          Modelica.Blocks.Sources.RealExpression doubleDilution(y=if time >= 0 then 4
                 elseif time >= -ageTime then 2 else 1)
            annotation (Placement(transformation(extent={{22,-80},{36,-66}})));
          Modelica.Blocks.Sources.BooleanExpression IsDoubleDillution(y=false)
            annotation (Placement(transformation(extent={{30,-92},{44,-78}})));
        equation
          connect(const.y, inverseProportionalFactor.yBase)
            annotation (Line(points={{60.5,5},{70,5},{70,-8}}, color={0,0,127}));
          connect(kH_m.popChangeOutput, integrator.u) annotation (Line(points={{-10,-28},
                  {-16,-28},{-16,-55},{29,-55}},                   color={0,0,127}));
          connect(a_times_u.y, inverseProportionalFactor.u) annotation (Line(
                points={{114.5,-69},{118,-69},{118,-10},{78,-10}},
                                                               color={0,0,127}));
          connect(dilutionEffect.y, a_times_u.u1) annotation (Line(points={{92.5,-61},{98,
                  -61},{98,-66},{103,-66}}, color={0,0,127}));
          connect(K_ADP.y, a_times_u.u2) annotation (Line(points={{92.5,-77},{98,-77},
                  {98,-72},{103,-72}},     color={0,0,127}));
          connect(integrator.y, multiSum.u[1]) annotation (Line(points={{40.5,-55},{58,
                  -55},{58,-58.7},{60,-58.7}},
                                          color={0,0,127}));
          connect(multiSum.y, dilutionEffect.u1)
            annotation (Line(points={{68.68,-58},{81,-58}}, color={0,0,127}));
          connect(booleanPulseN.y, stack.u) annotation (Line(points={{83.6,-44},{84,-44},
                  {84,-44.08},{77.84,-44.08}}, color={255,0,255}));
          connect(stack.y, multiSum.u[2]) annotation (Line(points={{69.6,-44},{56,-44},
                  {56,-57.3},{60,-57.3}},                  color={0,0,127}));
          connect(dilutionEffect.u2, switch1.y) annotation (Line(points={{81,-64},{74,-64},
                  {74,-85},{70.5,-85}}, color={0,0,127}));
          connect(IsDoubleDillution.y, switch1.u2)
            annotation (Line(points={{44.7,-85},{59,-85}}, color={255,0,255}));
          connect(doubleDilution.y, switch1.u1) annotation (Line(points={{36.7,-73},{48,
                  -73},{48,-81},{59,-81}}, color={0,0,127}));
          connect(singleDilution.y, switch1.u3) annotation (Line(points={{36.7,-95},{48,
                  -95},{48,-90},{59,-90},{59,-89}}, color={0,0,127}));
          annotation (experiment(
              StartTime=-1500,
              StopTime=1500,
              __Dymola_NumberOfIntervals=1500,
              Tolerance=1e-06,
              __Dymola_Algorithm="Cvode"), Diagram(coordinateSystem(extent={{-100,-100},
                    {120,100}}),                   graphics={Line(points={{68,-14},{38,
                      -14},{44,-10}},
                                color={28,108,200})}),
            Icon(coordinateSystem(extent={{-100,-100},{120,100}})));
        end XBCycling_Walklate_CalcADPDil_kADP1;

        model XBCycling_Walklate_CalcADPDil_kADP01
          "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP01"
          extends
            XBCycling_Walklate_CalcADPDil_kADP1
            (
            Ki_ADP=0.0001,
            tune_a=0.2876374720405112,
            tune_b=0.1378270346933761,
            tune_c=0.7496312502321706);

          /* Automatically generated at Fri Jul  4 16:19:07 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #317
        4.7573836308506544e-5     min    integratedSquaredDeviation.y1
    __________________________________________________
        4.7573836308506544e-5    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP01",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.3058400471361393,
                                min=0,
                                max=2,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.2147686214579486,
                                min=0,
                                max=2,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.4087427105233035,
                                min=0,
                                max=40,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="integratedSquaredDeviation.y1",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.pattern,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=9.9999999999999995e-7,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-300,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=9.9999999999999995e-7,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=16,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end XBCycling_Walklate_CalcADPDil_kADP01;

        model XBCycling_Walklate_CalcADPDil_kADP05
          "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP01"
          extends
            XBCycling_Walklate_CalcADPDil_kADP1
            (
            Ki_ADP=0.0005,
            tune_a=0.30127944105385895,
            tune_b=0.17491267949710745,
            tune_c=0.4752277128290763);

          /* Automatically generated at Fri Jul  4 16:19:07 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #317
        4.7573836308506544e-5     min    integratedSquaredDeviation.y1
    __________________________________________________
        4.7573836308506544e-5    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP01",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.3058400471361393,
                                min=0,
                                max=2,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.2147686214579486,
                                min=0,
                                max=2,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.4087427105233035,
                                min=0,
                                max=40,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="integratedSquaredDeviation.y1",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.pattern,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=9.9999999999999995e-7,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-300,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=9.9999999999999995e-7,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=16,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end XBCycling_Walklate_CalcADPDil_kADP05;

        model XBCycling_Walklate_CalcADPDil_kADP10
          "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP10"
          extends
            XBCycling_Walklate_CalcADPDil_kADP1
            (
            Ki_ADP=0.01,
            tune_a=0.3031499725973155,
            tune_b=0.1920529880613818,
            tune_c=0.4122394632200647);

          /* Automatically generated at Fri Jul  4 14:35:08 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #302
        2.5113676461290859e-8     min    integratedSquaredDeviation.y1
    __________________________________________________
        2.5113676461290859e-8    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP10",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=1.6009507852904303,
                                min=0,
                                max=2,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0,
                                min=0,
                                max=2,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.4404693001975307,
                                min=0,
                                max=40,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="integratedSquaredDeviation.y1",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.pattern,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=9.9999999999999995e-7,
                            maxEval=1000,
                            evalBestFinal=true,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-300,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=9.9999999999999995e-7,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=16,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end XBCycling_Walklate_CalcADPDil_kADP10;

        model XBCycling_Walklate_CalcADPDil_kADP100
          "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP100"
          extends
            XBCycling_Walklate_CalcADPDil_kADP1
            (
            Ki_ADP=0.1,
            tune_a=0.3025076114862044,
            tune_b=0.1936588908391595,
            tune_c=0.4106335604422869);

          /* Automatically generated at Fri Jul  4 14:37:50 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #20
        4.6552610486074627e-7     min    integratedSquaredDeviation.y1
    __________________________________________________
        4.6552610486074627e-7    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP100",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.3031499725973155,
                                min=0,
                                max=2,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.1920529880613818,
                                min=0,
                                max=2,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.4122394632200647,
                                min=0,
                                max=40,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="integratedSquaredDeviation.y1",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.pattern,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=9.9999999999999995e-7,
                            maxEval=1000,
                            evalBestFinal=true,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-300,
                            stopTime=1e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=9.9999999999999995e-7,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=16,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end XBCycling_Walklate_CalcADPDil_kADP100;

        package DoubleMixing "Identified for single mixing at 60s, but double mixing instead, as in Walklate experiment"

          model XBCycling_Walklate_CalcADPDil_kADP1
            "Generating ADP, having a slow-down effect on DRX_D to DRX_T transition"
            extends ADPEffect.XBCycling_Walklate_CalcADPDil_kADP1(
                IsDoubleDillution(y=true));

            annotation (experiment(
                StartTime=-1500,
                StopTime=1500,
                __Dymola_NumberOfIntervals=1500,
                Tolerance=1e-06,
                __Dymola_Algorithm="Cvode"), Diagram(coordinateSystem(extent={{-100,-100},
                      {120,100}}),                   graphics={Line(points={{68,-14},{38,
                        -14},{44,-10}},
                                  color={28,108,200})}),
              Icon(coordinateSystem(extent={{-100,-100},{120,100}})));
          end XBCycling_Walklate_CalcADPDil_kADP1;

          model XBCycling_Walklate_CalcADPDil_kADP01
            "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP01"
            extends ADPEffect.XBCycling_Walklate_CalcADPDil_kADP01(
                IsDoubleDillution(y=true));
                annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
          end XBCycling_Walklate_CalcADPDil_kADP01;

          model XBCycling_Walklate_CalcADPDil_kADP05
            "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP01"
            extends ADPEffect.XBCycling_Walklate_CalcADPDil_kADP05(
                IsDoubleDillution(y=true));
                                             annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
          end XBCycling_Walklate_CalcADPDil_kADP05;

          model XBCycling_Walklate_CalcADPDil_kADP10
            "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP10"
            extends ADPEffect.XBCycling_Walklate_CalcADPDil_kADP10(
                IsDoubleDillution(y=true));
                                             annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
          end XBCycling_Walklate_CalcADPDil_kADP10;

          model XBCycling_Walklate_CalcADPDil_kADP100
            "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP100"
            extends ADPEffect.XBCycling_Walklate_CalcADPDil_kADP10(
                IsDoubleDillution(y=true));
                                             annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
          end XBCycling_Walklate_CalcADPDil_kADP100;
        end DoubleMixing;

        package mantADPAffinity
          model XBCycling_Walklate_CalcADPDilAffinity
            "Generating ADP, having a slow-down effect on DRX_D to DRX_T transition, with different ADP / mant-ADP affinity"
            extends Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
              tune_a=0.2655897929630535,
              tune_b=0.094895195683267,
              tune_c=1.401853257217013,
              kH(useRateOutput=true),
              rateDRXDOut(y=if time > -ageTime then inverseProportionalFactor.y
                     else 0),
              kH_m(useRateOutput=true)
                            );
            Modelica.Blocks.Continuous.Integrator AllADPBuilt(k=CMyo)
              annotation (Placement(transformation(extent={{18,-118},{38,-98}})));
            Modelica.Blocks.Sources.Constant const(k=0.066*tune_c)
              annotation (Placement(transformation(extent={{40,8},{60,28}})));
            Bodylight.Blocks.Factors.InverseProportionalFactor inverseProportionalFactor(
                scalingFactor=1,   enabled=true)
              annotation (Placement(transformation(extent={{90,-18},{70,2}})));
            parameter Real IfADP=0.1
              "Intesity of free mADP as a fraction of mATP intensity";
            Modelica.Blocks.Math.Division dillutionEffect "Relative to initial"
              annotation (Placement(transformation(extent={{136,-110},{156,-90}})));
            Modelica.Blocks.Math.Division a_times_u
              annotation (Placement(transformation(extent={{166,-120},{186,-100}})));
            Modelica.Blocks.Sources.Constant K_ADP(k=Ki_ADP)
              annotation (Placement(transformation(extent={{136,-130},{150,-116}})));
            parameter Bodylight.Types.Fraction f_load_mix=2;
            Modelica.Blocks.Math.Product labelFlowD_D
              annotation (Placement(transformation(extent={{36,-86},{56,-66}})));
            Bodylight.Population.LabeledPopulation.Components.LabelMeasure
              labelMeasure
              annotation (Placement(transformation(extent={{34,-48},{14,-68}})));
            Modelica.Blocks.Continuous.Integrator mantADPBuilt(k=CMyo)
              annotation (Placement(transformation(extent={{64,-86},{84,-66}})));
            Modelica.Blocks.Math.Feedback ADPBuilt
              annotation (Placement(transformation(extent={{82,-98},{102,-118}})));
            parameter Bodylight.Types.Concentration CMyo(displayUnit="nM")=
              0.0001;
            parameter Bodylight.Types.Concentration Ki_ADP(displayUnit="uM")=
              0.001
              "K_DD ADP inhibition constant";
            Modelica.Blocks.Sources.RealExpression singleDilution(y=if time >= 0 then 2
                   elseif time >= -ageTime then 1 else 1)
              annotation (Placement(transformation(extent={{58,-156},{72,-142}})));
            Modelica.Blocks.Logical.Switch switch1
              annotation (Placement(transformation(extent={{96,-144},{106,-134}})));
            Modelica.Blocks.Sources.RealExpression doubleDilution(y=if time >= 0 then 4
                   elseif time >= -ageTime then 2 else 1)
              annotation (Placement(transformation(extent={{58,-134},{72,-120}})));
            Modelica.Blocks.Sources.BooleanExpression IsDoubleDillution(y=false)
              annotation (Placement(transformation(extent={{66,-146},{80,-132}})));
            Modelica.Blocks.Math.MultiSum multiSum(k={10,1}, nu=2) annotation (
                Placement(transformation(extent={{110,-98},{122,-86}})));
          equation
            connect(const.y, inverseProportionalFactor.yBase)
              annotation (Line(points={{61,18},{80,18},{80,-6}}, color={0,0,127}));
            connect(kH_m.popChangeOutput, AllADPBuilt.u) annotation (Line(points={{-10,-28},
                    {-16,-28},{-16,-108},{16,-108}},          color={0,0,127}));
            connect(a_times_u.y, inverseProportionalFactor.u) annotation (Line(
                  points={{187,-110},{180,-110},{180,-8},{88,-8}},
                                                                 color={0,0,127}));
            connect(dillutionEffect.y, a_times_u.u1) annotation (Line(points={{157,
                    -100},{160,-100},{160,-104},{164,-104}}, color={0,0,127}));
            connect(K_ADP.y, a_times_u.u2) annotation (Line(points={{150.7,-123},{
                    156,-123},{156,-116},{164,-116}},
                                             color={0,0,127}));
            connect(labelMeasure.label, labelFlowD_D.u1) annotation (Line(
                points={{34,-62},{34,-70}},
                color={0,0,127},
                smooth=Smooth.Bezier));
            connect(labelFlowD_D.y, mantADPBuilt.u) annotation (Line(
                points={{57,-76},{57,-76},{62,-76}},
                color={0,0,127},
                smooth=Smooth.Bezier));
            connect(kH_m.popChangeOutput, labelFlowD_D.u2) annotation (Line(points=
                    {{-10,-28},{-16,-28},{-16,-82},{34,-82}}, color={0,0,127}));
            connect(labelMeasure.lpop_a, kH_m.lpop_a) annotation (Line(
                points={{24,-48},{24,-32},{10,-32}},
                color={107,45,134},
                thickness=1));
            connect(ADPBuilt.u1, AllADPBuilt.y)
              annotation (Line(points={{84,-108},{39,-108}}, color={0,0,127}));
            connect(mantADPBuilt.y, ADPBuilt.u2) annotation (Line(points={{85,-76},
                    {92,-76},{92,-100}}, color={0,0,127}));
            connect(IsDoubleDillution.y,switch1. u2)
              annotation (Line(points={{80.7,-139},{95,-139}},
                                                             color={255,0,255}));
            connect(doubleDilution.y,switch1. u1) annotation (Line(points={{72.7,-127},{84,
                    -127},{84,-135},{95,-135}},
                                             color={0,0,127}));
            connect(singleDilution.y,switch1. u3) annotation (Line(points={{72.7,-149},{84,
                    -149},{84,-144},{95,-144},{95,-143}},
                                                      color={0,0,127}));
            connect(dillutionEffect.u2, switch1.y) annotation (Line(points={{134,-106},{120,
                    -106},{120,-139},{106.5,-139}}, color={0,0,127}));
            connect(multiSum.u[1], mantADPBuilt.y) annotation (Line(points={{
                    110,-93.05},{92,-93.05},{92,-76},{85,-76}}, color={0,0,127}));
            connect(multiSum.u[2], ADPBuilt.y) annotation (Line(points={{110,
                    -90.95},{110,-94},{108,-94},{108,-108},{101,-108}}, color={
                    0,0,127}));
            connect(multiSum.y, dillutionEffect.u1) annotation (Line(points={{
                    123.02,-92},{128,-94},{134,-94}}, color={0,0,127}));
            annotation (experiment(
                StartTime=-1500,
                StopTime=1500,
                __Dymola_NumberOfIntervals=5000,
                __Dymola_Algorithm="Dassl"), Diagram(graphics={Line(points={{80,-12},{40,-12},
                        {46,-8}}, color={28,108,200})}));
          end XBCycling_Walklate_CalcADPDilAffinity;

          model XBCycling_Walklate_CalcADPDilAffinity_Ki1
            "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilAffinity"
            extends
              mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilAffinity
              (
              Ki_ADP=0.001,
              tune_a=0.2856178262093044,
              tune_b=0.1584248533734577,
              tune_c=0.676673816184675);

             annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
          end XBCycling_Walklate_CalcADPDilAffinity_Ki1;

          model XBCycling_Walklate_CalcADPDilAffinity_Ki01
            extends XBCycling_Walklate_CalcADPDilAffinity(
              Ki_ADP=0.0001,
              tune_a=0.2683648837939192,
              tune_b=0.12955066830609574,
              tune_c=3.491519666579591);
          end XBCycling_Walklate_CalcADPDilAffinity_Ki01;

          model XBCycling_Walklate_CalcADPDilAffinity_Ki10
            extends XBCycling_Walklate_CalcADPDilAffinity(
              Ki_ADP=0.01,
              tune_a=0.30007667535065724,
              tune_b=0.1872192338440164,
              tune_c=0.4329523222040748);
          end XBCycling_Walklate_CalcADPDilAffinity_Ki10;

          model XBCycling_Walklate_CalcADPDilAffinity80_Ki01
            extends XBCycling_Walklate_CalcADPDilAffinity(
              Ki_ADP=0.0001,
              tune_a=0.2684076887927046,
              tune_b=0.1252455066512397,
              tune_c=3.8311443035180721,
              A2(pop_start=0.8));
          end XBCycling_Walklate_CalcADPDilAffinity80_Ki01;

          model XBCycling_Walklate_CalcADPDilMaxAffinity_Ki01
            "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilAffinity"
            extends
              mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilAffinity
              (
              Ki_ADP=0.0001,
              tune_a=0.2856178262093044,
              tune_b=0.1584248533734577,
              tune_c=0.676673816184675,
              affinitySum(k1=1, k2=0),
              multiSum(k={10,0}));

             annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
          end XBCycling_Walklate_CalcADPDilMaxAffinity_Ki01;

          model XBCycling_Walklate_CalcADPDilMaxAffinity_Ki1
            "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilAffinity"
            extends
              mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilAffinity
              (
              Ki_ADP(displayUnit="uM") = 0.001,
              tune_a=0.308248901302806,
              tune_b=0.1901983089579486,
              tune_c=0.4410213563566371,
              affinitySum(k1=1, k2=0),
              multiSum(k={10,0}));

             annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
          end XBCycling_Walklate_CalcADPDilMaxAffinity_Ki1;

          model XBCycling_Walklate_CalcADPDilMaxAffinity_Ki10
            "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilAffinity"
            extends
              mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilAffinity
              (
              Ki_ADP(displayUnit="uM") = 0.01,
              tune_a=0.308248901302806,
              tune_b=0.1901983089579486,
              tune_c=0.4410213563566371,
              affinitySum(k1=1, k2=0),
              multiSum(k={10,0}));

             annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
          end XBCycling_Walklate_CalcADPDilMaxAffinity_Ki10;

          model XBCycling_Walklate_CalcADPDilMaxAffinityImpure_Ki1
            "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilAffinity"
            extends
              mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilAffinity
              (
              CATP(displayUnit="uM") = 0.25,
              CmantATP(displayUnit="uM") = 0.01,
              Ki_ADP(displayUnit="uM") = 0.001,
              tune_a=0.308248901302806,
              tune_b=0.1901983089579486,
              tune_c=0.4410213563566371,
              multiSum(k={1,0,1},
                       nu=3));

            Bodylight.Blocks.BooleanPulseN booleanPulseN(
              nperiod=2,
              period(displayUnit="s") = ageTime,
              startTime(displayUnit="s") = -ageTime)
              annotation (Placement(transformation(extent={{146,-54},{138,-46}})));
            Bodylight.Blocks.Stack stack(startTime(displayUnit="s"),
                outputVector={0.0,CmantATP,0}*0.05)
              annotation (Placement(transformation(extent={{132,-54},{124,-46}})));
          equation
            connect(booleanPulseN.y,stack. u) annotation (Line(points={{137.6,-50},{138,-50},
                    {138,-50.08},{131.84,-50.08}},
                                                 color={255,0,255}));
            connect(stack.y, multiSum.u[3]) annotation (Line(points={{123.6,-50},{100,-50},
                    {100,-92},{110,-92}}, color={0,0,127}));
             annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
          end XBCycling_Walklate_CalcADPDilMaxAffinityImpure_Ki1;

          package mantADPAffinity_DoubleMix
            model XBCycling_Walklate_CalcADPDilAffinity
              "Generating ADP, having a slow-down effect on DRX_D to DRX_T transition, with different ADP / mant-ADP affinity"
              extends Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
                tune_a=0.2655897929630535,
                tune_b=0.094895195683267,
                tune_c=1.401853257217013,
                kH(useRateOutput=true),
                rateDRXDOut(y=if time > -ageTime then inverseProportionalFactor.y
                       else 0),
                kH_m(useRateOutput=true)
                              );
              Modelica.Blocks.Continuous.Integrator AllADPBuilt(k=CMyo)
                annotation (Placement(transformation(extent={{18,-118},{38,-98}})));
              Modelica.Blocks.Sources.Constant const(k=0.066*tune_c)
                annotation (Placement(transformation(extent={{40,8},{60,28}})));
              Bodylight.Blocks.Factors.InverseProportionalFactor inverseProportionalFactor(
                  scalingFactor=1,   enabled=true)
                annotation (Placement(transformation(extent={{90,-18},{70,2}})));
              parameter Real IfADP=0.1
                "Intesity of free mADP as a fraction of mATP intensity";
              Modelica.Blocks.Math.Division dillutionEffect "Relative to initial"
                annotation (Placement(transformation(extent={{136,-110},{156,-90}})));
              Modelica.Blocks.Math.Division a_times_u
                annotation (Placement(transformation(extent={{166,-120},{186,-100}})));
              Modelica.Blocks.Sources.Constant K_ADP(k=Ki_ADP)
                annotation (Placement(transformation(extent={{136,-130},{150,-116}})));
              parameter Bodylight.Types.Fraction f_load_mix=2;
              Modelica.Blocks.Math.Product labelFlowD_D
                annotation (Placement(transformation(extent={{36,-86},{56,-66}})));
              Bodylight.Population.LabeledPopulation.Components.LabelMeasure
                labelMeasure
                annotation (Placement(transformation(extent={{34,-48},{14,-68}})));
              Modelica.Blocks.Continuous.Integrator mantADPBuilt(k=CMyo)
                annotation (Placement(transformation(extent={{64,-86},{84,-66}})));
              Modelica.Blocks.Math.Add affinitySum(k1=10)
                annotation (Placement(transformation(extent={{106,-100},{126,-80}})));
              Modelica.Blocks.Math.Feedback ADPBuilt
                annotation (Placement(transformation(extent={{82,-98},{102,-118}})));
              parameter Bodylight.Types.Concentration CMyo(displayUnit="nM")=
                0.0001;
              parameter Bodylight.Types.Concentration Ki_ADP(displayUnit="uM")=
                0.001
                "K_DD ADP inhibition constant";
              Modelica.Blocks.Sources.RealExpression singleDilution(y=if time >= 0 then 2
                     elseif time >= -ageTime then 1 else 1)
                annotation (Placement(transformation(extent={{58,-156},{72,-142}})));
              Modelica.Blocks.Logical.Switch switch1
                annotation (Placement(transformation(extent={{96,-144},{106,-134}})));
              Modelica.Blocks.Sources.RealExpression doubleDilution(y=if time >= 0 then 4
                     elseif time >= -ageTime then 2 else 1)
                annotation (Placement(transformation(extent={{58,-134},{72,-120}})));
              Modelica.Blocks.Sources.BooleanExpression IsDoubleDillution(y=true)
                annotation (Placement(transformation(extent={{66,-146},{80,-132}})));
            equation
              connect(const.y, inverseProportionalFactor.yBase)
                annotation (Line(points={{61,18},{80,18},{80,-6}}, color={0,0,127}));
              connect(kH_m.popChangeOutput, AllADPBuilt.u) annotation (Line(points={{-10,-28},
                      {-16,-28},{-16,-108},{16,-108}},          color={0,0,127}));
              connect(a_times_u.y, inverseProportionalFactor.u) annotation (Line(
                    points={{187,-110},{180,-110},{180,-8},{88,-8}},
                                                                   color={0,0,127}));
              connect(dillutionEffect.y, a_times_u.u1) annotation (Line(points={{157,
                      -100},{160,-100},{160,-104},{164,-104}}, color={0,0,127}));
              connect(K_ADP.y, a_times_u.u2) annotation (Line(points={{150.7,-123},{
                      156,-123},{156,-116},{164,-116}},
                                               color={0,0,127}));
              connect(labelMeasure.label, labelFlowD_D.u1) annotation (Line(
                  points={{34,-62},{34,-70}},
                  color={0,0,127},
                  smooth=Smooth.Bezier));
              connect(labelFlowD_D.y, mantADPBuilt.u) annotation (Line(
                  points={{57,-76},{57,-76},{62,-76}},
                  color={0,0,127},
                  smooth=Smooth.Bezier));
              connect(kH_m.popChangeOutput, labelFlowD_D.u2) annotation (Line(points=
                      {{-10,-28},{-16,-28},{-16,-82},{34,-82}}, color={0,0,127}));
              connect(labelMeasure.lpop_a, kH_m.lpop_a) annotation (Line(
                  points={{24,-48},{24,-32},{10,-32}},
                  color={107,45,134},
                  thickness=1));
              connect(mantADPBuilt.y, affinitySum.u1) annotation (Line(points={{85,
                      -76},{104,-76},{104,-84}}, color={0,0,127}));
              connect(affinitySum.y, dillutionEffect.u1) annotation (Line(points={{
                      127,-90},{130,-90},{130,-94},{134,-94}}, color={0,0,127}));
              connect(affinitySum.u2, ADPBuilt.y) annotation (Line(points={{104,-96},
                      {104,-108},{101,-108}}, color={0,0,127}));
              connect(ADPBuilt.u1, AllADPBuilt.y)
                annotation (Line(points={{84,-108},{39,-108}}, color={0,0,127}));
              connect(mantADPBuilt.y, ADPBuilt.u2) annotation (Line(points={{85,-76},
                      {92,-76},{92,-100}}, color={0,0,127}));
              connect(IsDoubleDillution.y,switch1. u2)
                annotation (Line(points={{80.7,-139},{95,-139}},
                                                               color={255,0,255}));
              connect(doubleDilution.y,switch1. u1) annotation (Line(points={{72.7,-127},{84,
                      -127},{84,-135},{95,-135}},
                                               color={0,0,127}));
              connect(singleDilution.y,switch1. u3) annotation (Line(points={{72.7,-149},{84,
                      -149},{84,-144},{95,-144},{95,-143}},
                                                        color={0,0,127}));
              connect(dillutionEffect.u2, switch1.y) annotation (Line(points={{134,-106},{120,
                      -106},{120,-139},{106.5,-139}}, color={0,0,127}));
              annotation (experiment(
                  StartTime=-1500,
                  StopTime=1500,
                  __Dymola_NumberOfIntervals=5000,
                  __Dymola_Algorithm="Dassl"), Diagram(graphics={Line(points={{80,-12},{40,-12},
                          {46,-8}}, color={28,108,200})}));
            end XBCycling_Walklate_CalcADPDilAffinity;

            model XBCycling_Walklate_CalcADPDilAffinity_Ki1
              "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilAffinity"
              extends
                mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.mantADPAffinity_DoubleMix.XBCycling_Walklate_CalcADPDilAffinity
                (
                Ki_ADP=0.001,
                tune_a=0.2856178262093044,
                tune_b=0.1584248533734577,
                tune_c=0.676673816184675);
              annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
            end XBCycling_Walklate_CalcADPDilAffinity_Ki1;

            model XBCycling_Walklate_CalcADPDilAffinity_Ki01
              extends XBCycling_Walklate_CalcADPDilAffinity(
                Ki_ADP=0.0001,
                tune_a=0.2683648837939192,
                tune_b=0.12955066830609574,
                tune_c=3.491519666579591);
            end XBCycling_Walklate_CalcADPDilAffinity_Ki01;

            model XBCycling_Walklate_CalcADPDilAffinity_Ki10
              extends XBCycling_Walklate_CalcADPDilAffinity(
                Ki_ADP=0.01,
                tune_a=0.30007667535065724,
                tune_b=0.1872192338440164,
                tune_c=0.4329523222040748);
            end XBCycling_Walklate_CalcADPDilAffinity_Ki10;

            model XBCycling_Walklate_CalcADPDilAffinity80_Ki01
              extends
                mantATP.DataMatched.Walklate.ADPEffect.mantADPAffinity.XBCycling_Walklate_CalcADPDilAffinity80_Ki01
                (IsDoubleDillution(y=true));
            end XBCycling_Walklate_CalcADPDilAffinity80_Ki01;
          end mantADPAffinity_DoubleMix;
        end mantADPAffinity;
      end ADPEffect;

      package Experiments

        model XBCycling_Walklate_SlowATPBinding
          "This reflects the 3.2 uM-1s-1 ATP attachment rate reported in Walklate. No difference."
          extends Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A(
                                              CmantATP=0.05, k2(k(displayUnit=
                    "1/s") = 3200*CmantATP));
          annotation (experiment(
              StartTime=-300,
              StopTime=600,
              Interval=0.001,
              __Dymola_Algorithm="Dassl"));
        end XBCycling_Walklate_SlowATPBinding;

        model XBCycling_Walklate_CalcADPDil_kADP01_ADP5
          extends ADPEffect.ImpureATP.XBCycling_Walklate_CalcADPDil_kADP01(
                        fADP=0.05,
            tune_a=0.2787141746399196,
            tune_b=0.0404736485818706,
            tune_c=14.102698115712057);
        end XBCycling_Walklate_CalcADPDil_kADP01_ADP5;

      model XBCycling_Walklate_CalcADPDil_kADP1_ADP5
        extends ADPEffect.ImpureATP.XBCycling_Walklate_CalcADPDil_kADP1(
                                                              fADP=0.05,    tune_a=0.2848234228228876,
          tune_b=0.0761985349130673,
          tune_c=1.7351668176631261);
      end XBCycling_Walklate_CalcADPDil_kADP1_ADP5;

      model XBCycling_Walklate_CalcADPDil_kADP10_ADP5
        extends ADPEffect.ImpureATP.XBCycling_Walklate_CalcADPDil_kADP10(
                                                     fADP=0.05,
          tune_a=0.2981978285774345,
          tune_b=0.1629629939655471,
          tune_c=0.5392855445983218);
      end XBCycling_Walklate_CalcADPDil_kADP10_ADP5;

        model XBCycling_Walklate_CalcADPDil_kADP01_ADP01
          extends ADPEffect.ImpureATP.XBCycling_Walklate_CalcADPDil_kADP01(
                                                       fADP=0.001,
                tune_a=0.2961589569046533,
            tune_b=0.137288406899978,
            tune_c=0.8848250885534156);
        end XBCycling_Walklate_CalcADPDil_kADP01_ADP01;

        model XBCycling_Walklate_CalcADPDil_kADP1_ADP01
          "Optimized model parameters of mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP1_ADP01"
          extends
            ADPEffect.ImpureATP.XBCycling_Walklate_CalcADPDil_kADP01(
              fADP=0.001,
            tune_a=0.3023170951059688,
            tune_b=0.1820706094286031,
            tune_c=0.4524206918805784);

          /* Automatically generated at Fri Jun 20 21:06:25 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #20
        4.871447476444905e-7      min    integratedSquaredDeviation.y1
    __________________________________________________
        4.871447476444905e-7     Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP1_ADP01",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.2961589569046533,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.137288406899978,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.8848250885534156,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="integratedSquaredDeviation.y1",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.sqp,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=9.9999999999999995e-7,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-300,
                            stopTime=1.5e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=9.9999999999999995e-7,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end XBCycling_Walklate_CalcADPDil_kADP1_ADP01;

        model XBCycling_Walklate_CalcADPDil_kADP10_ADP01
          "Optimized model parameters of mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP10_ADP01"
          extends
            mantATP.DataMatched.Walklate.ADPEffect.ImpureATP.XBCycling_Walklate_CalcADPDil_kADP10(
              fADP=0.001,
            tune_a=0.3030936499331026,
            tune_b=0.192069297470121,
            tune_c=0.4130306071237762);

          /* Automatically generated at Fri Jun 20 21:08:14 2025 */
          /*
    The final optimization result was as follows:
    
    Evaluation #8
        2.7252208681999349e-8     min    integratedSquaredDeviation.y1
    __________________________________________________
        2.7252208681999349e-8    Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.LabelLib.Experiments.XBCycling_Walklate_CalcADPDil_kADP10_ADP01",
            plotScript="",
            saveSetup=true,
            saveSetupFilename="OptimizationLastRunModel.mo",
            convertSetup=false,
            askForTunerReUse=true,
            tuner=
                Optimization.Internal.Version.V22.Tuner(
                    UseTunerMatrixForDiscreteValues=false,
                    tunerParameters=
                        {
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_a",
                                active=true,
                                Value=0.3023170951059688,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.1820706094286031,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.4524206918805784,
                                min=-10,
                                max=10,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit="")
                        },
                    tunerMatrix=
                        zeros(0,1)),
            criteria=
                {
                    Optimization.Internal.Version.V22.Criterion(
                        name="integratedSquaredDeviation.y1",
                        active=true,
                        usage=Optimization.Internal.Version.V22.Types.CriterionUsage.Minimize,
                        demand=1,
                        unit="s")
                },
            preferences=
                Optimization.Internal.Version.V22.Preferences(
                    optimizationOptions=
                        Optimization.Internal.Version.V22.OptimizationOptions(
                            method=Optimization.Internal.Version.V22.Types.OptimizationMethod.sqp,
                            ObjectiveFunctionType=Optimization.Internal.Version.V22.Types.ObjectiveFunctionType.Max,
                            OptTol=9.9999999999999995e-7,
                            maxEval=1000,
                            evalBestFinal=false,
                            saveBest=true,
                            saveHistory=true,
                            listFilename="OptimizationLog.log",
                            listOn=true,
                            listOnline=true,
                            listIncrement=100,
                            numberOfShownDigits=3,
                            onPlace=true,
                            listTuners=true,
                            GaPopSize=10,
                            GaNGen=100,
                            GridBlock=50),
                    simulationOptions=
                        Optimization.Internal.Version.V22.SimulationOptions(
                            startTime=-300,
                            stopTime=1.5e+3,
                            outputInterval=0,
                            numberOfIntervals=1500,
                            integrationMethod=Optimization.Internal.Version.V22.Types.IntegrationMethod.Cvode,
                            integrationTolerance=9.9999999999999995e-7,
                            fixedStepSize=0,
                            autoLoadResults=true,
                            useDsFinal=true,
                            translateModel=false,
                            setCriteriaSimulationFailed=true,
                            CriteriaSimulationFailedValue=1e+6,
                            simulationMode=Optimization.Internal.Version.V22.Types.SimulationMode.Single,
                            parallelizationMode=Optimization.Internal.Version.V22.Types.ParallelizationMode.None,
                            numberOfThreads=0,
                            copyFiles=
                            fill("",0)),
                    sensitivityOptions=
                        Optimization.Internal.Version.V22.SensitivityOptions(
                            TypeOfSensitivityComputation=Optimization.Internal.Version.V22.Types.SensitivityMethod.ExternalDifferencesSymmetric,
                            automaticSensitivityTolerance=true,
                            sensitivityTolerance=9.9999999999999995e-7))))
 */
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end XBCycling_Walklate_CalcADPDil_kADP10_ADP01;

        model XBCycling_CalcRho
          extends Hooijman.XBCycling(
            CATP=1,
            CmantATP=1 - (0.66 + 0.27),
            tune_a=0.5294380431849212,
            tune_b=0.0936276241417932,
            tune_c=1.0886986660156932);
          annotation (experiment(
              StartTime=-300,
              StopTime=1000,
              __Dymola_NumberOfIntervals=1500,
              __Dymola_Algorithm="Dassl"));
        end XBCycling_CalcRho;

      end Experiments;
    end Walklate;
  end DataMatched;

  package Figures

    model DefaultH
      extends DataMatched.Hooijman.XBCycling;
      annotation (experiment(
          StartTime=-1200,
          StopTime=600,
          __Dymola_NumberOfIntervals=5000,
          __Dymola_Algorithm="Dassl"));
    end DefaultH;

    model DefaultW
      extends DataMatched.Walklate.Fig1AReported.XBCyclingSrxT_Walklate2022Fig1A;
      annotation (experiment(
          StartTime=-1200,
          StopTime=600,
          __Dymola_NumberOfIntervals=5000,
          __Dymola_Algorithm="Dassl"));
    end DefaultW;

    model Walklate_PB
      extends DataMatched.Walklate.Photobleaching.XBCycling_Walklate_PB001;
    end Walklate_PB;

    model Walklate_CalcMantADP
      extends DataMatched.Hooijman.Experiments.XBCycling_Walklate_CalcMantADP;
    end Walklate_CalcMantADP;

    model Walklate_CalcADP
      extends DataMatched.Hooijman.Experiments.XBCycling_Walklate_CalcADP;
    end Walklate_CalcADP;
  end Figures;

  package Diffusion


    model Unnamed
      parameter Integer N = 10 "Number of radial compartments";
      parameter Real R = 0.01 "Radius [m]";
      parameter Real D=1e-10 "Diffusion coefficient [m^2/s]"
        annotation (Evaluate=false);
      parameter Real ATP_ext = 5e-3 "ATP concentration at boundary";
      parameter Real ProdRate=1e-7 "ATP production rate per volume"
        annotation (Evaluate=false);
      parameter Real pi = Modelica.Constants.pi;
      parameter Real dr = R / N;
      parameter Real[:] r = { (i - 0.5)*dr for i in 1:N};
      parameter Real[:] V = { pi * ((i*dr)^2 - ((i-1)*dr)^2) * 1.0 for i in 1:N};
      parameter Real[:] A = { 2 * pi * r[i] * 1.0 for i in 1:N};
      Real C[N](start=fill(ATP_ext/2, N)) "ATP concentration in each layer";
    equation
      for i in 1:N loop
        der(C[i]) = (
          (if i == 1 then 0 else D * A[i-1] * (C[i-1] - C[i]) / dr)
          +
          (if i == N then D * A[i] * (ATP_ext - C[i]) / dr else D * A[i] * (C[i+1] - C[i]) / dr)
          +
          ProdRate * V[i])      / V[i];
      end for;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
                                                                                   // 1m height assumed
                                                                  // surface area between compartments

      // Diffusion and production in each layer


    end Unnamed;
  end Diffusion;

  package Configurations
    model XBCyclingSrxT
      "Default model parametrization to fit Hooijman 2011 mantATP chased by ATP."

      extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.RealExpression rateDRXDOut(y=if time > -ageTime
             then 0.066*tune_c else 0)
        annotation (Placement(transformation(extent={{36,-20},{16,0}})));
    //  parameter Real offset=0 "Offsets of output signals";
      replaceable Data.TimeTable_ATPChaseHooijman2011 timeTable_ATPChase(offset=1
             - 0.66 - 0.27)
        constrainedby Data.ATPChaseData
        annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
      Bodylight.Blocks.Math.SqDiffIntegrator sqDiffIntegrator
        annotation (Placement(transformation(extent={{4,84},{12,92}})));
      Modelica.Blocks.Sources.RealExpression totalLabelNorm_expr(y=if time > 0
             then totalLabelNorm else timeTable_ATPChase.y)
        annotation (Placement(transformation(extent={{-34,68},{-14,88}})));
      parameter Real tune_a=0.5237808289148986;
      parameter Real tune_b=0.09272767278883189;
      parameter Real tune_c=1.081950535876404;
      Bodylight.Population.LabeledPopulation.Components.StateTransition k2(
        k=50,
        useRateInput=true,
        useDynamicFlowLabeling=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-32,-66})));
      Modelica.Blocks.Sources.RealExpression rateA2Out(y=if time > -ageTime and
            A2.pop > 1e-6 then k2.k else 0)
        annotation (Placement(transformation(extent={{10,-94},{-10,-74}})));
      Modelica.Blocks.Sources.RealExpression labelA2Out(y=1)
        annotation (Placement(transformation(extent={{10,-74},{-10,-58}})));
      parameter Bodylight.Types.Concentration CmantATP=0.25;
      parameter Bodylight.Types.Concentration CATP=4
        "Unlabeled ATP concentration";
      Modelica.Blocks.Sources.RealExpression labelDRX_D(y=if time > 0 then rho
             elseif time < 0 and time > -ageTime then 1 else 0)
        annotation (Placement(transformation(extent={{-24,-20},{-4,0}})));
    public
      parameter Real k=0.016666666666666666;
      Bodylight.Population.LabeledPopulation.Components.StateCompartment SRX(
          pop_start=1e-6, nPorts=2)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment DRX_T(
          pop_start=max(1e-6, 1 - A2.pop_start - SRX.pop_start - DRX_D.pop_start),
          nPorts=5)
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment DRX_D(
          pop_start=max(1e-6, 0.95 - A2.pop_start), nPorts=2)
        annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m(k
          =0.014*tune_a) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,20})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_p(k
          =48.5*tune_b) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-20,20})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH(
        k=80,
        allowReverse=true,
        useRateOutput=false)
        annotation (Placement(transformation(extent={{-10,-36},{10,-56}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH_m(
        k=0.066*tune_c,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=true,
        useRateInput=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,-32})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment A2(
          pop_start=0.4, nPorts=1) "Attached state"
        annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
      parameter Modelica.Units.SI.Time ageTime(displayUnit="s")=120;
      Modelica.Blocks.Sources.RealExpression totalLabel(y=SRXLabel.y + DRXLabel.y +
            A2.labelAmount)
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Modelica.Blocks.Sources.RealExpression SRXLabel(y=SRX.labelAmount)
        annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
      Modelica.Blocks.Sources.RealExpression DRXLabel(y=DRX_D.labelAmount + DRX_T.labelAmount)
        annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      Real totalLabelNorm "Label normalized to chase onset";
      Real normFactor(start=1);
      Real SRX_fraction(start=0);
      Real photobleaching(start=1) "Photobleaching decay starts with aging";
      parameter Real k_pb=0;
      Real totalLabel_PB=totalLabel.y*photobleaching
        "Total label including photobleaching";
      parameter Real background=0;
      parameter Real rho=0*CmantATP/CATP;
      parameter Real photobleachingTime = -ageTime;
    equation
      der(photobleaching) = if time > photobleachingTime then -photobleaching*k_pb else 0;
      totalLabelNorm = totalLabel_PB/normFactor + timeTable_ATPChase.offset;
      when time >= 0 then
        normFactor = (totalLabel_PB + background)/(timeTable_ATPChase.maxScale - timeTable_ATPChase.offset);
        SRX_fraction = SRXLabel.y/totalLabel.y;
      end when;

      connect(rateDRXDOut.y, kH_m.rateInput) annotation (Line(points={{15,-10},
              {14,-10},{14,-28},{10,-28}}, color={0,0,127}));
      connect(SRX.lpop[1], k_srx_m.lpop_a) annotation (Line(
          points={{-40.2,40.15},{-30,40.15},{-30,30}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m.lpop_b, DRX_T.lpop[1]) annotation (Line(
          points={{-30,10},{-30,-40},{-40.2,-40}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_b, SRX.lpop[2]) annotation (Line(
          points={{-20,30},{-20,40},{-40.2,40},{-40.2,40.65}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_a, DRX_T.lpop[2]) annotation (Line(
          points={{-20,10},{-20,4},{-30,4},{-30,-39.8},{-40.2,-39.8}},
          color={107,45,134},
          thickness=1));
      connect(DRX_T.lpop[3], kH.lpop_a) annotation (Line(
          points={{-40.2,-39.6},{-40.2,-40},{-20,-40},{-20,-46},{-10,-46}},
          color={107,45,134},
          thickness=1));
      connect(kH.lpop_b, DRX_D.lpop[1]) annotation (Line(
          points={{10,-46},{24,-46},{24,-39.85},{40.2,-39.85}},
          color={107,45,134},
          thickness=1));
      connect(kH_m.lpop_b, DRX_T.lpop[4]) annotation (Line(
          points={{-10,-32},{-20,-32},{-20,-39.4},{-40.2,-39.4}},
          color={107,45,134},
          thickness=1));
      connect(kH_m.lpop_a, DRX_D.lpop[2]) annotation (Line(
          points={{10,-32},{24,-32},{24,-39.35},{40.2,-39.35}},
          color={107,45,134},
          thickness=1));
      connect(k2.lpop_a, A2.lpop[1]) annotation (Line(
          points={{-32,-76},{-32,-100},{-40.2,-100},{-40.2,-99.6}},
          color={107,45,134},
          thickness=1));
      connect(k2.lpop_b, DRX_T.lpop[5]) annotation (Line(
          points={{-32,-56},{-32,-40},{-40.2,-40},{-40.2,-39.2}},
          color={107,45,134},
          thickness=1));
      connect(labelDRX_D.y, kH_m.labelInput) annotation (Line(points={{-3,-10},{0,-10},
              {0,-24}},                     color={0,0,127}));
      connect(labelA2Out.y, k2.labelInput)
        annotation (Line(points={{-11,-66},{-24,-66}}, color={0,0,127}));
      connect(k2.rateInput, rateA2Out.y) annotation (Line(points={{-28,-76},{-28,-84},
              {-11,-84}}, color={0,0,127}));
      connect(timeTable_ATPChase.y, sqDiffIntegrator.u1) annotation (Line(
            points={{-39,90},{-38,90.4},{3.2,90.4}}, color={0,0,127}));
      connect(sqDiffIntegrator.u2, totalLabelNorm_expr.y) annotation (Line(
            points={{3.2,85.6},{-10,85.6},{-10,78},{-13,78}}, color={0,0,127}));
      annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));

    end XBCyclingSrxT;

    model XBCycling_SrxD
      "Alternative configuration, where a separate SRX_ADP state exists and transitions to DRX_ADP"
      import mantATP;
      extends mantATP.DataMatched.Hooijman.XBCycling(
        DRX_D(nPorts=3),
        k_srx_m(k=kmsr),
        SRX(nPorts=3),
        SRXLabel(y=SRX.labelAmount + SRX_D.labelAmount),
        tune_a=0.4389320387284864,
        tune_b=0.08804382574240988,
        tune_c=1.0150553374423377);
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m1(k(
            displayUnit="s-1") = kmsr)
                     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,10})));
      parameter Bodylight.Types.PopulationChange kmsr=0.014*tune_a;
      Bodylight.Population.LabeledPopulation.Components.StateCompartment SRX_D(pop_start
          =1e-6, nPorts=2)
        annotation (Placement(transformation(extent={{60,40},{40,60}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH_srx(
        k=80,
        allowReverse=true,
        useRateOutput=true)
        annotation (Placement(transformation(extent={{-6,30},{14,50}})));
    equation
      connect(k_srx_m1.lpop_b, DRX_D.lpop[3]) annotation (Line(
          points={{40,0},{40,-40},{40.2,-40},{40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(SRX.lpop[3], kH_srx.lpop_a) annotation (Line(
          points={{-40.2,40.4},{-40.2,40},{-6,40}},
          color={107,45,134},
          thickness=1));
      connect(kH_srx.lpop_b, SRX_D.lpop[1]) annotation (Line(
          points={{14,40},{36,40},{36,40.15},{40.2,40.15}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m1.lpop_a, SRX_D.lpop[2]) annotation (Line(
          points={{40,20},{40,40.65},{40.2,40.65}},
          color={107,45,134},
          thickness=1));
    end XBCycling_SrxD;

    model XBCycling_Srx2DrxD
      "alternative configuration where SRX can hydrolyze into DRX_ADP directly"
      import mantATP;
      extends mantATP.DataMatched.Hooijman.XBCycling(
                                 DRX_D(nPorts=3), SRX(nPorts=3),
        k_srx_m(k=kmsr*kmsr_f),
        tune_c=1.013986378473558);
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m1(k(
            displayUnit="s-1") = (1 - kmsr_f)*kmsr)
                     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,14})));
      parameter Bodylight.Types.PopulationChange kmsr=0.014*tune_a;
      parameter Bodylight.Types.PopulationChange kmsr_f=1;
    equation
      connect(k_srx_m1.lpop_b, DRX_D.lpop[3]) annotation (Line(
          points={{40,4},{40,2},{40.2,2},{40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m1.lpop_a, SRX.lpop[3]) annotation (Line(
          points={{40,24},{40,40},{-40.2,40},{-40.2,40.4}},
          color={107,45,134},
          thickness=1));
    end XBCycling_Srx2DrxD;

    model XBCyclingSrxD
      "Default model parametrization to fit Hooijman 2011 mantATP chased by ATP."

      extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.RealExpression rateDRXDOut(y=if time > -ageTime
             then 0.066*tune_c else 0)
        annotation (Placement(transformation(extent={{36,-20},{16,0}})));
    //  parameter Real offset=0 "Offsets of output signals";
      replaceable Data.TimeTable_ATPChaseHooijman2011 timeTable_ATPChase(offset=1
             - 0.66 - 0.27)
        constrainedby Data.ATPChaseData
        annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
      Bodylight.Blocks.Math.SqDiffIntegrator sqDiffIntegrator
        annotation (Placement(transformation(extent={{4,84},{12,92}})));
      Modelica.Blocks.Sources.RealExpression totalLabelNorm_expr(y=if time > 0
             then totalLabelNorm else timeTable_ATPChase.y)
        annotation (Placement(transformation(extent={{-34,68},{-14,88}})));
      parameter Real tune_a=0.5237808289148986;
      parameter Real tune_b=0.09272767278883189;
      parameter Real tune_c=1.081950535876404;
      Bodylight.Population.LabeledPopulation.Components.StateTransition k2(
        k=50,
        useRateInput=true,
        useDynamicFlowLabeling=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-32,-66})));
      Modelica.Blocks.Sources.RealExpression rateA2Out(y=if time > -ageTime and
            A2.pop > 1e-6 then k2.k else 0)
        annotation (Placement(transformation(extent={{10,-94},{-10,-74}})));
      Modelica.Blocks.Sources.RealExpression labelA2Out(y=1)
        annotation (Placement(transformation(extent={{10,-74},{-10,-58}})));
      parameter Bodylight.Types.Concentration CmantATP=0.25;
      parameter Bodylight.Types.Concentration CATP=4
        "Unlabeled ATP concentration";
      Modelica.Blocks.Sources.RealExpression labelDRX_D(y=if time > 0 then rho
             elseif time < 0 and time > -ageTime then 1 else 0)
        annotation (Placement(transformation(extent={{-24,-20},{-4,0}})));
    public
      parameter Real k=0.016666666666666666;
      Bodylight.Population.LabeledPopulation.Components.StateCompartment SRX(
          pop_start=1e-6, nPorts=2)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment DRX_T(
          pop_start=max(1e-6, 1 - A2.pop_start - SRX.pop_start - DRX_D.pop_start),
          nPorts=3)
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment DRX_D(
          pop_start=max(1e-6, 0.95 - A2.pop_start), nPorts=4)
        annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m(k=0.014*
            tune_a*0.523781)
                         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={28,20})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_p(k=48.5*
            tune_b*9.27277E-05)
                        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={38,20})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH(
        k=80,
        allowReverse=true,
        useRateOutput=false)
        annotation (Placement(transformation(extent={{-10,-36},{10,-56}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH_m(
        k=0.066*tune_c,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=true,
        useRateInput=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,-32})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment A2(
          pop_start=0.4, nPorts=1) "Attached state"
        annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
      parameter Modelica.Units.SI.Time ageTime(displayUnit="s")=120;
      Modelica.Blocks.Sources.RealExpression totalLabel(y=SRXLabel.y + DRXLabel.y +
            A2.labelAmount)
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Modelica.Blocks.Sources.RealExpression SRXLabel(y=SRX.labelAmount)
        annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
      Modelica.Blocks.Sources.RealExpression DRXLabel(y=DRX_D.labelAmount + DRX_T.labelAmount)
        annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      Real totalLabelNorm "Label normalized to chase onset";
      Real normFactor(start=1);
      Real SRX_fraction(start=0);
      Real photobleaching(start=1) "Photobleaching decay starts with aging";
      parameter Real k_pb=0;
      Real totalLabel_PB=totalLabel.y*photobleaching
        "Total label including photobleaching";
      parameter Real background=0;
      parameter Real rho=0*CmantATP/CATP;
      parameter Real photobleachingTime = -ageTime;
    equation
      der(photobleaching) = if time > photobleachingTime then -photobleaching*k_pb else 0;
      totalLabelNorm = totalLabel_PB/normFactor + timeTable_ATPChase.offset;
      when time >= 0 then
        normFactor = (totalLabel_PB + background)/(timeTable_ATPChase.maxScale - timeTable_ATPChase.offset);
        SRX_fraction = SRXLabel.y/totalLabel.y;
      end when;

      connect(rateDRXDOut.y, kH_m.rateInput) annotation (Line(points={{15,-10},
              {14,-10},{14,-28},{10,-28}}, color={0,0,127}));
      connect(SRX.lpop[1], k_srx_m.lpop_a) annotation (Line(
          points={{-40.2,40.15},{28,40.15},{28,30}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_b, SRX.lpop[2]) annotation (Line(
          points={{38,30},{38,40},{-40.2,40},{-40.2,40.65}},
          color={107,45,134},
          thickness=1));
      connect(DRX_T.lpop[1], kH.lpop_a) annotation (Line(
          points={{-40.2,-39.9333},{-40.2,-40},{-20,-40},{-20,-46},{-10,-46}},
          color={107,45,134},
          thickness=1));
      connect(kH.lpop_b, DRX_D.lpop[1]) annotation (Line(
          points={{10,-46},{24,-46},{24,-39.975},{40.2,-39.975}},
          color={107,45,134},
          thickness=1));
      connect(kH_m.lpop_b, DRX_T.lpop[2]) annotation (Line(
          points={{-10,-32},{-20,-32},{-20,-39.6},{-40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(kH_m.lpop_a, DRX_D.lpop[2]) annotation (Line(
          points={{10,-32},{24,-32},{24,-39.725},{40.2,-39.725}},
          color={107,45,134},
          thickness=1));
      connect(k2.lpop_a, A2.lpop[1]) annotation (Line(
          points={{-32,-76},{-32,-100},{-40.2,-100},{-40.2,-99.6}},
          color={107,45,134},
          thickness=1));
      connect(k2.lpop_b, DRX_T.lpop[3]) annotation (Line(
          points={{-32,-56},{-32,-40},{-40.2,-40},{-40.2,-39.2667}},
          color={107,45,134},
          thickness=1));
      connect(labelDRX_D.y, kH_m.labelInput) annotation (Line(points={{-3,-10},{0,-10},
              {0,-24}},                     color={0,0,127}));
      connect(labelA2Out.y, k2.labelInput)
        annotation (Line(points={{-11,-66},{-24,-66}}, color={0,0,127}));
      connect(k2.rateInput, rateA2Out.y) annotation (Line(points={{-28,-76},{-28,-84},
              {-11,-84}}, color={0,0,127}));
      connect(timeTable_ATPChase.y, sqDiffIntegrator.u1) annotation (Line(
            points={{-39,90},{-38,90.4},{3.2,90.4}}, color={0,0,127}));
      connect(sqDiffIntegrator.u2, totalLabelNorm_expr.y) annotation (Line(
            points={{3.2,85.6},{-10,85.6},{-10,78},{-13,78}}, color={0,0,127}));
      connect(k_srx_p.lpop_a, DRX_D.lpop[3]) annotation (Line(
          points={{38,10},{38,4},{34,4},{34,-40},{40.2,-40},{40.2,-39.475}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m.lpop_b, DRX_D.lpop[4]) annotation (Line(
          points={{28,10},{28,4},{34,4},{34,-39.225},{40.2,-39.225}},
          color={107,45,134},
          thickness=1));
      annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"),
          experiment(
          StartTime=-600,
          StopTime=600,
          __Dymola_Algorithm="Dassl"));

    end XBCyclingSrxD;
  end Configurations;
  annotation (uses(Modelica(version="4.0.0"), Bodylight(version="1.0")));
end mantATP;
