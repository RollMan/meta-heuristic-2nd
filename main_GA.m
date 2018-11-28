clear variables;
close all;

rng('default');

result = cell(2, 2, 3); %(problem, algorithm, {time, value}, {avg, max, min})

for k = 1:2
   
        for j = 1:2
            result{k, j, 1} = 0.0;
            result{k, j, 2} = -1;
            result{k, j, 3} = 1e9;
        end
    
end

xGA = 0;
fvalHistoryGA = {0, 0};

fn = {"f1", "f2"};
CNT = 10;
for fidx = 1:2
    for cnt = 1:CNT
        
        % GA
        
        tic;
        [xGA, fval, fvalHistoryGA_] = GA_2(fn{fidx});
        t = toc
        fvalHistoryGA{fidx} = fvalHistoryGA_;
        
        % time
        result{fidx, 1, 1} = result{fidx, 1, 1} + t;
        result{fidx, 1, 2} = max(result{fidx, 1, 2}, t);
        result{fidx, 1, 3} = min(result{fidx, 1, 3}, t);

        % value
        result{fidx, 2, 1} = result{fidx, 2, 1} + fval;
        result{fidx, 2, 2} = max(result{fidx, 2, 2}, fval);
        result{fidx, 2, 3} = min(result{fidx, 2, 3}, fval);
        
        
    end
    
 
        for j = 1:2
            result{fidx, j, 1} = result{fidx, j, 1} / CNT;
        end
    
end

% ===== Plot =====
for fidx = 1:2
    % ----- GA -----
    figure;
    plot(fvalHistoryGA{fidx});
    
    xlabel('Iteration', 'FontSize', 22);
    ylabel('Best fval', 'FontSize', 22);
    title(sprintf('Evaluation Value History of GA: %s', fn{fidx}), 'FontSize', 22);
    set(gca,'FontSize',22);

end
