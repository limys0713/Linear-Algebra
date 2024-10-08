W = triu(ones(4));
x = [1; 2; 3; 4];

%Question a
%L(w1) = w2
L_w1 = [0; 1; 0; 0];

%L(w2) = w3
L_w2 = [0; 0; 1; 0];

%L(w3) = 5w1 + 4w2 + 3w3 + 2w4
L_w3 = [5; 4; 3; 2];

%L(w4) = w1 + 2w2 + 3w3 + 4w4
L_w4 = [1; 2; 3; 4];

%Combine columns to form matrix A
A = [L_w1, L_w2, L_w3, L_w4];

disp('Matrix A:');
disp(A);

%Question b
%y = W^(-1) * x with respect to F
y = W \ x;

disp('Coordinate vector y with respect to F:');
disp(y);

%Question c
%coordinate vector z of L(x) with respect to F
Lx = A * y;

disp('Coordinate vector z of L(x) with respect to F:');
disp(Lx);

%Question d
%coordinate vector of L(x) with respect to the standard basis
Lx_standard = W * Lx;

disp('Coordinate vector of L(x) with respect to the standard basis:');
disp(Lx_standard);