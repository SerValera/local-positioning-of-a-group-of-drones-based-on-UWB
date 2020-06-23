close all; clc; clear all;

%size of field
x_grid = [0 1000];
y_grid = [0 1000];
  
%Rover coordinates
x_rover = 500;
y_rover = 500;
    
%noise for coordinates
noise_coordinates = 0; %pix
noise_distance = 10; %Percent
    
%Beacons coordinates and distance to the Rover
N = 4;
x = [100 100 900 900];
y = [100 900 900 100];
for i = 1:N 
    l_n(i)=sqrt(((x(i)-x_rover))^2+(y(i)-y_rover)^2);
    %l_n(i) = l(i) + (rand(1)*2 - 1) * l(i)*noise_distance/100;
end

%size of field
x_grid = [0 1000];
y_grid = [0 1000];
%number of beacons
max_N = 10 ; %min 3
%noise for distance from Rover to Beacnos
noise_distance = 0; %Percent
%---generate Rover coordinates, number of beacons, coordinates and calculate distance---
[x_rover, y_rover, N, x, y, l, l_n] = func.gen_cord(x_grid, y_grid, max_N, noise_distance);

tic
for i = 1:(N-2)
    [x_pred(i), y_pred(i)] = find_coordinates(x(i:i+2), y(i:i+2), l_n(i:i+2));
end

x_pred_mean = mean(x_pred);
y_pred_mean = mean(y_pred);

toc

x_rover
y_rover

x_pred_mean
y_pred_mean

%---making circle for plot raduous l, center points x, y---
th = 0:pi/100:2*pi;
[~,c_p] = size(th);
x_c = zeros(N, c_p);
y_c = zeros(N, c_p);

x_ci = zeros(N, c_p);
y_ci = zeros(N, c_p);
x_co = zeros(N, c_p);
y_co = zeros(N, c_p);


for i = 1:N
    x_c(i,:) = l_n(i) * cos(th) + x(i);
    y_c(i,:) = l_n(i) * sin(th) + y(i);
    
    x_ci(i,:) = (l_n(i) - l_n(i) * noise_distance/100) * cos(th) + x(i);
    y_ci(i,:) = (l_n(i) - l_n(i) * noise_distance/100) * sin(th) + y(i);
    
    x_co(i,:) = (l_n(i) + l_n(i) * noise_distance/100) * cos(th) + x(i);
    y_co(i,:) = (l_n(i) + l_n(i) * noise_distance/100) * sin(th) + y(i);
end

%----Ploting initial coordinates----
set(0,'DefaultFigureWindowStyle','docked')
line = sprintf('Initial coordinates');
figure('Name', line, 'NumberTitle','off'); hold on;
plot(x_rover, y_rover, '*r', 'MarkerSize',9); hold on;  
plot(x, y, 'ob', 'MarkerSize', 12); hold on;
plot(x_pred_mean, y_pred_mean, 'om', 'MarkerSize',12); hold on;
for i = 1:N
    plot(x_c(i, :), y_c(i, :), 'g'); hold on;
    %plot(x_ci(i, :), y_ci(i, :), 'b'); hold on;
    %plot(x_co(i, :), y_co(i, :), 'b'); hold on;
end 
axis([x_grid(1) x_grid(2) y_grid(1) y_grid(2)]);
xlabel('x'), ylabel('y');
legend('Rover position','Beacons position', 'pred', 'Radius');
hold off

function [x, y] = find_coordinates(X, Y, R)
    x1 = X(1); x2 = X(2); x3 = X(3);
    y1 = Y(1); y2 = Y(2); y3 = Y(3);
    r1 = R(1); r2 = R(2); r3 = R(3);
    x = ((y2 - y1) * (r2 * r2 - r3 * r3 - y2 * y2 + y3 * y3 - x2 * x2 + x3 * x3) - (y3 - y2) * (r1 * r1 - r2 * r2 - y1 * y1 + y2 * y2 - x1 * x1 + x2 * x2)) / (2 * ((y3 - y2) * (x1 - x2)  - (y2 - y1) * (x2 - x3)));
    y = ((x2 - x1) * (r2 * r2 - r3 * r3 - x2 * x2 + x3 * x3 - y2 * y2 + y3 * y3) - (x3 - x2) * (r1 * r1 - r2 * r2 - x1 * x1 + x2 * x2 - y1 * y1 + y2 * y2)) / (2 * ((x3 - x2) * (y1 - y2)  - (x2 - x1) * (y2 - y3)));
end

