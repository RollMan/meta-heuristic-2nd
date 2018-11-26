clear variables;
close all;

rng('shuffle');

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
fvalHistoryGA = 0;
xDE = 0;
fvalHistoryDE = 0;
xPSO = 0;
fvalHistoryPSO = 0;
fn = {"f1", "f2"};
for fidx = 1:2
    for cnt = 1:1
        % GA
        
        tic;
        [xGA, fval, fvalHistoryGA] = GA(fn{fidx});
        t = toc
        
        % value
        result{fidx, 1, 1, 1} = result{fidx, 1, 1, 1} + fval;
        result{fidx, 1, 1, 2} = max(result{fidx, 1, 1, 2}, fval);
        result{fidx, 1, 1, 2} = min(result{fidx, 1, 1, 2}, fval);

        % time
        result{fidx, 1, 2, 1} = result{fidx, 1, 2, 1} + fval;
        result{fidx, 1, 2, 2} = max(result{fidx, 1, 2, 2}, fval);
        result{fidx, 1, 2, 2} = min(result{fidx, 1, 2, 2}, fval);
        
        % DE
        tic;
        [xDE, fval, fvalHistoryDE] = DE(fn{fidx});
        t = toc
        
        % value
        result{fidx, 2, 1, 1} = result{fidx, 1, 1, 1} + fval;
        result{fidx, 2, 1, 2} = max(result{fidx, 1, 1, 2}, fval);
        result{fidx, 2, 1, 2} = min(result{fidx, 1, 1, 2}, fval);

        % time
        result{fidx, 2, 2, 1} = result{fidx, 1, 2, 1} + fval;
        result{fidx, 2, 2, 2} = max(result{fidx, 1, 2, 2}, fval);
        result{fidx, 2, 2, 2} = min(result{fidx, 1, 2, 2}, fval);
        
        % PSO
        tic;
        [xPSO, fval, fvalHistoryPSO] = PSO(fn{fidx});
        t = toc
        
        % value
        result{fidx, 3, 1, 1} = result{fidx, 1, 1, 1} + fval;
        result{fidx, 3, 1, 2} = max(result{fidx, 1, 1, 2}, fval);
        result{fidx, 3, 1, 2} = min(result{fidx, 1, 1, 2}, fval);

        % time
        result{fidx, 3, 2, 1} = result{fidx, 1, 2, 1} + fval;
        result{fidx, 3, 2, 2} = max(result{fidx, 1, 2, 2}, fval);
        result{fidx, 3, 2, 2} = min(result{fidx, 1, 2, 2}, fval);
    end
    
    for i = 1:3
        for j = 1:2
            result{fidx, i, j, 1} = result{fidx, i, j, 1} / 10.0;
        end
    end
end

% ===== Plot =====
% ----- GA -----
figure;
plot(fvalHistoryGA);

xlabel('Iteration');
ylabel('Best fval');
title('Best Evaluation Value History of GA');

% ----- DE ------
figure;
plot(fvalHistoryDE);

xlabel('Iteration');
ylabel('Best fval');
title('Best Evaluation Value History of DE');

% ----- PSO -----
figure;
plot(fvalHistoryPSO);

xlabel('Iteration');
ylabel('Best fval');
title('Best Evaluation Value History of PSO');
