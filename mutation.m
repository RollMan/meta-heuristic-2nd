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
    
    for i = 1:pm
        point = randi([1,n_bit],1,n_x);
        for j = 1:n_x
            genotype(j,point(j)) = imcomplement(origin(j,point(j)));
        end
    end
end
