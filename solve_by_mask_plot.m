close all; 

%---making circle for plot raduous l, center points x, y---
th = 0:pi/100:2*pi;
[uuu,c_p] = size(th);
x_c = zeros(N, c_p);
y_c = zeros(N, c_p);
x_nc = zeros(N, c_p);
y_nc = zeros(N, c_p);
for i = 1:N
    x_c(i,:) = l_n(i) * cos(th) + x(i);
    y_c(i,:) = l_n(i) * sin(th) + y(i);
    x_nc(i,:) = l_n(i) * cos(th) + x(i);
    y_nc(i,:) = l_n(i) * sin(th) + y(i);
end

set(0,'DefaultFigureWindowStyle','docked')
%----Ploting initial coordinates----
line = sprintf('Initial coordinates');
figure('Name', line,'NumberTitle','off');
plot(x_rover, y_rover, '*r', 'MarkerSize',10); hold on;
plot(x, y, 'ob', 'MarkerSize',10); hold on;
plot(x_pred_mean, y_pred_mean, 'og', 'MarkerSize',10); hold on;
%plot(x_pred, y_grid(2) - y_pred, '*b', 'MarkerSize',10); hold on;
for i = 1:N
    plot(x_c(i, :), y_c(i, :), '-k'); hold on;
end 
axis([x_grid(1) x_grid(2) y_grid(1) y_grid(2)]);
xlabel('x'), ylabel('y');
legend('Rover position','Beacons position', 'Prediction position', 'Radius with noise');
hold off

line = sprintf('Mask_radius');
figure('Name', line,'NumberTitle','off');
image(mask_radius,'CDataMapping','scaled'); hold on;
plot(x_rover, y_grid(2) -  y_rover, '*r', 'MarkerSize',10); hold on;
plot(x_pred_mean, y_grid(2) - y_pred_mean, 'og', 'MarkerSize',10); hold on;
legend('Rover position','Prediction position');
%colorbar
hold off