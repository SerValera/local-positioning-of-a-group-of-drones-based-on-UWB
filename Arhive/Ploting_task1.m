close all; clc; 
%----Ploting initial coordinates----
line = sprintf('Initial coordinates');
figure('Name', line,'NumberTitle','off');
plot(x_rover, y_rover, 'or'); hold on;
plot(x, y, 'ob', 'MarkerSize',3); hold on;
for i = 1:N
    plot(x_c(i, :), y_c(i, :), 'g'); hold on;
end 
axis([x_grid(1) x_grid(2) y_grid(1) y_grid(2)]);
xlabel('x'), ylabel('y');
legend('Rover','Points', 'Radius');
hold off


%----Ploting coordinates + noise----
line = sprintf('Initial coordinates with NOISE');
figure('Name', line,'NumberTitle','off');
plot(x_rover, y_rover, 'or'); hold on;
plot(x_n, y_n, 'ok', 'MarkerSize',3); hold on;

for i = 1:N
    plot(x_nc(i, :), y_nc(i, :), 'k'); hold on;
end 
axis([x_grid(1)-50 x_grid(2)+50 y_grid(1)-50 y_grid(2)+50]);
xlabel('x'), ylabel('y');
legend('Rover','Points with noise','Radius with noise');
hold off


%----Ploting both (initial and noise)----
line = sprintf('Initial coordinates and coordinates with noise');
figure('Name', line,'NumberTitle','off');
plot(x_rover, y_rover, 'or'); hold on;
plot(x, y, 'ob', 'MarkerSize',3); hold on;
plot(x_n, y_n, 'ok', 'MarkerSize',3); hold on;
for i = 1:N
    plot(x_c(i, :), y_c(i, :), 'og', 'MarkerSize',1); hold on;
    plot(x_nc(i, :), y_nc(i, :), 'ok', 'MarkerSize',1); hold on;
end 
axis([x_grid(1)-50 x_grid(2)+50 y_grid(1)-50 y_grid(2)+50]);
xlabel('x'), ylabel('y');
legend('Rover','Points', 'Points with noise', 'Radius with noise');
hold off

image(mask_radius,'CDataMapping','scaled')
colorbar