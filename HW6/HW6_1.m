%
% Homework 6 Matlab assignment
%
% Example code
% Image registration
% by linear transformations
%
% Linear Algebra
% NCKU CSIE 
%
% Ming-Long Wu, Ph.D.
% 2024/6
%

clear all;
close all;
clc;


%%%%%%%
%
% 1.1 Loading images, key points, and preprocessing
%
%%%%%%%

% read images
IMA_1 = imread('./Data/A01_1.jpg');
IMA_2 = imread('./Data/A01_2.jpg');

% resize to 0.25x
IMA_1 = imresize(IMA_1, 0.25);
IMA_2 = imresize(IMA_2, 0.25);

% read labeled points
fid1 = fopen('./Data/control_points_A01_1_2.txt');
pts = fscanf(fid1,'%f');
fclose(fid1);

% shrink coordinates also by 0.25
pts = round(pts/4);

% sort X, Y coordinates of key points
X1 = pts(1:4:end);
Y1 = pts(2:4:end);
X2 = pts(3:4:end);
Y2 = pts(4:4:end);

% make a copy of images to add green key points
IMA_1m = IMA_1;
IMA_2m = IMA_2;

for i = 1 : length(X1)

    % each key point point is marked as a 11x11 green region for visualization
    % mark points for IMA_1m
    IMA_1m(Y1(i)-5:Y1(i)+5,X1(i)-5:X1(i)+5,:) = repmat(reshape([0, 255, 0], [1, 1, 3]),[11 11 1]);
    % mark points for IMA_2m
    IMA_2m(Y2(i)-5:Y2(i)+5,X2(i)-5:X2(i)+5,:) = repmat(reshape([0, 255, 0], [1, 1, 3]),[11 11 1]);
    
end

% display images to check if label points are correctly marked
figure(100);
% diplay A01-1.jpg
subplot(1,2,1);
imagesc(IMA_1m);
title('A01-1.jpg');
grid on;
xticks([0:120:728]);
yticks([0:120:728]);
set(gca,'dataaspectratio', [1 1 1],'linewidth', 2, 'GridColor', [1 1 1], 'GridAlpha', 0.7, 'FontSize', 18);
% display A01-2.jpg
subplot(1,2,2);imagesc(IMA_2m);
title('A01-2.jpg');
grid on;
xticks([0:120:728]);
yticks([0:120:728]);
set(gca,'dataaspectratio', [1 1 1],'linewidth', 2, 'GridColor', [1 1 1], 'GridAlpha', 0.7, 'FontSize', 18);


%%%%%%%
%
% 1.2 Finding affine transformation coefficients
%
%%%%%%%

%prepare the matrices for affine transformation
A1 = [X2 Y2 ones(size(X2)) zeros(size(X2)) zeros(size(X2)) zeros(size(X2))];
A2 = [zeros(size(X2)) zeros(size(X2)) zeros(size(X2)) X2 Y2 ones(size(X2))];

A = [A1; A2];
b = [X1; Y1];

x = lsqr(A, b);

%extract the coefficients
a11 = x(1);
a12 = x(2);
a13 = x(3);
a21 = x(4);
a22 = x(5);
a23 = x(6);

%affine transformation matrix
T = [a11 a12 a13; a21 a22 a23; 0 0 1];

%1.2.2
fprintf('Affine Transformation Coefficients:\n');
fprintf('a11 = %.4f, a12 = %.4f, a13 = %.4f\n', a11, a12, a13);
fprintf('a21 = %.4f, a22 = %.4f, a23 = %.4f\n', a21, a22, a23);

%apply transformation to the points 
X2_transformed = a11 * X2 + a12 * Y2 + a13;
Y2_transformed = a21 * X2 + a22 * Y2 + a23;

%1.2.3
rmse = sqrt(mean((X2_transformed - X1).^2 + (Y2_transformed - Y1).^2));
fprintf('Root Mean Square Error: %.2f pixels\n', rmse);

%%%%%%%
%
% 1.3 Applying affine transformation to A01-2.jpg
%
%%%%%%%

% Apply affine transformation.

%generate grid coordinates
[X_grid, Y_grid] = meshgrid(1:size(IMA_2,2), 1:size(IMA_2,1));

