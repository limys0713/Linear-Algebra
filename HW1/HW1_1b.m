A =  round(10 * rand(5));
B =  round(10 * rand(5));

%disp(A);
%disp(B);

A1 = A * (transpose(B));
A2 = (transpose(A)) * B;
A3 = (transpose(B * (transpose(A))));
A4 = (transpose((transpose(B)) * A));

disp(A1);
disp(A2);
disp(A3);
disp(A4);