%Question e

%Question i
A1 = rand(8, 3);
A2 = rand(3, 8);
A = A1 * A2;

%Check the rank of A
fprintf('Matrix A has rank %d\n', rank(A));

%Question ii
B1 = rand(6, 4);
B2 = rand(4, 9);
B = B1 * B2;

%Check the rank of B
fprintf('Matrix B has rank %d\n', rank(B));

%Question iii
C1 = rand(10, 5);
C2 = rand(5, 7);
C = C1 * C2;

%Check the rank of C
fprintf('Matrix C has rank %d\n', rank(C));