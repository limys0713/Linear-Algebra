%Question a
%Generate random matrices 
A1 = rand(6, 6);
A2 = rand(8, 6);
A3 = rand(5, 8);

%Rank
rank_A1 = rank(A1);
rank_A2 = rank(A2);
rank_A3 = rank(A3);

%Check whether the matrices have full rank or are rank deficient
if rank_A1 == min(size(A1))
    fprintf('Matrix A1 is full rank\n');
else
    fprintf('Matrix A1 is rank deficient\n');
end

if rank_A2 == min(size(A2))
    fprintf('Matrix A2 is full rank\n');
else
    fprintf('Matrix A2 is rank deficient\n');
end

if rank_A3 == min(size(A3))
    fprintf('Matrix A3 is full rank\n');
else
    fprintf('Matrix A3 is rank deficient\n');
end