%apply affine transformation to grid coordinates
X_trans = a11 * X_grid + a12 * Y_grid + a13;
Y_trans = a21 * X_grid + a22 * Y_grid + a23;

%transformed image
IMA_2_transformed = uint8(zeros(size(IMA_2)));
for i = 1:size(IMA_2, 3)  % For each color channel
    IMA_2_transformed(:,:,i) = uint8(griddata(X_trans, Y_trans, double(IMA_2(:,:,i)), X_grid, Y_grid, 'linear'));
end

%add green points to the transformed image
IMA_2m_transformed = IMA_2_transformed;
for i = 1 : length(X2_transformed)
    IMA_2m_transformed(round(Y2_transformed(i))-5:round(Y2_transformed(i))+5, round(X2_transformed(i))-5:round(X2_transformed(i))+5,:) = repmat(reshape([0, 255, 0], [1, 1, 3]),[11 11 1]);
end

%%%%%%%
%
% 1.4 Check image registration
%
%%%%%%%

% Display whole images and cropped images to check image registration.

%%%%%%%
% 1.4 Check image registration
%%%%%%%

%1.4.1 
figure('Position', [100, 100, 1500, 600]); %adjust figure size for better visibility
%display A01-1.jpg
subplot(1, 3, 1);
imagesc(IMA_1m);
title('A01-1.jpg');
grid on;
xticks([0:120:728]);
yticks([0:120:728]);
set(gca,'dataaspectratio', [1 1 1],'linewidth', 2, 'GridColor', [1 1 1], 'GridAlpha', 0.7, 'FontSize', 18);

%display A01-2.jpg before registration 
subplot(1, 3, 2);
imagesc(IMA_2m);
title('A01-2.jpg (Before)');
grid on;
xticks([0:120:728]);
yticks([0:120:728]);
set(gca,'dataaspectratio', [1 1 1],'linewidth', 2, 'GridColor', [1 1 1], 'GridAlpha', 0.7, 'FontSize', 18);

%display A01-2.jpg after registration 
subplot(1, 3, 3);
imagesc(IMA_2m_transformed);
title('A01-2.jpg (After)');
grid on;
xticks([0:120:728]);
yticks([0:120:728]);
set(gca,'dataaspectratio', [1 1 1],'linewidth', 2, 'GridColor', [1 1 1], 'GridAlpha', 0.7, 'FontSize', 18);

%1.4.2 
roi_x = 300:300+363;
roi_y = 200:200+363;

%crop the images
IMA_1m_cropped = IMA_1m(roi_y, roi_x, :);
IMA_2m_cropped = IMA_2m(roi_y, roi_x, :);
IMA_2m_transformed_cropped = IMA_2m_transformed(roi_y, roi_x, :);

%display cropped A01-1.jpg
figure('Position', [100, 100, 1500, 600]); % Adjust figure size for better visibility
% Display cropped A01-1.jpg with green points
subplot(1, 3, 1);
imagesc(IMA_1m_cropped);
title('Cropped A01-1.jpg');
grid on;
xticks([0:120:728]);
yticks([0:120:728]);
set(gca,'dataaspectratio', [1 1 1],'linewidth', 2, 'GridColor', [1 1 1], 'GridAlpha', 0.7, 'FontSize', 18);

%display cropped A01-2.jpg before registration 
subplot(1, 3, 2);
imagesc(IMA_2m_cropped);
title('Cropped A01-2.jpg (Before)');
grid on;
xticks([0:120:728]);
yticks([0:120:728]);
set(gca,'dataaspectratio', [1 1 1],'linewidth', 2, 'GridColor', [1 1 1], 'GridAlpha', 0.7, 'FontSize', 18);

%display cropped A01-2.jpg after registration 
subplot(1, 3, 3);
imagesc(IMA_2m_transformed_cropped);
title('Cropped A01-2.jpg (After)');
grid on;
xticks([0:120:728]);
yticks([0:120:728]);
set(gca,'dataaspectratio', [1 1 1],'linewidth', 2, 'GridColor', [1 1 1], 'GridAlpha', 0.7, 'FontSize', 18);