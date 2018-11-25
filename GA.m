function [xGA, fval, fvalHistory] = GA(fn)
    if fn == "f1"
        number_of_vars = 3;
        xGA = [0 0 0];
        evaluationFunction = str2func(fn);
    elseif fn == "f2"
        number_of_vars = 2;
        xGA = [0 0];
        evaluationFunction = str2func(fn);
    end
    
    fval = 0;
    fvalHistory = [5 4 3 2 1 0];
end