function genotype = crossover_2(P,parents,fn)
%PはすべてのAgentの集合
%parentsは有用なAgentの格納位置のリスト
%

    n_bit = size(P(1).g,2);
    
    if fn =="f1"

        n_x =3;
    elseif fn =="f2"
 
        n_x = 2;
    end
    n_parents = size(parents,2);
    point = randi([2,(n_bit)*n_x-1],1);
    parent = randi([1,n_parents],1,2);
    parent_1 = reshape(P( parents(parent(1) ) ).g,[1,n_bit*n_x] );
    parent_2 = reshape(P( parents(parent(1) ) ).g,[1,n_bit*n_x] );
    
    genotype = parent_1;
    genotype(point:end) =  parent_2(point:end);
    
    genotype = reshape(genotype,[n_x,n_bit]);

end