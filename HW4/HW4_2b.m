%Question b
%Generate random integer matrices in the range [1, 10]
B1 = round(9 * rand(10, 7)) + 1;
B2 = round(9 * rand(8, 12)) + 1;
B3 = round(9 * rand(10, 15)) + 1;

%Rank
rank_B1 = rank(B1);
rank_B2 = rank(B2);
rank_B3 = rank(B3);

%Check whether the matrices have full rank or are rank deficient
if rank_B1 == min(size(B1))
    fprintf('Matrix B1 is full rank\n');
else
    fprintf('Matrix B1 is rank deficient\n');
end

if rank_B2 == min(size(B2))
    fprintf('Matrix B2 is full rank\n');
else
    fprintf('Matrix B2 is rank deficient\n');
end

if rank_B3 == min(size(B3))
    fprintf('Matrix B3 is full rank\n');
else
    fprintf('Matrix B3 is rank deficient\n');
end