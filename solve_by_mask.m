close all; clc; clear all;

%size of field
x_grid = [0 100];
y_grid = [0 100];
%number of beacons
max_N = 5; %min 3
%noise for distance from Rover to Beacnos
noise_distance = 5; %Percent

%---generate Rover coordinates, number of beacons, coordinates and calculate distance---
[x_rover, y_rover, N, x, y, l, l_n] = func.gen_cord(x_grid, y_grid, max_N, noise_distance);

tic
%---find prediction position of the Rover by mask method---
[x_pred_mean, y_pred_mean, mask_radius] = func.find_cord_by_mask(N, x, y, l_n, y_grid, x_grid, noise_distance);
toc

%---Error calculation---
er_x = abs(x_pred_mean - x_rover);
er_y = abs(y_pred_mean - y_rover);

disp('Number of beacons:')
disp(N)

disp('True rover position:')
disp(x_rover)
disp(y_rover)

disp('Prediction position:')
disp(x_pred_mean)
disp(y_pred_mean)

disp('Error:')
disp(er_x)
disp(er_y)
