function [xGA, fval, fvalHistory] = PSO(fn)
    if fn == "f1"
        %% Problem Definiton
        evaluationFunction = str2func(fn);
        problem.CostFunction = ...
            @(x1, x2, x3) evaluationFunction(x1, x2, x3);  % Cost Function
        problem.nVar = 3;         % Number of Unknown (Decision) Variables
        problem.VarMin =  -5.11;  % Lower Bound of Decision Variables
        problem.VarMax =   5.12;  % Upper Bound of Decision Variables

    elseif fn == "f2"
        %% Problem Definiton
        evaluationFunction = str2func(fn);
        problem.CostFunction = ...
            @(x1, x2) evaluationFunction(x1, x2);  % Cost Function
        problem.nVar = 2;          % Number of Unknown (Decision) Variables
        problem.VarMin = -2.047;   % Lower Bound of Decision Variables
        problem.VarMax =  2.048;   % Upper Bound of Decision Variables

    end

    %% Parameters of PSO

    params.MaxIt = 2000;        % Maximum Number of Iterations
    params.nPop = 50;           % Population Size (Swarm Size)
    params.w = 0.4;             % Intertia Coefficient
    params.wdamp = 1.00001;     % Increasing Ratio of Inertia Coefficient
    params.c1 = 2;              % Personal Acceleration Coefficient
    params.c2 = 2;              % Social Acceleration Coefficient
    params.ShowIterInfo = true; % Flag for Showing Iteration Informatin

    %% Calling PSO

    out = psoProcessing(problem, params);

    BestSol = out.BestSol;
    BestCosts = out.BestCosts;

    %% Results
    
    %{
    figure;
    % plot(BestCosts, 'LineWidth', 2);
    semilogy(BestCosts, 'LineWidth', 2);
    xlabel('Iteration');
    ylabel('Best Cost');
    grid on;
    %}
    
    xGA  = BestSol.Position;
    fval = BestSol.Cost;
    fvalHistory = BestCosts;
end

function out = psoProcessing(problem, params)

    %% Problem Definiton

    CostFunction = problem.CostFunction;  % Cost Function

    nVar = problem.nVar;        % Number of Unknown (Decision) Variables

    VarSize = [1 nVar];         % Matrix Size of Decision Variables

    VarMin = problem.VarMin;	% Lower Bound of Decision Variables
    VarMax = problem.VarMax;    % Upper Bound of Decision Variables


    %% Parameters of PSO

    MaxIt = params.MaxIt;   % Maximum Number of Iterations

    nPop = params.nPop;     % Population Size (Swarm Size)

    w = params.w;           % Intertia Coefficient
    wdamp = params.wdamp;   % Increasing Ratio of Inertia Coefficient
    c1 = params.c1;         % Personal Acceleration Coefficient
    c2 = params.c2;         % Social Acceleration Coefficient

    % The Flag for Showing Iteration Information
    ShowIterInfo = params.ShowIterInfo;    

    MaxVelocity = 0.2*(VarMax-VarMin);
    MinVelocity = -MaxVelocity;
    
    %% Initialization

    % The Particle Template
    empty_particle.Position = [];
    empty_particle.Velocity = [];
    empty_particle.Cost = [];
    empty_particle.Best.Position = [];
    empty_particle.Best.Cost = [];

    % Create Population Array
    particle = repmat(empty_particle, nPop, 1);

    % Initialize Global Best
    GlobalBest.Cost = inf;

    % Initialize Population Members
    for i=1:nPop

        % Generate Random Solution
        particle(i).Position = unifrnd(VarMin, VarMax, VarSize);

        % Initialize Velocity
        particle(i).Velocity = zeros(VarSize);

        % Evaluation
        if nVar == 3
            particle(i).Cost = ...
                CostFunction(particle(i).Position(1), particle(i).Position(2), particle(i).Position(3));
        elseif nVar == 2
            particle(i).Cost = ...
                CostFunction(particle(i).Position(1), particle(i).Position(2));
        end

        % Update the Personal Best
        particle(i).Best.Position = particle(i).Position;
        particle(i).Best.Cost = particle(i).Cost;

        % Update Global Best
        if particle(i).Best.Cost < GlobalBest.Cost
            GlobalBest = particle(i).Best;
        end

    end

    % Array to Hold Best Cost Value on Each Iteration
    BestCosts = zeros(MaxIt, 1);


    %% Main Loop of PSO

    for it=1:MaxIt

        for i=1:nPop

            % Update Velocity
            particle(i).Velocity = w*particle(i).Velocity ...
                + c1*rand(VarSize).*(particle(i).Best.Position - particle(i).Position) ...
                + c2*rand(VarSize).*(GlobalBest.Position - particle(i).Position);

            % Apply Velocity Limits
            particle(i).Velocity = max(particle(i).Velocity, MinVelocity);
            particle(i).Velocity = min(particle(i).Velocity, MaxVelocity);
            
            % Update Position
            particle(i).Position = particle(i).Position + particle(i).Velocity;
            
            % Apply Lower and Upper Bound Limits
            particle(i).Position = max(particle(i).Position, VarMin);
            particle(i).Position = min(particle(i).Position, VarMax);

            % Evaluation
            if nVar == 3
                particle(i).Cost = ...
                    CostFunction(particle(i).Position(1), particle(i).Position(2), particle(i).Position(3));
            elseif nVar == 2
                particle(i).Cost = ...
                    CostFunction(particle(i).Position(1), particle(i).Position(2));
            end

            % Update Personal Best
            if particle(i).Cost < particle(i).Best.Cost

                particle(i).Best.Position = particle(i).Position;
                particle(i).Best.Cost = particle(i).Cost;

                % Update Global Best
                if particle(i).Best.Cost < GlobalBest.Cost
                    GlobalBest = particle(i).Best;
                end            

            end

        end

        % Store the Best Cost Value
        BestCosts(it) = GlobalBest.Cost;

        % Display Iteration Information
        if ShowIterInfo
            disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it))]);
        end

        % Increasing Inertia Coefficient
        w = w * wdamp;
        if w > 0.9
            w = 0.9;
        end

    end
    
    out.pop = particle;
    out.BestSol = GlobalBest;
    out.BestCosts = BestCosts;
    
end