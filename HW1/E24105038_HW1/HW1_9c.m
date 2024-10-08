%when m1 is not equal to m2
%value assumption
m1 = 4;
m2 = 5;
b1 = randi([-5, 5]); %Randomly choose b1, b2 within the range [-5, 5]
b2 = randi([-5, 5]);

x = linspace(-12, 12);

figure('Name','[1.1] ex. 9(c)', 'Position', [200, 200, 1000, 600]);

%question a
subplot(1, 2, 1);
y1 = m1 * x + b1;
y2 = m2 * x + b2;
plot(x, y1, 'r', 'LineWidth', 1.5);
hold on;
plot(x, y2, 'b', 'LineWidth', 1.5); 
xlabel('x');
ylabel('y');
title('Question (a): Unique Solution if m1 != m2');
legend('m1(x) + b1', 'm2(x) + b2');
grid on;

%when b1 = b2
b1 = 7;
b2 = 7;

%question b %when m1 = m2
subplot(1, 2, 2);
y1 = m1 * x + b1;
y2 = m1 * x + b2;
plot(x, y1, 'r', 'LineWidth', 1.5);
hold on;
plot(x, y2, 'b--', 'LineWidth', 1.5); %Using dashed line style to let the two overlap lines can be both visible
xlabel('x');
ylabel('y');
title('Question(b): If m1 = m2, the system will be consistent only b1 = b2');
legend('m1(x) + b1', 'm1(x) + b2');
grid on;

 

