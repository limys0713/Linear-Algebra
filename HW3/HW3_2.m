%tiled_multiply
function [C, global_mem_read_count] = HW3_2(A, B, m)
    %size
    n = size(A, 1); %get the number of rows(first dimension) of matrix A
    n1 = n;
    n2 = n;
    n3 = n;
    %init matrix C and mem_read_count
    C = zeros(n, n);
    global_mem_read_count = 0;

    %cal entries in C
    k1 = n1 / m;    %row
    k3 = n3 / m;    %column
    for i = 1 : k1
        for j = 1 : k3
            %cal the row and column numbers for the current tile
            A_global_row_start = (i - 1) * m + 1;
            A_global_row_end = i * m;
            B_global_col_start = (j - 1) * m + 1;
            B_global_col_end = j * m;

            %read from global mem
            A_global = A(A_global_row_start:A_global_row_end, :);
            B_global = B(:, B_global_col_start:B_global_col_end);
            a_i_shared = A_global;
            b_j_shared = B_global;

            global_mem_read_count = global_mem_read_count + 2 * m;

            c_ij_shared = a_i_shared * b_j_shared;
            C(A_global_row_start:A_global_row_end, B_global_col_start:B_global_col_end) = c_ij_shared;
        end
    end
end
