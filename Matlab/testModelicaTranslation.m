    % Define Parameters
    A_nPorts = 2;
    A_m_start = 0.5;
    A_initialLabel = 1.0;
    
    stateTransition_k = 1;
    stateTransition_allowReverse = true;
    
    B_nPorts = 2;
    B_m_start = 0.5;
    B_initialLabel = 0.0;
    
    stateTransition1_k = 0.1;
    stateTransition1_allowReverse = true;
    
    % Initial Conditions
    A_labelAmount_0 = A_m_start * A_initialLabel;
    B_labelAmount_0 = B_m_start * B_initialLabel;
    
    y0 = [A_m_start, A_labelAmount_0, B_m_start, B_labelAmount_0];

    % Time Span
    tspan = [0 10];

    % Solve ODE
    [t, y] = ode45(@(t, y) modelEquations(t, y, stateTransition_k, stateTransition1_k, stateTransition_allowReverse, stateTransition1_allowReverse), tspan, y0);

    % Plot Results
    figure;
    plot(t, y(:,1), 'r', t, y(:,3), 'b');
    xlabel('Time');
    ylabel('Amount of Substance');
    legend('A.m', 'B.m');
    title('State Compartment Dynamics');
    grid on;

function dydt = modelEquations(t, y, stateTransition_k, stateTransition1_k, allowReverse, allowReverse1)
    % Unpack state variables
    A_m = y(1);
    A_labelAmount = y(2);
    B_m = y(3);
    B_labelAmount = y(4);

    % Define transition rates
    stateTransition_rate = stateTransition_k;
    stateTransition1_rate = stateTransition1_k;

    % Compute label concentrations
    A_label_concentration = A_labelAmount / A_m;
    B_label_concentration = B_labelAmount / B_m;

    % State Transitions Logic
    labelIn1 = (t > 1) && (t < 2); % Condition in Modelica
    labelOut1 = false;

    % Compute flow rates
    stateTrans_in_q = allowReverse * A_m * stateTransition_rate;
    stateTrans_out_q = -stateTrans_in_q;

    stateTrans1_in_q = allowReverse1 * B_m * stateTransition1_rate;
    stateTrans1_out_q = -stateTrans1_in_q;

    % Differential Equations
    dA_m = stateTrans_out_q;
    dA_labelAmount = A_label_concentration * stateTrans_out_q;
    
    dB_m = stateTrans1_out_q;
    dB_labelAmount = B_label_concentration * stateTrans1_out_q;
    
    dydt = [dA_m; dA_labelAmount; dB_m; dB_labelAmount];
end
