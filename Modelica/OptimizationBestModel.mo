model OptimizationBestModel "Optimized model parameters of mantATP.LabelLib.XBCycling_Hooijman_5m"
  extends mantATP.LabelLib.XBCycling_Hooijman_5m(
     tune_a=   0.1914931581495058     ,
     tune_b=   0.0440628005304724     ,
     tune_c=   0.8754615930889599     
  );

 /* Automatically generated at Tue May 13 14:45:07 2025 */
 /*
    The final optimization result was as follows:
    
    Evaluation #1
        0.0801579126773026        min    integratedSquaredDeviation.y1
    __________________________________________________
        0.0801579126773026       Maximum of criteria
    
    **************************************************
    
    The optimized Modelica parameters were found by running the following optimization setup:
    
    Optimization.Tasks.ModelOptimization.run22(
        Optimization.Internal.Version.V22.ModelOptimizationSetup(
            modelName="mantATP.LabelLib.XBCycling_Hooijman_5m",
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
                                Value=0.1914931581495058,
                                min=0.1,
                                max=0.3,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_b",
                                active=true,
                                Value=0.0440628005304724,
                                min=1e-2,
                                max=0.1,
                                equidistant=0,
                                scaleToBounds=false,
                                discreteValues=fill(0,0),
                                unit=""),
                            Optimization.Internal.Version.V22.TunerParameter(
                                name="tune_c",
                                active=true,
                                Value=0.8754615930889599,
                                min=0.5,
                                max=1.5,
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
                        unit="")
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
                            startTime=-1.6e+3,
                            stopTime=600,
                            outputInterval=0,
                            numberOfIntervals=1500,
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
annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
end OptimizationBestModel;
