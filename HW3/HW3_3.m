%question 1
A =  round(100 * rand(128));
B =  round(100 * rand(128));

%question 2 & 3
[C_naive, global_mem_read_count_naive] = HW3_1(A, B);
[C_tiled, global_mem_read_count_tiled] = HW3_2(A, B, 4);

disp(C_naive)
disp(global_mem_read_count_naive)

disp(C_tiled)
disp(global_mem_read_count_tiled)

%question 4
Ans_C = A * B;
rms_error_naive = sqrt(mean((C_naive - Ans_C).^2, 'all'));
rms_error_tiled = sqrt(mean((C_tiled - Ans_C).^2, 'all'));

disp(rms_error_naive)
disp(rms_error_tiled)

%question 5
tile_sizes = [1, 2, 4, 8, 16, 32, 64];
global_memory_read_count = zeros(size(tile_sizes));

for i = 1:length(tile_sizes)
    [~, global_memory_read_count(i)] = HW3_2(A, B, tile_sizes(i));
end

%plot
figure;
plot(tile_sizes, global_memory_read_count, '-o');
xlabel('Tile Size m');
ylabel('Global Memory Read Count');
title('Global Memory Read Count vs Tile Size');
grid on;

