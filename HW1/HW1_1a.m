A =  round(10 * rand(5));
B =  round(10 * rand(5));

%disp(A);
%disp(B);

A1 = A * B;
A2 = B * A;
A3 = (transpose((transpose(A) * transpose(B))));
A4 = (transpose((transpose(B) * transpose(A))));

disp(A1);
disp(A2);
disp(A3);
disp(A4);