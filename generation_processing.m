close all; clc; 

alpha = 0.01;
x_exp = Func_filtres.Exponential_Mean(x_pred_gen, alpha, size(x_pred_gen));
y_exp = Func_filtres.Exponential_Mean(y_pred_gen, alpha, size(y_pred_gen));

x_exp_mean = mean(x_exp)
y_exp_mean = mean(y_exp)

%----Ploting initial coordinates----
set(0,'DefaultFigureWindowStyle','docked')
line = sprintf('X coordinate');
figure('Name', line,'NumberTitle','off');
plot(time_mes, x_pred_gen, 'b'); hold on;
plot(time_mes, x_exp, 'm'); hold on;
xlabel('time, sec'), ylabel('Coordinate X');
legend('X','X exp smooth');
hold off

line = sprintf('Y coordinate');
figure('Name', line,'NumberTitle','off');
plot(time_mes, y_pred_gen, 'b'); hold on;
plot(time_mes, y_exp, 'm'); hold on;
xlabel('time, sec'), ylabel('Coordinate Y');
legend('Y','Y exp smooth');
hold off