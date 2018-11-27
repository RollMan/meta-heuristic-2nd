clear variables;
close all;

rng('default');

result = cell(2, 3, 2, 3); %(problem, algorithm, {value, time}, {avg, max, min})

for k = 1:2
    for i = 1:3
        for j = 1:2
            result{k, i, j, 1} = 0.0;
            result{k, i, j, 2} = -1;
            result{k, i, j, 3} = 1e9;
        end
    end
end

xGA = 0;
fvalHistoryGA = {0, 0};
xDE = 0;
fvalHistoryDE = {0, 0};
xPSO = 0;
fvalHistoryPSO = {0, 0};
fn = {"f1", "f2"};
CNT = 1;
for fidx = 1:2
    for cnt = 1:CNT
        
        % GA
        
        tic;
        [xGA, fval, fvalHistoryGA_] = GA(fn{fidx});
        t = toc
        fvalHistoryGA{fidx} = fvalHistoryGA_;
        
        % time
        result{fidx, 1, 1, 1} = result{fidx, 1, 1, 1} + t;
        result{fidx, 1, 1, 2} = max(result{fidx, 1, 1, 2}, t);
        result{fidx, 1, 1, 3} = min(result{fidx, 1, 1, 3}, t);

        % value
        result{fidx, 1, 2, 1} = result{fidx, 1, 2, 1} + fval;
        result{fidx, 1, 2, 2} = max(result{fidx, 1, 2, 2}, fval);
        result{fidx, 1, 2, 3} = min(result{fidx, 1, 2, 3}, fval);
        
        % DE
        tic;
        [xDE, fval, fvalHistoryDE_] = DE(fn{fidx});
        t = toc
        fvalHistoryDE{fidx} = fvalHistoryDE_;
        
        % time
        result{fidx, 2, 1, 1} = result{fidx, 2, 1, 1} + t;
        result{fidx, 2, 1, 2} = max(result{fidx, 2, 1, 2}, t);
        result{fidx, 2, 1, 3} = min(result{fidx, 2, 1, 3}, t);

        % value
        result{fidx, 2, 2, 1} = result{fidx, 2, 2, 1} + fval;
        result{fidx, 2, 2, 2} = max(result{fidx, 2, 2, 2}, fval);
        result{fidx, 2, 2, 3} = min(result{fidx, 2, 2, 3}, fval);
        
        % PSO
        
        tic;
        [xPSO, fval, fvalHistoryPSO_] = PSO(fn{fidx});
        t = toc
        fvalHistoryPSO{fidx} = fvalHistoryPSO_;
        
        % time
        result{fidx, 3, 1, 1} = result{fidx, 3, 1, 1} + t;
        result{fidx, 3, 1, 2} = max(result{fidx, 3, 1, 2}, t);
        result{fidx, 3, 1, 3} = min(result{fidx, 3, 1, 3}, t);

        % value
        result{fidx, 3, 2, 1} = result{fidx, 3, 2, 1} + fval;
        result{fidx, 3, 2, 2} = max(result{fidx, 3, 2, 2}, fval);
        result{fidx, 3, 2, 3} = min(result{fidx, 3, 2, 3}, fval);
        
    end
    
    for i = 1:3
        for j = 1:2
            result{fidx, i, j, 1} = result{fidx, i, j, 1} / CNT;
        end
    end
end

% ===== Plot =====
for fidx = 1:2
    % ----- GA -----
    figure;
    plot(fvalHistoryGA{fidx});
    
    xlabel('Iteration', 'FontSize', 22);
    ylabel('Best fval', 'FontSize', 22);
    title(sprintf('Best Evaluation Value History of GA: %s', fn{fidx}), 'FontSize', 22);
    set(gca,'FontSize',22);

    
    % ----- DE ------
    figure;
    plot(fvalHistoryDE{fidx});
    
    xlabel('Iteration', 'FontSize', 22);
    ylabel('Best fval', 'FontSize', 22);
    title(sprintf('Best Evaluation Value History of DE: %s', fn{fidx}), 'FontSize', 22);
    set(gca,'FontSize',22);
    
    % ----- PSO -----
    figure;
    plot(fvalHistoryPSO{fidx});
    
    xlabel('Iteration', 'FontSize', 22);
    ylabel('Best fval', 'FontSize', 22);
    title(sprintf('Best Evaluation Value History of PSO: %s', fn{fidx}), 'FontSize', 22);
    set(gca,'FontSize',22);
end
