function genotype = crossover(P,parents,fn)
%PはすべてのAgentの集合
%parentsは有用なAgentの格納位置のリスト
%

    if fn =="f1"
        n_bit = 10;
        n_x =3;
    elseif fn =="f2"
        n_bit = 12;
        n_x = 2;
    end
    n_parents = size(parents,2);
    point = randi([2,n_bit-1],1,n_x);
    parent = randi([1,n_parents],1,2);
    for i = 1:n_x
        genotype(i,1:point-1) = P(parents(parent(1) ) ).g(i,1:point-1);
        genotype(i,point:n_bit) = P(parents(parent(2) ) ).g(i,point:n_bit);
    end
end