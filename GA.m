function [xGA, fval, fvalHistory] = GA(fn)
    rng('shuffle');
    ITERATION = 10000;
    agent_num = 100;
    P = [];
    pm = 3;
    if fn == "f1"
        %number_of_vars = 3;
        xGA = [0,0,0];
        n = 10;
        for i = 1:agent_num %3x10x100ÇÃPÇçÏê¨Ç∑ÇÈ
            P(i).g = de2bi(randi([0,1023],1,3),n);%genotypeÇÕÇQêiêî
        end
        evaluationFunction = str2func(fn);
    elseif fn == "f2"
        %number_of_vars = 2;
        xGA = [0,0];
        n = 12;
        for i = 1:agent_num %3x12x100ÇÃPÇçÏê¨Ç∑ÇÈ
            P(i).g = de2bi(randi([0,4095],1,2),n);%genotypeÇÕÇQêiêî
        end
        evaluationFunction = str2func(fn);
    end
    fval = 0;
    fvalHistory = [];
    
    
    for i = 1:ITERATION
        for j = 1:agent_num
            
            if fn == "f1"
                Phenotype = (bi2de(P(j).g)-511)/100;
                P(j).f = evaluationFunction(Phenotype(1),Phenotype(2),Phenotype(3)) ;
            end
            
            if fn =="f2"
                Phenotype = (bi2de(P(j).g)-2047)/100;
                P(j).f = evaluationFunction(Phenotype(1),Phenotype(2)) ;
            end
            
           
            
            
        end
        [fitness,num] = sort([P.f]);
        fval=fitness(1)
        %i
        fvalHistory(i) = fval;
        n_parent =  int8(agent_num/10);
        parents = num(1:n_parent);
        
        
        
        P_next = P(parents);
        
        for j = n_parent+1:agent_num
            flag = randi([1,3]);
            if flag == 1 %selection
               
                point = randi([1,n_parent]);
                P_next(j).g = P(parents(point)).g;
               
            elseif flag == 2 %crossover
                
                P_next(j).g = crossover(P,parents,fn);
                
            elseif flag == 3 %mutation
                P_next(j).g = mutation(P,parents,fn,pm);
            end
        end
        
        P = P_next;
        
    end
    xGA = P( find([P.f] == fval) ).g;
end
