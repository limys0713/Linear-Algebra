%Question c
%Generate vectors x and y
x = round(9 * rand(8, 1)) + 1;
y = round(9 * rand(6, 1)) + 1;

%Construct the matrix A
A = x * y';

%Check the rank of A
fprintf('Matrix A has rank %d\n', rank(A));
