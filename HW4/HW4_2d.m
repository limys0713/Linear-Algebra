%Question d
%Generate random matrices
X = rand(8, 2);
Y = rand(6, 2);

%Compute the product A = X * Y'
A = X * Y';

%Check the rank of A
fprintf('Matrix A has rank %d\n', rank(A));