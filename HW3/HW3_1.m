%naive multiply
function [C, global_mem_read_count] = HW3_1(A, B)
    %size
    n = size(A, 1); %get the number of rows(first dimension) of matrix A
    n1 = n;
    n2 = n;
    n3 = n;
    %init matrix C and mem_read_count
    C = zeros(n, n);
    global_mem_read_count = 0;

    %cal entries in C
    for i = 1 : n1
        for j = 1 : n3
            A_global = A(i, :);
            B_global = B(:, j);
            a_i_shared = A_global;
            b_j_shared = B_global;
            global_mem_read_count = global_mem_read_count + 2;
            c_ij_shared = dot(a_i_shared, b_j_shared);
            C(i, j) = c_ij_shared;
        end
    end
end
