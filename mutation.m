function genotype = mutation(P,parents,fn,pm)

    n_parents = size(parents,2);
    parent = randi([1,n_parents],1);
    origin = P(parent).g;
    genotype = origin;
    if fn =="f1"
        n_bit = 10;
        n_x = 3;
    elseif fn =="f2"
        n_bit = 12;
        n_x = 2;
    end
    
    for i = 1:n_x
        
        for j = 1:n_bit
            point = rand();
            if point <= pm
                genotype(i,j) = imcomplement(origin(i,j));
            else
                genotype(i,j) = origin(i,j);
            end
        end
    end
end
