function [xGA, fval, fvalHistory] = DE(fn)

    addpath('./differentialevolution');

    if fn == "f1"
        number_of_vars = 3;
        xGA = [0 0 0];
        [xGA, fval, fvalHistory] = problem_1();
    elseif fn == "f2"
        number_of_vars = 2;
        xGA = [0 0];
        [xGA, fval, fvalHistory] = problem_2();
    end
    
end