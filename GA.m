function [xGA, fval, fvalHistory] = GA(fn)
    
    ITERATION = 10000;
    agent_num = 100;
    P = [];
    pm = 0.3;
    if fn == "f1"
        %number_of_vars = 3;
        %xGA = [0,0,0];
        n = 10;
        for i = 1:agent_num %3x10x100?øΩ?øΩP?øΩ?øΩ?øΩ?ê¨?øΩ?øΩ?øΩ?øΩ
            P(i).g = de2bi(randi([0,1023],1,3),n);%genotype?øΩÕÇQ?øΩi?øΩ?øΩ
            P(i).f = 0;
        end
        
        evaluationFunction = str2func(fn);
    elseif fn == "f2"
        %number_of_vars = 2;
        %xGA = [0,0];
        n = 12;
        for i = 1:agent_num %3x12x100?øΩ?øΩP?øΩ?øΩ?øΩ?ê¨?øΩ?øΩ?øΩ?øΩ
            P(i).g = de2bi(randi([0,4095],1,2),n);%genotype?øΩÕÇQ?øΩi?øΩ?øΩ
            P(i).f = 0;
        end
        evaluationFunction = str2func(fn);
    end
    fval = 0;
    fvalHistory = zeros(ITERATION,1);
    
    
    for i = 1:ITERATION
        %tic;
        for j = 1:agent_num
            %tic;
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
        
        fval=fitness(1);
        fvalHistory(i) = fval;
        n_parent =  int8(agent_num/10);
        parents = num(1:n_parent);
        
        
        
        P_next = P(parents);
        %tic;
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
        %toc
        
        P = P_next;
       %toc 
    end
    xGA = P( [P.f] == fval ).g;
    
end
