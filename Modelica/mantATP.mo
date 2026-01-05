within ;
package mantATP

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

      model Baseline
        "Default model parametrization to fit Hooijman 2011 mantATP chased by ATP."
        extends Configurations.XBLeaking_SrxTD_reversekH_slowkH;
      end Baseline;

      model XBCycling_SrxT
        extends Configurations.XBCycling_SrxT;
      end XBCycling_SrxT;

      package SRX_T
        package RigorFraction
          model XBCycling_A280 "Retuned for higher initial rigor state"
            import mantATP;
            extends mantATP.DataMatched.Hooijman.Baseline(
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

        model XBCycling_Active
          extends Baseline(
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
        end XBCycling_Active;

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
            Configurations.XBCycling_SrxD(
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
            Configurations.XBCycling_SrxD(
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

        model XBCyclingSrxD_Active_SrxDT
          extends XBCycling_Active(
            tune_c=1,
            tune_b=0.8,
            tune_a=1,
            DRX_D(nPorts=5),
            ka(disableTransition=true),
            SRX(nPorts=3),
            k_srx_m(k=0.014*tune_a*0.523781, disableTransition=true),
            k_srx_p(k=48.5*tune_b*9.27277E-05, disableTransition=true));
          Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m1(k=0.014*
                tune_a*0.523781)
                             annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={36,20})));
          Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_p1(k=48.5*
                tune_b*9.27277E-05)
                            annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={46,20})));
          Bodylight.Population.LabeledPopulation.Components.StateCompartment SRX1(pop_start
              =1e-6, nPorts=3)
            annotation (Placement(transformation(extent={{10,40},{30,60}})));
          Bodylight.Population.LabeledPopulation.Components.StateTransition kH1(
            k=80,
            allowReverse=true,
            useRateOutput=false)
            annotation (Placement(transformation(extent={{-14,50},{6,30}})));
        equation
          connect(k_srx_m1.lpop_b, DRX_D.lpop[4]) annotation (Line(
              points={{36,10},{36,-40},{38,-40},{38,-44},{40.2,-44},{40.2,-39.6}},
              color={107,45,134},
              thickness=1));
          connect(k_srx_p1.lpop_a, DRX_D.lpop[5]) annotation (Line(
              points={{46,10},{46,-16},{40,-16},{40,-40},{40.2,-40},{40.2,-39.6}},
              color={107,45,134},
              thickness=1));
          connect(SRX1.lpop[1], k_srx_m1.lpop_a) annotation (Line(
              points={{29.8,40.0667},{36,40.0667},{36,30}},
              color={107,45,134},
              thickness=1));
          connect(SRX1.lpop[2], k_srx_p1.lpop_b) annotation (Line(
              points={{29.8,40.4},{46,40.4},{46,30}},
              color={107,45,134},
              thickness=1));
          connect(SRX.lpop[3], kH1.lpop_a) annotation (Line(
              points={{-40.2,40.4},{-40.2,40},{-14,40}},
              color={107,45,134},
              thickness=1));
          connect(kH1.lpop_b, SRX1.lpop[3]) annotation (Line(
              points={{6,40},{29.8,40},{29.8,40.7333}},
              color={107,45,134},
              thickness=1));
          annotation (experiment(
              StartTime=-600,
              StopTime=600,
              __Dymola_NumberOfIntervals=1500,
              __Dymola_Algorithm="Dassl"));
        end XBCyclingSrxD_Active_SrxDT;

        model XBCyclingSrxT_kHmant_40
          "Optimized model parameters of mantATP.Experiments.XBCyclingSrxT"
          extends mantATP.Configurations.XBCycling_SrxT(
            tune_a=0.5114406952562761,
            tune_b=0.0459675155023775,
            tune_c=1.0858304945896236,
            kH(useRateInput=true),
            DRX_D(nPorts=3),
            DRX_T(nPorts=6)          );
          Modelica.Blocks.Sources.RealExpression labelA2Out1(y=(1 - DRX_T.label)*kH_ATP)
            annotation (Placement(transformation(extent={{-94,-50},{-74,-34}})));
          Modelica.Blocks.Sources.RealExpression labelA2Out2(y=(DRX_T.label)*kH_mantATP)
            annotation (Placement(transformation(extent={{-94,-62},{-74,-46}})));
          Bodylight.Population.LabeledPopulation.Components.StateTransition kH_labeled(
            k(displayUnit="s-1") = 80,
            allowReverse=true,
            useRateInput=true,
            useRateOutput=false)
            annotation (Placement(transformation(extent={{-10,-44},{10,-64}})));

          parameter Bodylight.Types.PopulationChange kH_ATP = 80;
          parameter Bodylight.Types.PopulationChange kH_mantATP = 40;
        equation
          connect(labelA2Out1.y, kH.rateInput) annotation (Line(points={{-73,-42},{-10,-42}},
                                                            color={0,0,127}));
          connect(labelA2Out2.y,kH_labeled. rateInput) annotation (Line(points={{-73,-54},
                  {-60,-54},{-60,-50},{-10,-50}}, color={0,0,127}));
          connect(kH_labeled.lpop_b, DRX_D.lpop[3]) annotation (Line(
              points={{10,-54},{24,-54},{24,-39.85},{40.2,-39.85},{40.2,-39.6}},
              color={107,45,134},
              thickness=1));
          connect(kH_labeled.lpop_a, DRX_T.lpop[6]) annotation (Line(
              points={{-10,-54},{-20,-54},{-20,-40},{-40.2,-40},{-40.2,-39.6}},
              color={107,45,134},
              thickness=1));
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
        end XBCyclingSrxT_kHmant_40;
      end Experiments;

      package Photobleaching
        model XBCycling_Hooijman_PB0005
          "Testing exponential photobleaching, can't fit properly"
          import mantATP;
          extends mantATP.DataMatched.Hooijman.Baseline(
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
          extends Baseline(
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
          extends Baseline(
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
      end SRX_T;
    end Hooijman;

    package Walklate

      package Fig1AReported
        model XBCyclingSrxT_Walklate2022Fig1A
          "Additional model parametrization to fit Walklate 2022 fig 1A"
          extends Configurations.XBCycling_SrxT (
            rho=0,
            tune_a=0.3061467550165379,
            tune_b=0.1947624404223471,
            tune_c=0.411047421686107,
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
          extends Configurations.XBCycling_SrxD(
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
              StartTime=-900,
              StopTime=1000,
              __Dymola_Algorithm="Dassl"));
        end XBCyclingSrxD_Walklate2022Fig1A;

        model XBCyclingSrxTD_Walklate2022Fig1A
          "Additional model parametrization to fit Walklate 2022 fig 1A"
          extends Configurations.XBCycling_SrxTD(
            rho=0,
            tune_a=0.2711536822169261,
            tune_b=0.1925405908523434,
            tune_c=0.4084361575434682,
            DRX_D(pop_start=max(1e-6, 0.95 - A2.pop_start)),
            SRX(pop_start=1e-6),
            kH_m(useRateInput=true),
            ageTime=60.0,
            redeclare Data.TimeTable_ATPChaseWalklate1A timeTable_ATPChase,
            A2(pop_start=0.4));
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"),
              experiment(
              StartTime=-900,
              StopTime=1000,
              __Dymola_Algorithm="Dassl"));
        end XBCyclingSrxTD_Walklate2022Fig1A;

        model XBCyclingSrxTDR_Walklate2022Fig1A
          "Additional model parametrization to fit Walklate 2022 fig 1A"
          extends Configurations.XBCycling_SrxTD_reversekH(
                tune_a=0.30067479265592345,
                tune_b=0.00060472191909221,
                tune_c=0.3998022584499989,
            ageTime=60.0,
            redeclare Data.TimeTable_ATPChaseWalklate1A timeTable_ATPChase);
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"),
              experiment(
              StartTime=-900,
              StopTime=1000,
              __Dymola_Algorithm="Dassl"));
        end XBCyclingSrxTDR_Walklate2022Fig1A;

        model XBLeakingSrxTD_RevkH_Walklate2022Fig1A
          "Additional model parametrization to fit Walklate 2022 fig 1A"
          extends Configurations.XBLeaking_SrxTD_reversekH_slowkH(
            ageTime=60.0,
            redeclare Data.TimeTable_ATPChaseWalklate1A timeTable_ATPChase,
            tune_a=0.004683371559309896,
            tune_b=0.0243555294921875,
            tune_c=0.027021598945746527,
            kH(k=18)                   );
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"),
              experiment(
              StartTime=-900,
              StopTime=1000,
              __Dymola_Algorithm="Dassl"));
        end XBLeakingSrxTD_RevkH_Walklate2022Fig1A;
      end Fig1AReported;

      package Fig1AResampled
          model XBCycling_Walklate2022Fig1ASample
            "Additional model parametrization to fit Walklate 2022, for what is actually on the figure"
            extends Hooijman.Baseline(
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
          package SRX_T
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

          end SRX_T;

          package SRX_D

            model WalklateSrxD_A20
                extends
                  Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A(
                  A2(pop_start=1e-6),
                  tune_a=0.5876422414550787,
                  tune_b=0.5913383933105449,
                  tune_c=0.360726521484375);
            end WalklateSrxD_A20;

            model WalklateSrxD_A220
                extends
                  Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A(
                  A2(pop_start=0.2, pop(start=0.2, displayUnit="1")),
                  tune_a=0.5801333913574218,
                  tune_b=0.5482700881890167,
                  tune_c=0.3646252965615353,
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
                    A2(pop_start=0.6),
                    tune_a=0.6027864064941405,
                    tune_b=0.5436306350640165,
                    tune_c=0.3784960141541279);

            end WalklateSrxD_A260;

            model WalklateSrxD_A280
                extends
                  Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A(
                    A2(pop_start=0.8),
                    tune_a=0.571905498291015,
                    tune_b=0.4855362991265159,
                    tune_c=0.3690439380545906);
            end WalklateSrxD_A280;

            model WalklateSrxD_A2100
                extends
                  Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A(
                    A2(pop_start=1),
                    tune_a=0.5807580373535152,
                    tune_b=0.487134172390405,
                    tune_c=0.373326880762924);
            end WalklateSrxD_A2100;
          end SRX_D;


        package SRX_TDR "Having both ATP adn AdpPi and reverse hydrolysis"



          model WalklateSrx_TDR_A20
              extends
                Fig1AReported.XBCyclingSrxTDR_Walklate2022Fig1A(
                A2(pop_start=1e-6),
                tune_a=0.30730925292813827,
                tune_b=0.0007349485231122888,
                tune_c=0.3914382392194641
                                        );
          end WalklateSrx_TDR_A20;

          model WalklateSrx_TDR_A220
              extends
                Fig1AReported.XBCyclingSrxTDR_Walklate2022Fig1A(
                A2(pop_start=0.2, pop(start=0.2, displayUnit="1")),
                tune_a=0.30301798743918806,
                tune_b=0.0006768712852754255,
                tune_c=0.39384609331532766,
                DRX_D(pop(start=0.75, displayUnit="1")),
                DRX_T(pop(start=0.049999000000000016, displayUnit="1")),
                SRX(pop(start=1E-06, displayUnit="1")));
          end WalklateSrx_TDR_A220;

          model WalklateSrx_TDR_A240
              extends
                Fig1AReported.XBCyclingSrxTDR_Walklate2022Fig1A(
              tune_a=0.3008455701514543,
              tune_b=0.0006421044200112586,
              tune_c=0.39598466925029246);
          end WalklateSrx_TDR_A240;

          model WalklateSrx_TDR_A260
              extends
                Fig1AReported.XBCyclingSrxTDR_Walklate2022Fig1A(
                  A2(pop_start=0.6),
                  tune_a=0.3010787529466408,
                  tune_b=0.0006222362221014858,
                  tune_c=0.3987746498857708);

          end WalklateSrx_TDR_A260;

          model WalklateSrx_TDR_A280
              extends
                Fig1AReported.XBCyclingSrxTDR_Walklate2022Fig1A(
                  A2(pop_start=0.8),
                  tune_a=0.30067479265592345,
                  tune_b=0.00060472191909221,
                  tune_c=0.3998022584499989);
          end WalklateSrx_TDR_A280;

          model WalklateSrx_TDR_A2100
              extends
                Fig1AReported.XBCyclingSrxTDR_Walklate2022Fig1A(
                  A2(pop_start=1),
                  tune_a=0.2993020246339335,
                  tune_b=0.0005917914140480172,
                  tune_c=0.4013541259166848
                                          );
          end WalklateSrx_TDR_A2100;
        end SRX_TDR;

        package SRX_TDR_L
          "Having both ATP adn AdpPi and reverse hydrolysis, while using the leaking stage"

          model Walklate_A20
              extends
                Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
                A2(pop_start=1e-6),
                tune_a=0.004698571075802952,
                tune_b=0.029093087077365437,
                tune_c=0.02607577616737397
                                        );
          end Walklate_A20;

          model Walklate_A220
              extends
                Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
                A2(pop_start=0.2, pop(start=0.2, displayUnit="1")),
                tune_a=0.00470199096701389,
                tune_b=0.026896476838541666,
                tune_c=0.026330488966049382,
                DRX_D(pop(start=0.75, displayUnit="1")),
                DRX_T(pop(start=0.049999000000000016, displayUnit="1")),
                SRX(pop(start=1E-06, displayUnit="1")));
          end Walklate_A220;

          model Walklate_A240
              extends
                Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
              tune_a=0.00470664007122396,
              tune_b=0.026346051601326106,
              tune_c=0.02682059828863927,
              A2(pop_start(displayUnit="1") = 0.4)
                                        );
          end Walklate_A240;

          model Walklate_A260
              extends
                Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
                  A2(pop_start=0.6),
                  tune_a=0.004724908987976075,
                  tune_b=0.025237747212402344,
                  tune_c=0.026864902211371527
                                           );

          end Walklate_A260;

          model Walklate_A280
              extends
                Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
                  A2(pop_start=0.8));
          end Walklate_A280;

          model Walklate_A2100
              extends
                Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
                  A2(pop_start=1),
                  tune_a=0.004636633046093751,
                  tune_b=0.0236822185234375,
                  tune_c=0.026947603265625);
          end Walklate_A2100;
        end SRX_TDR_L;
      end RigorFraction;

      package Photobleaching

        package SRX_T

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
          extends XBCycling_Walklate_PB001(photobleachingTime=0);
        end XBCycling_Walklate_PB001_T0;

        model XBCycling_Walklate_PB005
          "Testing photobleaching, cant fit anymore"
          extends XBCycling_Walklate_PB001(
            k_pb=0.005,
            tune_a=1.1728320088683405E-08,
            tune_b=0.29813621580600796,
            tune_c=0.38470060908711257);
        end XBCycling_Walklate_PB005;

        model XBCycling_Walklate_PB01
          "Testing photobleaching, cant fit anymore"
          extends XBCycling_Walklate_PB001(
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

        end SRX_T;

        package SRX_TDR_L

        model XBCycling_Walklate_PB0
          "Optimized model parameters of mantATP.LabelLib.Experiments.XBCycling_Walklate_PB0001"
          extends mantATP.DataMatched.Walklate.Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
            k_pb=0.0);
        end XBCycling_Walklate_PB0;

        model XBCycling_Walklate_PB0001
          "Optimized model parameters of mantATP.LabelLib.Experiments.XBCycling_Walklate_PB0001"
          extends mantATP.DataMatched.Walklate.Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
            k_pb=0.0001,
            tune_a=0.004595690171875,
            tune_b=0.024786035531249997,
            tune_c=0.027080891000000003
                                     );

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
          extends mantATP.DataMatched.Walklate.Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
            k_pb=0.0005,
            tune_a=0.00400472573828125,
            tune_b=0.02407253279861111,
            tune_c=0.026242099629629628
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
          extends mantATP.DataMatched.Walklate.Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
            k_pb=0.001,
            tune_a=0.003428535415527344,
            tune_b=0.024443803115885416,
            tune_c=0.025780197625   );
          annotation (experiment(
              StartTime=-1600,
              StopTime=1500,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"));
        end XBCycling_Walklate_PB001;

        model XBCycling_Walklate_PB002
          "Testing exponential photobleaching, can fit perfectly"
          import mantATP;
          extends mantATP.DataMatched.Walklate.Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
            k_pb=0.002,
            tune_a=0.0022912788144531264,
            tune_b=0.025675771863161678,
            tune_c=0.024900292077808178
                                    );
          annotation (experiment(
              StartTime=-1600,
              StopTime=1500,
              __Dymola_NumberOfIntervals=5000,
              __Dymola_Algorithm="Dassl"));
        end XBCycling_Walklate_PB002;

        model XBCycling_Walklate_PB005
          "Testing photobleaching, cant fit anymore"
          extends XBCycling_Walklate_PB001(
            k_pb=0.005,
            tune_a=9.999999999999953E-06,
            tune_b=0.037698,
            tune_c=0.024183927796875  );
        end XBCycling_Walklate_PB005;

        model XBCycling_Walklate_PB01
          "Testing photobleaching, cant fit anymore"
          extends XBCycling_Walklate_PB005(
            k_pb=0.01);
        end XBCycling_Walklate_PB01;

        end SRX_TDR_L;
      end Photobleaching;

      package ADPEffect

        package SRX_T

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
            rateDRXDOut(y=if time > -ageTime then inverseProportionalFactor.y
                   else 0),
            kH_m(useRateOutput=true)
                          );
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
              extends SRX_T.XBCycling_Walklate_CalcADPDil_kADP1(
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
              extends SRX_T.XBCycling_Walklate_CalcADPDil_kADP01(
                  IsDoubleDillution(y=true));
                  annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
            end XBCycling_Walklate_CalcADPDil_kADP01;

            model XBCycling_Walklate_CalcADPDil_kADP05
              "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP01"
              extends SRX_T.XBCycling_Walklate_CalcADPDil_kADP05(
                  IsDoubleDillution(y=true));
                                               annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
            end XBCycling_Walklate_CalcADPDil_kADP05;

            model XBCycling_Walklate_CalcADPDil_kADP10
              "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP10"
              extends SRX_T.XBCycling_Walklate_CalcADPDil_kADP10(
                  IsDoubleDillution(y=true));
                                               annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));
            end XBCycling_Walklate_CalcADPDil_kADP10;

            model XBCycling_Walklate_CalcADPDil_kADP100
              "Optimized model parameters of mantATP.DataMatched.Walklate.ADPEffect.XBCycling_Walklate_CalcADPDil_kADP100"
              extends SRX_T.XBCycling_Walklate_CalcADPDil_kADP10(
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

        end SRX_T;

        package SRX_TDR_L
        model XBCycling_Walklate_CalcADPDil_kADP1
          "Generating ADP, having a slow-down effect on DRX_D to DRX_T transition"
          extends Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
            rho=0,
            ageTime(displayUnit="s"),
            CATP(displayUnit="uM") = 0.25,
            CmantATP(displayUnit="uM") = 0.01,
            rateDRXDOut(y=if time > -ageTime then inverseProportionalFactor.y
                   else 0),
            k_leak(useRateOutput=true),
              tune_a=0.004802782760758463,
              tune_b=0.023273422578124998,
              tune_c=0.02893242856770833
                          );
          Modelica.Blocks.Continuous.Integrator integrator(
            k=CMyo,                                        use_reset=false, use_set=false)
            annotation (Placement(transformation(extent={{30,-60},{40,-50}})));
          Modelica.Blocks.Sources.Constant const(k=tune_c)
            annotation (Placement(transformation(extent={{50,0},{60,10}})));
          Bodylight.Blocks.Factors.InverseProportionalFactor inverseProportionalFactor(
              scalingFactor=1,   enabled=true)
            annotation (Placement(transformation(extent={{80,-20},{60,0}})));
          parameter Real IfADP=0.1
            "Intesity of free mADP as a fraction of mATP intensity";
          Modelica.Blocks.Math.Division dilutionEffect "Relative to initial"
            annotation (Placement(transformation(extent={{104,-66},{114,-56}})));
          Modelica.Blocks.Math.Division a_times_u
            annotation (Placement(transformation(extent={{126,-74},{136,-64}})));
          Modelica.Blocks.Sources.Constant K_ADP(k=Ki_ADP)
            annotation (Placement(transformation(extent={{104,-82},{114,-72}})));
          Modelica.Blocks.Sources.RealExpression singleDilution(y=if time >= 0 then 2
                 elseif time >= -ageTime then 1 else 1)
            annotation (Placement(transformation(extent={{44,-102},{58,-88}})));
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
            annotation (Placement(transformation(extent={{82,-90},{92,-80}})));
          Modelica.Blocks.Sources.RealExpression doubleDilution(y=if time >= 0 then 4
                 elseif time >= -ageTime then 2 else 1)
            annotation (Placement(transformation(extent={{44,-80},{58,-66}})));
          Modelica.Blocks.Sources.BooleanExpression IsDoubleDillution(y=false)
            annotation (Placement(transformation(extent={{52,-92},{66,-78}})));
        equation
          connect(const.y, inverseProportionalFactor.yBase)
            annotation (Line(points={{60.5,5},{70,5},{70,-8}}, color={0,0,127}));
          connect(a_times_u.y, inverseProportionalFactor.u) annotation (Line(
                points={{136.5,-69},{140,-69},{140,-10},{78,-10}},
                                                               color={0,0,127}));
          connect(dilutionEffect.y, a_times_u.u1) annotation (Line(points={{114.5,-61},{
                  120,-61},{120,-66},{125,-66}},
                                            color={0,0,127}));
          connect(K_ADP.y, a_times_u.u2) annotation (Line(points={{114.5,-77},{120,-77},
                  {120,-72},{125,-72}},    color={0,0,127}));
          connect(integrator.y, multiSum.u[1]) annotation (Line(points={{40.5,-55},{58,
                  -55},{58,-58.7},{60,-58.7}},
                                          color={0,0,127}));
          connect(multiSum.y, dilutionEffect.u1)
            annotation (Line(points={{68.68,-58},{103,-58}},color={0,0,127}));
          connect(booleanPulseN.y, stack.u) annotation (Line(points={{83.6,-44},{84,-44},
                  {84,-44.08},{77.84,-44.08}}, color={255,0,255}));
          connect(stack.y, multiSum.u[2]) annotation (Line(points={{69.6,-44},{56,-44},
                  {56,-57.3},{60,-57.3}},                  color={0,0,127}));
          connect(dilutionEffect.u2, switch1.y) annotation (Line(points={{103,-64},{96,-64},
                  {96,-85},{92.5,-85}}, color={0,0,127}));
          connect(IsDoubleDillution.y, switch1.u2)
            annotation (Line(points={{66.7,-85},{81,-85}}, color={255,0,255}));
          connect(doubleDilution.y, switch1.u1) annotation (Line(points={{58.7,-73},{70,
                  -73},{70,-81},{81,-81}}, color={0,0,127}));
          connect(singleDilution.y, switch1.u3) annotation (Line(points={{58.7,-95},{70,
                  -95},{70,-90},{81,-90},{81,-89}}, color={0,0,127}));
          connect(integrator.u, k_leak.popChangeOutput)
            annotation (Line(points={{29,-55},{-10,-55},{-10,-92}}, color={0,0,127}));
          annotation (experiment(
              StartTime=-1500,
              StopTime=1500,
              __Dymola_NumberOfIntervals=1500,
              Tolerance=1e-06,
              __Dymola_Algorithm="Cvode"), Diagram(coordinateSystem(extent={{-100,-100},
                    {120,100}}),                   graphics={Line(points={{68,-14},
                        {30,-76},{32,-64}},
                                color={28,108,200},
                    thickness=1)}),
            Icon(coordinateSystem(extent={{-100,-100},{120,100}})));
        end XBCycling_Walklate_CalcADPDil_kADP1;

          model XBCycling_Walklate_CalcADPDil_kADP01
            extends XBCycling_Walklate_CalcADPDil_kADP1(Ki_ADP = 0.0001,
              tune_a=0.004896923524119951,
              tune_b=0.017113475647926334,
              tune_c=0.04852361511541749                               );
          end XBCycling_Walklate_CalcADPDil_kADP01;

          model XBCycling_Walklate_CalcADPDil_kADP05
            extends XBCycling_Walklate_CalcADPDil_kADP1(
              Ki_ADP=0.0005,
              tune_a=0.0049573666723845096,
              tune_b=0.022756054763378906,
              tune_c=0.031346005832863934                              );
          end XBCycling_Walklate_CalcADPDil_kADP05;

          model XBCycling_Walklate_CalcADPDil_kADP10
            extends XBCycling_Walklate_CalcADPDil_kADP1(
              Ki_ADP=0.01,
              tune_a=0.00481617733466797,
              tune_b=0.0249567,
              tune_c=0.0271043                                         );
          end XBCycling_Walklate_CalcADPDil_kADP10;

          model XBCycling_Walklate_CalcADPDil_kADP100
            extends XBCycling_Walklate_CalcADPDil_kADP1(
              Ki_ADP=0.1,
              tune_a=0.004725550217578125,
              tune_b=0.024852096201562496,
              tune_c=0.0271043                                         );
          end XBCycling_Walklate_CalcADPDil_kADP100;

          package DoubleMixing
            model XBCycling_Walklate_CalcADPDil_kADP1
              extends
                mantATP.DataMatched.Walklate.ADPEffect.SRX_TDR_L.XBCycling_Walklate_CalcADPDil_kADP1
                (IsDoubleDillution(y=true));
            end XBCycling_Walklate_CalcADPDil_kADP1;

            model XBCycling_Walklate_CalcADPDil_kADP05
              extends
                mantATP.DataMatched.Walklate.ADPEffect.SRX_TDR_L.XBCycling_Walklate_CalcADPDil_kADP05
                (IsDoubleDillution(y=true));
            end XBCycling_Walklate_CalcADPDil_kADP05;

            model XBCycling_Walklate_CalcADPDil_kADP01
              extends
                mantATP.DataMatched.Walklate.ADPEffect.SRX_TDR_L.XBCycling_Walklate_CalcADPDil_kADP01
                (IsDoubleDillution(y=true));
            end XBCycling_Walklate_CalcADPDil_kADP01;
          end DoubleMixing;
        end SRX_TDR_L;
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
          extends Hooijman.Baseline(
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

        model XBCyclingSrxTD_Walklate2022Fig1A
          "Additional model parametrization to fit Walklate 2022 fig 1A"
          extends Configurations.XBCycling_SrxD(
            rho=0,
            tune_a=0.5637507976074201,
            tune_b=0.5024787422559087,
            tune_c=0.3612922249492135,
            DRX_D(pop_start=max(1e-6, 0.95 - A2.pop_start), nPorts=5),
            SRX(pop_start=1e-6, nPorts=3),
            kH_m(useRateInput=true),
            ageTime=60.0,
            redeclare Data.TimeTable_ATPChaseWalklate1A timeTable_ATPChase,
            A2(pop_start=1e-3, nPorts=2),
            DRX_T(nPorts=5)  );
          Bodylight.Population.LabeledPopulation.Components.StateCompartment SRX1(pop_start
              =1e-6, nPorts=3)
            annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
          Bodylight.Population.LabeledPopulation.Components.StateTransition kH1(
            k(displayUnit="s-1") = 80/2,
            allowReverse=true,
            useRateOutput=false)
            annotation (Placement(transformation(extent={{-54,36},{-34,16}})));
          Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m1(k=0.014*
                tune_a*0.523781)
                             annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-90,-22})));
          Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_p1(k=48.5*
                tune_b*9.27277E-05)
                            annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={-80,-22})));
          Bodylight.Population.LabeledPopulation.Components.StateTransition ka(
            k(displayUnit="s-1") = 20,
            allowReverse=true,
            useRateInput=true,
            useRateOutput=false,
            disableTransition=true)
                                 annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={54,-80})));
          Modelica.Blocks.Sources.RealExpression rateA2Out1(y=if time > 0 then
                ka.k else 0)
            annotation (Placement(transformation(extent={{98,-94},{78,-74}})));
        equation
          connect(kH1.lpop_b, SRX.lpop[3]) annotation (Line(
              points={{-34,26},{-30,26},{-30,40.4},{-40.2,40.4}},
              color={107,45,134},
              thickness=1));
          connect(kH1.lpop_a, SRX1.lpop[1]) annotation (Line(
              points={{-54,26},{-54,0.0666667},{-60.2,0.0666667}},
              color={107,45,134},
              thickness=1));
          connect(k_srx_p1.lpop_b, SRX1.lpop[2]) annotation (Line(
              points={{-80,-12},{-80,-4},{-60.2,-4},{-60.2,0.4}},
              color={107,45,134},
              thickness=1));
          connect(k_srx_p1.lpop_a, DRX_T.lpop[4]) annotation (Line(
              points={{-80,-32},{-80,-44},{-40.2,-44},{-40.2,-39.6}},
              color={107,45,134},
              thickness=1));
          connect(k_srx_m1.lpop_b, DRX_T.lpop[5]) annotation (Line(
              points={{-90,-32},{-90,-48},{-40.2,-48},{-40.2,-39.6}},
              color={107,45,134},
              thickness=1));
          connect(k_srx_m1.lpop_a, SRX1.lpop[3]) annotation (Line(
              points={{-90,-12},{-90,-6},{-60.2,-6},{-60.2,0.733333}},
              color={107,45,134},
              thickness=1));
          connect(rateA2Out1.y,ka. rateInput)
            annotation (Line(points={{77,-84},{64,-84}}, color={0,0,127}));
          connect(ka.lpop_b, A2.lpop[2]) annotation (Line(
              points={{44,-80},{16,-80},{16,-104},{-40.2,-104},{-40.2,-99.6}},
              color={107,45,134},
              thickness=1));
          connect(ka.lpop_a, DRX_D.lpop[5]) annotation (Line(
              points={{64,-80},{62,-80},{62,-54},{40.2,-54},{40.2,-39.6}},
              color={107,45,134},
              thickness=1));
          annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"),
              experiment(
              StartTime=-900,
              StopTime=1000,
              __Dymola_Algorithm="Dassl"));
        end XBCyclingSrxTD_Walklate2022Fig1A;
      end Experiments;

      package HydrolysisEquilibrium
        model XBSrxTDRL_10
          extends Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A;
        end XBSrxTDRL_10;

        model XBSrxTDRL_1
          extends Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
            kH_D=1,
            tune_a=0.008330763758691408,
            tune_b=0.004341013884375,
            tune_c=0.048670693505208334);
        end XBSrxTDRL_1;

        model XBSrxTDRL_20
          extends Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
            kH_D=20,
            tune_a=0.0045539212346598305,
            tune_b=0.048202078175781246,
            tune_c=0.02601521548014323);
        end XBSrxTDRL_20;

        model XBSrxTDRL_5
          extends Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
            kH_D=5,
            tune_a=0.005297633894207763,
            tune_b=0.01426788837109375,
            tune_c=0.030012983131835935);
          annotation (experiment(
              StartTime=-900,
              StopTime=1000,
              __Dymola_NumberOfIntervals=1500,
              Tolerance=1e-05,
              __Dymola_Algorithm="Cvode"));
        end XBSrxTDRL_5;

        model XBSrxTDRL_100
          extends Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A(
            kH_D=100,
            tune_a=0.0042988283458333335,
            tune_b=0.22153764958333327,
            tune_c=0.024832137890624998);
        end XBSrxTDRL_100;
      end HydrolysisEquilibrium;
    end Walklate;
  end DataMatched;

  package Figures

    model DefaultH
      extends DataMatched.Hooijman.Baseline;
      annotation (experiment(
          StartTime=-1200,
          StopTime=600,
          __Dymola_NumberOfIntervals=5000,
          __Dymola_Algorithm="Dassl"));
    end DefaultH;

    model DefaultW
      extends DataMatched.Walklate.Fig1AReported.XBLeakingSrxTD_RevkH_Walklate2022Fig1A;
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

    model DefaultWSrxD
      extends DataMatched.Walklate.Fig1AReported.XBCyclingSrxD_Walklate2022Fig1A;
      annotation (experiment(
          StartTime=-1200,
          StopTime=600,
          __Dymola_NumberOfIntervals=5000,
          __Dymola_Algorithm="Dassl"));
    end DefaultWSrxD;

    model Walklate_PB005
      extends
        DataMatched.Walklate.Photobleaching.SRX_TDR_L.XBCycling_Walklate_PB005;
    end Walklate_PB005;

    model DefaultW_slow
      extends DefaultW(kH(k=20), k_leak(useRateInput=false));
    end DefaultW_slow;
  end Figures;

  package Configurations
    model XBCycling "Default base class"

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
            extent={{-10,10},{10,-10}},
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
          pop_start=1e-6)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment DRX_T(
          pop_start=max(1e-6, 1 - A2.pop_start - SRX.pop_start - DRX_D.pop_start), nPorts=
            3)
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment DRX_D(
          pop_start=max(1e-6, 0.95 - A2.pop_start), nPorts=2)
        annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH(
        k=80,
        allowReverse=true,
        useRateOutput=false)
        annotation (Placement(transformation(extent={{-10,-34},{10,-54}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH_m(
        k=0.066*tune_c,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=true,
        useRateInput=true) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={0,-24})));
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
      connect(kH.lpop_b, DRX_D.lpop[1]) annotation (Line(
          points={{10,-44},{24,-44},{24,-40.25},{40,-40.25}},
          color={107,45,134},
          thickness=1));
      connect(kH_m.lpop_a, DRX_D.lpop[2]) annotation (Line(
          points={{10,-24},{24,-24},{24,-39.75},{40,-39.75}},
          color={107,45,134},
          thickness=1));
      connect(k2.lpop_a, A2.lpop[1]) annotation (Line(
          points={{-32,-76},{-32,-100},{-40,-100},{-40,-100}},
          color={107,45,134},
          thickness=1));
      connect(labelDRX_D.y, kH_m.labelInput) annotation (Line(points={{-3,-10},
              {6,-10},{6,-20}},             color={0,0,127}));
      connect(labelA2Out.y, k2.labelInput)
        annotation (Line(points={{-11,-66},{-18,-66},{-18,-72},{-28,-72}},
                                                       color={0,0,127}));
      connect(k2.rateInput, rateA2Out.y) annotation (Line(points={{-36,-76},{
              -36,-84},{-11,-84}},
                          color={0,0,127}));
      connect(timeTable_ATPChase.y, sqDiffIntegrator.u1) annotation (Line(
            points={{-39,90},{-38,90.4},{3.2,90.4}}, color={0,0,127}));
      connect(sqDiffIntegrator.u2, totalLabelNorm_expr.y) annotation (Line(
            points={{3.2,85.6},{-10,85.6},{-10,78},{-13,78}}, color={0,0,127}));
      connect(DRX_T.lpop[1], kH.lpop_a) annotation (Line(
          points={{-40,-40.3333},{-40,-40},{-16,-40},{-16,-44},{-10,-44}},
          color={107,45,134},
          thickness=1));
      connect(DRX_T.lpop[2], kH_m.lpop_b) annotation (Line(
          points={{-40,-40},{-16,-40},{-16,-24},{-10,-24}},
          color={107,45,134},
          thickness=1));
      connect(DRX_T.lpop[3], k2.lpop_b) annotation (Line(
          points={{-40,-39.6667},{-40,-40},{-32,-40},{-32,-56}},
          color={107,45,134},
          thickness=1));
      annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));

    end XBCycling;

    model XBCycling_SrxT
      "Default model parametrization to fit Hooijman 2011 mantATP chased by ATP."

      extends XBCycling(SRX(nPorts=2), DRX_T(nPorts=5));
    //  parameter Real offset=0 "Offsets of output signals";
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m(k
          =0.014*tune_a) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-32,20})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_p(k
          =48.5*tune_b) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-22,20})));
    equation
      connect(k_srx_m.lpop_a, SRX.lpop[1]) annotation (Line(
          points={{-32,30},{-32,40.4},{-40.2,40.4}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_b, SRX.lpop[2]) annotation (Line(
          points={{-22,30},{-22,40.4},{-40.2,40.4}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m.lpop_b, DRX_T.lpop[4]) annotation (Line(
          points={{-32,10},{-32,-39.6},{-40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_a, DRX_T.lpop[5]) annotation (Line(
          points={{-22,10},{-22,0},{-32,0},{-32,-39.6},{-40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));

    end XBCycling_SrxT;

    model XBCycling_SrxD
      "Default model parametrization to fit Hooijman 2011 mantATP chased by ATP."

      extends XBCycling(
        DRX_D(nPorts=4),
        SRX(nPorts=2),
        tune_a=1.0072940309413374,
        tune_b=0.7909243959419637,
        tune_c=1.0249458388976362);
    Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m(k=0.014*tune_a*0.523781) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270, origin={28,20})));
    Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_p(k=48.5*tune_b*9.27277E-05) annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=270, origin={38,20})));
    equation

      connect(k_srx_p.lpop_a, DRX_D.lpop[3]) annotation (Line(
          points={{38,10},{38,-39.6},{40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m.lpop_b, DRX_D.lpop[4]) annotation (Line(
          points={{28,10},{28,4},{38,4},{38,-39.6},{40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m.lpop_a, SRX.lpop[1]) annotation (Line(
          points={{28,30},{28,40.4},{-40.2,40.4}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_b, SRX.lpop[2]) annotation (Line(
          points={{38,30},{38,40},{28,40},{28,40.4},{-40.2,40.4}},
          color={107,45,134},
          thickness=1));
      annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"),
          experiment(
          StartTime=-600,
          StopTime=600,
          __Dymola_Algorithm="Dassl"));

    end XBCycling_SrxD;

    model XBCycling_SrxTD
      "Alternative configuration, where a separate SRX_ADP state exists and transitions to DRX_ADP"
      import mantATP;
      extends XBCycling(
        DRX_D(nPorts=3),
        SRXLabel(y=SRX.labelAmount + SRX_D.labelAmount),
        tune_a=0.4389320387284864,
        tune_b=0.08804382574240988,
        tune_c=1.0150553374423377,
        DRX_T(nPorts=4),
        SRX(nPorts=2)  );
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m(k(
            displayUnit="s-1") = 0.014*tune_a) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,10})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment SRX_D(pop_start
          =1e-6, nPorts=2)
        annotation (Placement(transformation(extent={{60,40},{40,60}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH_srx(
        k=80,
        allowReverse=true,
        useRateOutput=true)
        annotation (Placement(transformation(extent={{-6,30},{14,50}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_p(k=48.5*
            tune_b)     annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-34,10})));
    equation
      connect(k_srx_m.lpop_b, DRX_D.lpop[3]) annotation (Line(
          points={{40,0},{40,-40},{40.2,-40},{40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(kH_srx.lpop_b, SRX_D.lpop[1]) annotation (Line(
          points={{14,40},{36,40},{36,40.15},{40.2,40.15}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m.lpop_a, SRX_D.lpop[2]) annotation (Line(
          points={{40,20},{40,40.65},{40.2,40.65}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_a, DRX_T.lpop[4]) annotation (Line(
          points={{-34,0},{-34,-40},{-40.2,-40},{-40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(SRX.lpop[1], k_srx_p.lpop_b) annotation (Line(
          points={{-40.2,40.4},{-34,40.4},{-34,20}},
          color={107,45,134},
          thickness=1));
      connect(SRX.lpop[2], kH_srx.lpop_a) annotation (Line(
          points={{-40.2,40.4},{-40.2,40},{-6,40}},
          color={107,45,134},
          thickness=1));
    end XBCycling_SrxTD;

    model XBCycling_SrxTD_reversekH "With reverse hydrolysis enabled"
      extends Configurations.XBCycling_SrxTD(
        DRX_T(nPorts=6),
        DRX_D(nPorts=4),
        tune_a=0.5248844775533099,
        tune_b=0.0009526757598301765,
        tune_c=1.107347763780688,
        kH(k(displayUnit="s-1") = k_h),
        kH_srx(k=k_h, useRateOutput=false));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH1(
        k(displayUnit="s-1") = 1.6,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=false)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=180,
            origin={0,-50})));
      parameter Bodylight.Types.PopulationChange k_h(displayUnit="1/s") = 20
        "hydrolysis rate";
    equation
      connect(kH1.lpop_b, DRX_T.lpop[6]) annotation (Line(
          points={{-10,-50},{-16,-50},{-16,-40},{-40,-40}},
          color={107,45,134},
          thickness=1));
      connect(kH1.lpop_a, DRX_D.lpop[4]) annotation (Line(
          points={{10,-50},{24,-50},{24,-39.85},{40,-39.85},{40,-40}},
          color={107,45,134},
          thickness=1));
    end XBCycling_SrxTD_reversekH;

    model XBLeaking "Default base class"

      extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.RealExpression rateDRXDOut(y=if time > -ageTime
        then k_leak.k else 0)
        annotation (Placement(transformation(extent={{38,-86},{18,-66}})));
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
        k(displayUnit="s-1") = 16,
        useRateInput=true,
        useDynamicFlowLabeling=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-32,-66})));
      Modelica.Blocks.Sources.RealExpression rateA2Out(y=if time > -ageTime and
            A2.pop > 1e-6 then k2.k else 0)
        annotation (Placement(transformation(extent={{-88,-86},{-68,-66}})));
      Modelica.Blocks.Sources.RealExpression labelA2Out(y=if time > 0 then rho
             elseif time < 0 and time > -ageTime then 1 else 0)
        annotation (Placement(transformation(extent={{-68,-74},{-48,-58}})));
      parameter Bodylight.Types.Concentration CmantATP=0.25;
      parameter Bodylight.Types.Concentration CATP=4
        "Unlabeled ATP concentration";
    public
      parameter Real k=0.016666666666666666;
      Bodylight.Population.LabeledPopulation.Components.StateCompartment SRX(
          pop_start=1e-6)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment DRX_T(
          pop_start=max(1e-6, 1 - A2.pop_start - SRX.pop_start - DRX_D.pop_start), nPorts=
            3)
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment DRX_D(
          pop_start=max(1e-6, 0.95 - A2.pop_start), nPorts=3)
        annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH(
        k(displayUnit="s-1") = 80,
        allowReverse=true,
        useRateOutput=false)
        annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_leak(
        k=tune_c,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=false,
        useRateInput=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,-96})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment A2(pop_start
          =0.8,          nPorts=2) "Attached state"
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
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_mH(
        k(displayUnit="s-1") = 1.6,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=false) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,-34})));
    equation
      der(photobleaching) = if time > photobleachingTime then -photobleaching*k_pb else 0;
      totalLabelNorm = totalLabel_PB/normFactor + timeTable_ATPChase.offset;
      when time >= 0 then
        normFactor = (totalLabel_PB + background)/(timeTable_ATPChase.maxScale - timeTable_ATPChase.offset);
        SRX_fraction = SRXLabel.y/totalLabel.y;
      end when;

      connect(rateDRXDOut.y, k_leak.rateInput) annotation (Line(points={{17,-76},{16,
              -76},{16,-92},{10,-92}}, color={0,0,127}));
      connect(kH.lpop_b, DRX_D.lpop[1]) annotation (Line(
          points={{10,-40},{26,-40},{26,-40.25},{40,-40.25}},
          color={107,45,134},
          thickness=1));
      connect(k2.lpop_a, A2.lpop[1]) annotation (Line(
          points={{-32,-76},{-32,-100},{-40,-100},{-40,-100.25}},
          color={107,45,134},
          thickness=1));
      connect(labelA2Out.y, k2.labelInput)
        annotation (Line(points={{-47,-66},{-44,-66},{-44,-72},{-36,-72}},
                                                       color={0,0,127}));
      connect(k2.rateInput, rateA2Out.y) annotation (Line(points={{-28,-76},{-52,-76},
              {-52,-76},{-67,-76}},
                          color={0,0,127}));
      connect(timeTable_ATPChase.y, sqDiffIntegrator.u1) annotation (Line(
            points={{-39,90},{-38,90.4},{3.2,90.4}}, color={0,0,127}));
      connect(sqDiffIntegrator.u2, totalLabelNorm_expr.y) annotation (Line(
            points={{3.2,85.6},{-10,85.6},{-10,78},{-13,78}}, color={0,0,127}));
      connect(DRX_T.lpop[1], kH.lpop_a) annotation (Line(
          points={{-40,-40.25},{-40,-40},{-10,-40}},
          color={107,45,134},
          thickness=1));
      connect(DRX_T.lpop[2], k2.lpop_b) annotation (Line(
          points={{-40,-40},{-40,-40},{-32,-40},{-32,-56}},
          color={107,45,134},
          thickness=1));
      connect(k_leak.lpop_b, A2.lpop[2]) annotation (Line(
          points={{-10,-96},{-32,-96},{-32,-99.75},{-40,-99.75}},
          color={107,45,134},
          thickness=1));
      connect(k_leak.lpop_a, DRX_D.lpop[2]) annotation (Line(
          points={{10,-96},{40,-96},{40,-40}},
          color={107,45,134},
          thickness=1));
      connect(k_mH.lpop_b, DRX_T.lpop[3]) annotation (Line(
          points={{-10,-34},{-16,-34},{-16,-40},{-40,-40},{-40,-39.6667}},
          color={107,45,134},
          thickness=1));
      connect(k_mH.lpop_a, DRX_D.lpop[3]) annotation (Line(
          points={{10,-34},{18,-34},{18,-40.25},{40,-40.25},{40,-39.6667}},
          color={107,45,134},
          thickness=1));
      annotation (Documentation(info="<html><p>This class was automatically generated by the Optimization Library. It includes an inherited class with optimized tuner values. More information is found in the text layer of the class.</p></html>"));

    end XBLeaking;

    model XBLeaking_SrxTD
      "Alternative configuration, where a separate SRX_ADP state exists and transitions to DRX_ADP"
      import mantATP;
      extends XBLeaking(
        DRX_D(nPorts=3),
        SRXLabel(y=SRX.labelAmount + SRX_D.labelAmount),
        tune_a=0.4389320387284864,
        tune_b=0.08804382574240988,
        tune_c=1.0150553374423377,
        DRX_T(nPorts=4),
        SRX(nPorts=3),
        k_mH(k=if kH_D == 0 then 0 else kH.k/kH_D));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m(k(
            displayUnit="s-1") = tune_a) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,10})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment SRX_D(pop_start
          =1e-6, nPorts=3)
        annotation (Placement(transformation(extent={{60,40},{40,60}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH2(
        k=kH.k,
        allowReverse=true,
        useRateOutput=false)
        annotation (Placement(transformation(extent={{-6,30},{14,50}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_p(k=tune_b)     annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-34,10})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_mH2(
        k(displayUnit="s-1") = k_mH.k,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=false) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={4,46})));
      parameter Bodylight.Types.PopulationChange kH_D(displayUnit="s-1")=0
        "Dissociation constant for ATP <> ADP.Pi reaction, i.e. steady state ADP.Pi / ATP ratio. Default 10.";
      Bodylight.Types.Population SRXpop = SRX.pop + SRX_D.pop;
    equation
      connect(k_srx_m.lpop_b, DRX_D.lpop[3]) annotation (Line(
          points={{40,0},{40,-40},{40.2,-40},{40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(kH2.lpop_b, SRX_D.lpop[1]) annotation (Line(
          points={{14,40},{36,40},{36,39.75},{40,39.75}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m.lpop_a, SRX_D.lpop[2]) annotation (Line(
          points={{40,20},{40,40.65},{40.2,40.65}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_a, DRX_T.lpop[4]) annotation (Line(
          points={{-34,0},{-34,-40},{-40.2,-40},{-40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(SRX.lpop[1], k_srx_p.lpop_b) annotation (Line(
          points={{-40.2,40.4},{-34,40.4},{-34,20}},
          color={107,45,134},
          thickness=1));
      connect(SRX.lpop[2], kH2.lpop_a) annotation (Line(
          points={{-40,40},{-40,40},{-6,40}},
          color={107,45,134},
          thickness=1));
      connect(k_mH2.lpop_b, SRX.lpop[3]) annotation (Line(
          points={{-6,46},{-20,46},{-20,40},{-40,40}},
          color={107,45,134},
          thickness=1));
      connect(k_mH2.lpop_a, SRX_D.lpop[3]) annotation (Line(
          points={{14,46},{26,46},{26,40.3333},{40,40.3333}},
          color={107,45,134},
          thickness=1));
    end XBLeaking_SrxTD;

    model XBLeaking_SrxTD_reversekH "with reverse hydrolysis"
      extends XBLeaking_SrxTD(
        kH_D=10,
        tune_c=0.07445006859374999,
        tune_a=0.008058119529687501,
        tune_b=0.036718204338541664,
        A2(pop_start=0.8));
    end XBLeaking_SrxTD_reversekH;

    model XBLeaking_SrxTD_reversekH_revSRXT
      extends XBLeaking_SrxTD_reversekH(
        SRX(nPorts=4),
        DRX_T(nPorts=5),
        tune_a=0.005647158341646327,
        tune_b=0.0007975225749726164,
        tune_c=1.1262528747599172,
        kH(k=20));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m1(k(
            displayUnit="s-1") = 0.08) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-46,10})));
    equation
      connect(k_srx_m1.lpop_a, SRX.lpop[4]) annotation (Line(
          points={{-46,20},{-46,40},{-40,40}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m1.lpop_b, DRX_T.lpop[5]) annotation (Line(
          points={{-46,0},{-46,-8},{-34,-8},{-34,-40},{-40.2,-40},{-40.2,-39.6},
              {-40,-40}},
          color={107,45,134},
          thickness=1));
    end XBLeaking_SrxTD_reversekH_revSRXT;

    model XBLeaking_SrxTD_reversekH_revSRXD
      extends XBLeaking_SrxTD_reversekH(
        kH(k=20),
        SRX_D(nPorts=4),
        DRX_D(nPorts=4));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m1(k(
            displayUnit="s-1") = 0.1)  annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=270,
            origin={46,10})));
    equation
      connect(k_srx_m1.lpop_b, SRX_D.lpop[4]) annotation (Line(
          points={{46,20},{46,28},{40,28},{40,40}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m1.lpop_a, DRX_D.lpop[4]) annotation (Line(
          points={{46,0},{46,-4},{40,-4},{40,-40}},
          color={107,45,134},
          thickness=1));
    end XBLeaking_SrxTD_reversekH_revSRXD;

    model XBLeaking_SrxTD_reversekH_slowkH
      extends XBLeaking_SrxTD_reversekH(kH(k=18));
    end XBLeaking_SrxTD_reversekH_slowkH;

    model XBLeaking_SrxTD_reversekH_Rbalanced
      extends XBLeaking_SrxTD_reversekH(
        k_leak(useRateInput=false),
        A2(nPorts=3),
        DRX_D(nPorts=4));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_mleak_transition(
        k=tune_c*k_mleak,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=false,
        useRateInput=true) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={0,-100})));
      parameter Bodylight.Types.PopulationChange k_mleak(displayUnit="s-1") = 0.1;
      Modelica.Blocks.Sources.RealExpression rateDRXDOut1(y=k_mleak_autoreg)
        annotation (Placement(transformation(extent={{-80,-120},{-60,-100}})));
      Bodylight.Types.PopulationChange k_mleak_autoreg;
      parameter Real lmbd = 10;
    equation
      if time < -ageTime then
        der(k_mleak_autoreg) = -lmbd*(A2.pop_start - A2.pop);
      else
        der(k_mleak_autoreg) = 0;
      end if;

      connect(k_mleak_transition.lpop_a, A2.lpop[3]) annotation (Line(
          points={{-10,-100},{-40,-100}},
          color={107,45,134},
          thickness=1));
      connect(k_mleak_transition.lpop_b, DRX_D.lpop[4]) annotation (Line(
          points={{10,-100},{40,-100},{40,-40}},
          color={107,45,134},
          thickness=1));
      connect(rateDRXDOut1.y, k_mleak_transition.rateInput) annotation (Line(
            points={{-59,-110},{-20,-110},{-20,-104},{-10,-104}}, color={0,0,
              127}));
    end XBLeaking_SrxTD_reversekH_Rbalanced;

    model XBLeaking_SrxTD_TOnly
      "Alternative configuration, where a separate SRX_ADP state exists and transitions to DRX_ADP"
      import mantATP;
      extends XBLeaking(
        DRX_D(pop_start=1e-6,
              nPorts=3),
        SRXLabel(y=SRX.labelAmount + SRX_D.labelAmount),
        tune_a=0.4389320387284864,
        tune_b=0.08804382574240988,
        tune_c=1.0150553374423377,
        DRX_T(nPorts=6),
        SRX(nPorts=4),
        k_mH(k=if kH_D == 0 then 0 else kH.k/kH_D, disableTransition=true),
        kH(k=0, disableTransition=true),
        k_leak(disableTransition=true),
        A2(nPorts=3));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m(k(
            displayUnit="s-1") = tune_a, disableTransition=true)
                                         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,10})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment SRX_D(pop_start
          =1e-6, nPorts=3)
        annotation (Placement(transformation(extent={{60,40},{40,60}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH2(
        k=kH.k,
        allowReverse=true,
        useRateOutput=false,
        disableTransition=true)
        annotation (Placement(transformation(extent={{-6,30},{14,50}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_p(k=tune_b)     annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-34,10})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_mH2(
        k(displayUnit="s-1") = k_mH.k,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=false,
        disableTransition=true)       annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={4,46})));
      parameter Bodylight.Types.PopulationChange kH_D(displayUnit="s-1")=0
        "Dissociation constant for ATP <> ADP.Pi reaction, i.e. steady state ADP.Pi / ATP ratio. Default 10.";
      Bodylight.Types.Population SRXpop = SRX.pop + SRX_D.pop;
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_leak1(
        disableTransition=false,
        k=tune_c,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=false,
        useRateInput=true) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-2,-72})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m1(k(
            displayUnit="s-1") = tune_a, disableTransition=false)
                                         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-50,8})));
    equation
      connect(k_srx_m.lpop_b, DRX_D.lpop[3]) annotation (Line(
          points={{40,0},{40,-40},{40,-39.6667},{40,-39.6667}},
          color={107,45,134},
          thickness=1));
      connect(kH2.lpop_b, SRX_D.lpop[1]) annotation (Line(
          points={{14,40},{36,40},{36,39.6667},{40,39.6667}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m.lpop_a, SRX_D.lpop[2]) annotation (Line(
          points={{40,20},{40,40},{40,40}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_a, DRX_T.lpop[4]) annotation (Line(
          points={{-34,0},{-34,-40},{-40,-40},{-40,-40}},
          color={107,45,134},
          thickness=1));
      connect(SRX.lpop[1], k_srx_p.lpop_b) annotation (Line(
          points={{-40,40},{-34,40},{-34,20}},
          color={107,45,134},
          thickness=1));
      connect(SRX.lpop[2], kH2.lpop_a) annotation (Line(
          points={{-40,40},{-40,40},{-6,40}},
          color={107,45,134},
          thickness=1));
      connect(k_mH2.lpop_b, SRX.lpop[3]) annotation (Line(
          points={{-6,46},{-20,46},{-20,40},{-40,40}},
          color={107,45,134},
          thickness=1));
      connect(k_mH2.lpop_a, SRX_D.lpop[3]) annotation (Line(
          points={{14,46},{26,46},{26,40.3333},{40,40.3333}},
          color={107,45,134},
          thickness=1));
      connect(k_leak1.lpop_a, DRX_T.lpop[5]) annotation (Line(
          points={{-2,-62},{-2,-50},{-32,-50},{-32,-40},{-40,-40}},
          color={107,45,134},
          thickness=1));
      connect(k_leak1.lpop_b, A2.lpop[3]) annotation (Line(
          points={{-2,-82},{-32,-82},{-32,-100},{-40,-100}},
          color={107,45,134},
          thickness=1));
      connect(rateDRXDOut.y, k_leak1.rateInput) annotation (Line(points={{17,
              -76},{12,-76},{12,-54},{2,-54},{2,-62}}, color={0,0,127}));
      connect(k_srx_m1.lpop_a, SRX.lpop[4]) annotation (Line(
          points={{-50,18},{-50,36},{-40,36},{-40,40}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m1.lpop_b, DRX_T.lpop[6]) annotation (Line(
          points={{-50,-2},{-42,-2},{-42,-40},{-34,-40},{-40,-40.25},{-40,-40}},
          color={107,45,134},
          thickness=1));
    end XBLeaking_SrxTD_TOnly;
  end Configurations;

  package Experiments
    model XBCyclingSrxD_kHmant_40
      "Testing different hydrolysis rates for mant- and dark ATPs"
      extends Configurations.XBCycling_SrxD(
                                           kH(useRateInput=true),
        DRX_D(nPorts=5),
        DRX_T(nPorts=4),
        tune_a=1.0070454586754463,
        tune_b=0.7924271174395131,
        tune_c=1.0240660157604076
        );
      Modelica.Blocks.Sources.RealExpression labelA2Out1(y=(1 - DRX_T.label)*kH_ATP)
        annotation (Placement(transformation(extent={{-94,-50},{-74,-34}})));
      Modelica.Blocks.Sources.RealExpression labelA2Out2(y=(DRX_T.label)*kH_mantATP)
        annotation (Placement(transformation(extent={{-94,-62},{-74,-46}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH_labeled(
        k(displayUnit="s-1") = 80,
        allowReverse=true,
        useRateInput=true,
        useRateOutput=false)
        annotation (Placement(transformation(extent={{-10,-46},{10,-66}})));

      parameter Bodylight.Types.PopulationChange kH_ATP = 80;
      parameter Bodylight.Types.PopulationChange kH_mantATP = 40;

    equation
      connect(labelA2Out1.y, kH.rateInput) annotation (Line(points={{-73,-42},{-10,-42}},
                                                        color={0,0,127}));
      connect(labelA2Out2.y,kH_labeled. rateInput) annotation (Line(points={{-73,-54},
              {-60,-54},{-60,-52},{-10,-52}}, color={0,0,127}));
      connect(kH_labeled.lpop_b, DRX_D.lpop[5]) annotation (Line(
          points={{10,-56},{24,-56},{24,-39.975},{40.2,-39.975},{40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(kH_labeled.lpop_a, DRX_T.lpop[4]) annotation (Line(
          points={{-10,-56},{-20,-56},{-20,-40},{-40.2,-40},{-40.2,-39.6}},
          color={107,45,134},
          thickness=1));
    end XBCyclingSrxD_kHmant_40;

    model SrxTD_mAdpAffinity
      "Testing how 10x mant-ADP affinity skews the results"
      extends Configurations.XBCycling_SrxTD(
        DRX_T(nPorts=6),
        DRX_D(nPorts=4),
        rateDRXDOut(y=if time > -ageTime then 0.066*tune_c*(1 - DRX_D.label)
               else 0),
        kH(k(displayUnit="s-1") = 20));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH_m_MANT(
        k=0.066*tune_c,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=true,
        useRateInput=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,6})));
      Modelica.Blocks.Sources.RealExpression rateDRXDOut1(y=if time > -ageTime
             then 0.066*tune_c*(DRX_D.label)/k_mantAff else 0)
        annotation (Placement(transformation(extent={{36,14},{16,34}})));
      parameter Real k_mantAff=10 "affinity multiplicator";
    equation
      connect(kH_m_MANT.lpop_b, DRX_T.lpop[6]) annotation (Line(
          points={{-10,6},{-16,6},{-16,-39.6},{-40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(kH_m_MANT.lpop_a, DRX_D.lpop[4]) annotation (Line(
          points={{10,6},{24,6},{24,-39.35},{40.2,-39.35},{40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(labelDRX_D.y, kH_m.labelInput)
        annotation (Line(points={{-3,-10},{6,-10},{6,-20}}, color={0,0,127}));
      connect(labelDRX_D.y, kH_m_MANT.labelInput)
        annotation (Line(points={{-3,-10},{6,-10},{6,2}}, color={0,0,127}));
      connect(rateDRXDOut1.y, kH_m_MANT.rateInput) annotation (Line(points={{15,
              24},{16,24},{16,10},{10,10}}, color={0,0,127}));
    end SrxTD_mAdpAffinity;

    model TestMinimalAlwaysOn "Testing the permanent active fraction of DRX"
      Bodylight.Population.LabeledPopulation.Components.StateCompartment SRX(pop_start
          =1e-9, nPorts=2)
        annotation (Placement(transformation(extent={{-44,48},{-24,68}})));
      Bodylight.Population.LabeledPopulation.Components.StateCompartment DRX_T(pop_start
          =0.5, nPorts=4)
        annotation (Placement(transformation(extent={{-44,-32},{-24,-12}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_m(k(
            displayUnit="s-1") = 1)
                         annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-14,28})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_srx_p(
          useRateInput=true, k(displayUnit="s-1") = 2)
                        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-4,28})));
      Modelica.Blocks.Sources.RealExpression labelDRX_D1(y=k_srx_p.k*(1 - minDRX/(
            DRX_T.pop + DRX_D.pop)))
        "Active ON myosins in the DRX_T state - simplified k_srx_p.k*(DRX_T.pop - minDRX*DRX_T.pop/(DRX_T.pop + DRX_D.pop))/DRX_T.pop"
        annotation (Placement(transformation(extent={{-44,-2},{-24,18}})));
      parameter Real minDRX=0.05;
      Bodylight.Population.LabeledPopulation.Components.StateCompartment DRX_D(pop_start
          =0.5, nPorts=2)
        annotation (Placement(transformation(extent={{72,-28},{52,-8}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH(
        k(displayUnit="s-1") = 10,
        allowReverse=true,
        useRateOutput=false)
        annotation (Placement(transformation(extent={{2,-24},{22,-44}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH_m(
        k(displayUnit="s-1") = 1,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=false,
        useRateInput=false)
                           annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={12,-20})));
      Real totalDRX=DRX_T.pop + DRX_D.pop;
      Real total=DRX_T.pop + DRX_D.pop + SRX.pop;
    equation
      connect(SRX.lpop[1],k_srx_m. lpop_a) annotation (Line(
          points={{-24.2,48.15},{-14,48.15},{-14,38}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_m.lpop_b,DRX_T. lpop[1]) annotation (Line(
          points={{-14,18},{-14,-31.975},{-24.2,-31.975}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_b,SRX. lpop[2]) annotation (Line(
          points={{-4,38},{-4,48},{-24.2,48},{-24.2,48.65}},
          color={107,45,134},
          thickness=1));
      connect(k_srx_p.lpop_a,DRX_T. lpop[2]) annotation (Line(
          points={{-4,18},{-4,12},{-14,12},{-14,-31.725},{-24.2,-31.725}},
          color={107,45,134},
          thickness=1));
      connect(labelDRX_D1.y, k_srx_p.rateInput)
        annotation (Line(points={{-23,8},{-8,8},{-8,18}}, color={0,0,127}));
      connect(kH.lpop_b,DRX_D. lpop[1]) annotation (Line(
          points={{22,-34},{36,-34},{36,-27.85},{52.2,-27.85}},
          color={107,45,134},
          thickness=1));
      connect(kH_m.lpop_a,DRX_D. lpop[2]) annotation (Line(
          points={{22,-20},{36,-20},{36,-27.35},{52.2,-27.35}},
          color={107,45,134},
          thickness=1));
      connect(kH_m.lpop_b, DRX_T.lpop[3]) annotation (Line(
          points={{2,-20},{-12,-20},{-12,-32},{-24.2,-32},{-24.2,-31.475}},
          color={107,45,134},
          thickness=1));
      connect(kH.lpop_a, DRX_T.lpop[4]) annotation (Line(
          points={{2,-34},{-24.2,-34},{-24.2,-31.225}},
          color={107,45,134},
          thickness=1));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=10,
          __Dymola_NumberOfIntervals=1500,
          __Dymola_Algorithm="Dassl"));
    end TestMinimalAlwaysOn;

    model XBCyclingSrxT_MinOn
      "Some minimal MyoII can't enter the SRX OFF state"
      extends Configurations.XBCycling_SrxT(
        k_srx_p(useRateInput=true));
      parameter Real minDRX=0.05
        "A minimal fraction of DRX which do not enter the SRX at all";
      Modelica.Blocks.Sources.RealExpression RateLimited_k_srx_p(y=k_srx_p.k*max(1 -
            minDRX/(DRX_T.pop + DRX_D.pop), 0))
        "There is at least minDRX active non-SRX myosins in both DRX states - simplified k_srx_p.k*(DRX_T.pop - minDRX*DRX_T.pop/(DRX_T.pop + DRX_D.pop))/DRX_T.pop"
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    equation
      connect(RateLimited_k_srx_p.y, k_srx_p.rateInput) annotation (Line(points={{-39,
              0},{-28,0},{-28,6},{-24,6},{-24,10}}, color={0,0,127}));
      annotation (experiment(
          StartTime=-600,
          StopTime=600,
          __Dymola_NumberOfIntervals=1500,
          __Dymola_Algorithm="Dassl"));
    end XBCyclingSrxT_MinOn;

    model XBCyclingSrxT_MinOn_opt "A slight change to fit exactly"
      extends XBCyclingSrxT_MinOn(
        tune_a=0.5237691067410988,
        tune_b=0.09902239908159749,
        tune_c=1.0802470424770516);
    end XBCyclingSrxT_MinOn_opt;

    model XBCyclingSrxT_MinOn_Active
      extends XBCyclingSrxT_MinOn(DRX_D(nPorts=3), A2(nPorts=2));
      Bodylight.Population.LabeledPopulation.Components.StateTransition ka(
        k(displayUnit="s-1") = 20,
        allowReverse=true,
        useRateOutput=false) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={30,-94})));
    equation
      connect(DRX_D.lpop[3], ka.lpop_a) annotation (Line(
          points={{40.2,-39.6},{46,-39.6},{46,-94},{40,-94}},
          color={107,45,134},
          thickness=1));
      connect(ka.lpop_b, A2.lpop[2]) annotation (Line(
          points={{20,-94},{14,-94},{14,-104},{-40.2,-104},{-40.2,-99.6}},
          color={107,45,134},
          thickness=1));
    end XBCyclingSrxT_MinOn_Active;

    model XBCycling_SrxTD_Active
      extends Configurations.XBCycling_SrxTD(
        A2(nPorts=2),
        DRX_D(nPorts=4),
        k_srx_p(useRateInput=true));
      Bodylight.Population.LabeledPopulation.Components.StateTransition ka(
        k(displayUnit="s-1") = 20,
        allowReverse=true,
        useRateOutput=false) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={30,-90})));
      Modelica.Blocks.Sources.RealExpression RateLimited_k_srx_p(y=k_srx_p.k*
            max(1 - minDRX/(DRX_T.pop + DRX_D.pop + A2.pop), 0))
        "There is at least minDRX active non-SRX myosins in both DRX states - simplified k_srx_p.k*(DRX_T.pop - minDRX*DRX_T.pop/(DRX_T.pop + DRX_D.pop))/DRX_T.pop"
        annotation (Placement(transformation(extent={{-82,-18},{-62,2}})));
      parameter Real minDRX=0.05 "Minimal amount of never SRX";
    equation
      connect(ka.lpop_b, A2.lpop[2]) annotation (Line(
          points={{20,-90},{-6,-90},{-6,-100},{-40.2,-100},{-40.2,-99.6}},
          color={107,45,134},
          thickness=1));
      connect(ka.lpop_a, DRX_D.lpop[4]) annotation (Line(
          points={{40,-90},{44,-90},{44,-44},{40.2,-44},{40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(RateLimited_k_srx_p.y, k_srx_p.rateInput) annotation (Line(points={{-61,-8},
              {-50,-8},{-50,-2},{-38,-2},{-38,0}},  color={0,0,127}));
    end XBCycling_SrxTD_Active;

    model SrxTD_SlowerK2
      extends Configurations.XBCycling_SrxTD(k2(k(displayUnit="s-1") = 17));
    end SrxTD_SlowerK2;

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

    model SrxTD_slowerkH
      extends Configurations.XBCycling_SrxTD(
        kH(k(displayUnit="s-1") = k_h),
        tune_a=0.4967568535801701,
        tune_b=0.023250848587955675,
        tune_c=1.0845101785047804,
        kH_srx(k(displayUnit="s-1") = k_h));
      parameter Bodylight.Types.PopulationChange k_h(displayUnit="s-1") = 20;
    end SrxTD_slowerkH;

    model SrxTD_AllAtOnce
      extends Configurations.XBCycling_SrxTD_reversekH(
        DRX_D(nPorts=5),
        A2(nPorts=2),
        k_srx_p(useRateInput=true),
        k2(k(displayUnit="s-1") = 17),
        tune_a=0.5243902483781083,
        tune_b=0.0012605541381524063,
        tune_c=1.0931381560819462);
      Bodylight.Population.LabeledPopulation.Components.StateTransition ka(
        k(displayUnit="s-1") = 20,
        allowReverse=true,
        useRateOutput=false,
        disableTransition=true)
                             annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={40,-92})));
      Modelica.Blocks.Sources.RealExpression RateLimited_k_srx_p(y=k_srx_p.k*
            max(1 - minDRX/(DRX_T.pop + DRX_D.pop), 0))
        "There is at least minDRX active non-SRX myosins in both DRX states - simplified k_srx_p.k*(DRX_T.pop - minDRX*DRX_T.pop/(DRX_T.pop + DRX_D.pop))/DRX_T.pop"
        annotation (Placement(transformation(extent={{-76,-14},{-56,6}})));
      parameter Real minDRX=0.05;
    equation
      connect(ka.lpop_a, DRX_D.lpop[5]) annotation (Line(
          points={{50,-92},{54,-92},{54,-44},{40.2,-44},{40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(ka.lpop_b, A2.lpop[2]) annotation (Line(
          points={{30,-92},{16,-92},{16,-100},{-40.2,-100},{-40.2,-99.6}},
          color={107,45,134},
          thickness=1));
      connect(RateLimited_k_srx_p.y, k_srx_p.rateInput) annotation (Line(points={{-55,-4},
              {-44,-4},{-44,2},{-38,2},{-38,0}},    color={0,0,127}));
    end SrxTD_AllAtOnce;

    model SrxTD_reversekH_fast "With reverse hydrolysis enabled"
      extends Configurations.XBCycling_SrxTD(
        DRX_T(nPorts=6),
        DRX_D(nPorts=4),
        tune_a=0.5248844775533099,
        tune_b=0.0009526757598301765,
        tune_c=1.107347763780688,
        kH(k(displayUnit="s-1") = k_h),
        kH_srx(k=k_h));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH1(
        k(displayUnit="s-1") = 16,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=false)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,-54})));
      parameter Bodylight.Types.PopulationChange k_h(displayUnit="1/s") = 200
        "hydrolysis rate";
    equation
      connect(kH1.lpop_b, DRX_T.lpop[6]) annotation (Line(
          points={{-10,-54},{-16,-54},{-16,-40},{-40.2,-40},{-40.2,-39.6}},
          color={107,45,134},
          thickness=1));
      connect(kH1.lpop_a, DRX_D.lpop[4]) annotation (Line(
          points={{10,-54},{24,-54},{24,-39.85},{40.2,-39.85},{40.2,-39.6}},
          color={107,45,134},
          thickness=1));
    end SrxTD_reversekH_fast;

    model SrxTD_reversekH_revSrxKH
      extends Configurations.XBCycling_SrxTD_reversekH(
        tune_a=0.5671780750101345,
        tune_b=0.000953338247995827,
        tune_c=1.1091349100644414,
        SRX(nPorts=3),
        SRX_D(nPorts=3));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH2(
        k(displayUnit="s-1") = 1.6,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=false)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={4,50})));
    equation
      connect(kH2.lpop_b, SRX.lpop[3]) annotation (Line(
          points={{-6,50},{-16,50},{-16,40.4},{-40.2,40.4}},
          color={107,45,134},
          thickness=1));
      connect(kH2.lpop_a, SRX_D.lpop[3]) annotation (Line(
          points={{14,50},{28,50},{28,40},{30,40},{30,40.15},{40.2,40.15},{40.2,
              40.4}},
          color={107,45,134},
          thickness=1));
    end SrxTD_reversekH_revSrxKH;

    model SrxTDR_redevelopment
      extends Configurations.XBLeaking_SrxTD_reversekH(k_srx_m(useRateInput=
              true));
      Modelica.Blocks.Sources.RealExpression rateDRXDOut1(y=if time > 0 and
            time < 10 then k_srx_m.k*100 else k_srx_m.k)
        annotation (Placement(transformation(extent={{74,14},{54,34}})));
    equation
      connect(rateDRXDOut1.y, k_srx_m.rateInput)
        annotation (Line(points={{53,24},{36,24},{36,20}}, color={0,0,127}));
    end SrxTDR_redevelopment;

    model SrxTDRL_mADPAff
      extends Configurations.XBLeaking_SrxTD_reversekH(
        rateDRXDOut(y=if time > -ageTime then k_leak.k*(1 - DRX_T.label) else 0),
        A2(nPorts=3),
        DRX_D(nPorts=4),
        tune_a=0.008480986608203124,
        tune_b=0.043998670054687494,
        tune_c=0.1159105259375);
      Bodylight.Population.LabeledPopulation.Components.StateTransition k_leak1(
        k=tune_c,
        allowReverse=true,
        useRateOutput=false,
        useDynamicFlowLabeling=false,
        useRateInput=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,-86})));
      Modelica.Blocks.Sources.RealExpression rateDRXDOut1(y=if time > -ageTime
             then k_leak.k*(DRX_T.label)*k_mantAff else 0)
        annotation (Placement(transformation(extent={{38,-68},{18,-48}})));
      parameter Real k_mantAff=0.5;
    equation
      connect(rateDRXDOut1.y, k_leak1.rateInput) annotation (Line(points={{17,
              -58},{10,-58},{10,-82}}, color={0,0,127}));
      connect(k_leak1.lpop_b, A2.lpop[3]) annotation (Line(
          points={{-10,-86},{-18,-86},{-18,-96},{-32,-96},{-32,-99.75},{-40,
              -99.75},{-40,-100}},
          color={107,45,134},
          thickness=1));
      connect(k_leak1.lpop_a, DRX_D.lpop[4]) annotation (Line(
          points={{10,-86},{40,-86},{40,-40}},
          color={107,45,134},
          thickness=1));
    end SrxTDRL_mADPAff;

    model SrxTDRL_mADPHydro "Different ADP hydrolysis rate"
      extends Configurations.XBLeaking_SrxTD_reversekH(
        kH(k=20, useRateInput=true),
        DRX_D(nPorts=4),
        DRX_T(nPorts=5),
        tune_a=0.00794993279140625,
        tune_b=0.021355124257523152,
        tune_c=0.08057622611111112);
      Modelica.Blocks.Sources.RealExpression labelA2Out1(y=(1 - DRX_T.label)*kH.k)
        annotation (Placement(transformation(extent={{-100,-52},{-80,-36}})));
      Modelica.Blocks.Sources.RealExpression labelA2Out2(y=(DRX_T.label)*kH.k*
            k_mantADPH)
        annotation (Placement(transformation(extent={{-100,-64},{-80,-48}})));
      Bodylight.Population.LabeledPopulation.Components.StateTransition kH1(
        k(displayUnit="s-1") = 20,
        useRateInput=true,
        allowReverse=true,
        useRateOutput=false)
        annotation (Placement(transformation(extent={{-10,-62},{10,-42}})));
      parameter Real k_mantADPH=0.5 "Multiplier of mantADP hydrolysis rate";
    equation
      connect(labelA2Out1.y, kH.rateInput)
        annotation (Line(points={{-79,-44},{-10,-44}}, color={0,0,127}));
      connect(kH1.lpop_b, DRX_D.lpop[4]) annotation (Line(
          points={{10,-52},{18,-52},{18,-40},{26,-40},{26,-40.25},{40,-40.25},{
              40,-40}},
          color={107,45,134},
          thickness=1));
      connect(kH1.lpop_a, DRX_T.lpop[5]) annotation (Line(
          points={{-10,-52},{-16,-52},{-16,-40},{-40,-40}},
          color={107,45,134},
          thickness=1));
      connect(kH1.rateInput, labelA2Out2.y)
        annotation (Line(points={{-10,-56},{-79,-56}}, color={0,0,127}));
    end SrxTDRL_mADPHydro;
  end Experiments;
  annotation (uses(Modelica(version="4.0.0"), Bodylight(version="1.0")));
end mantATP;
