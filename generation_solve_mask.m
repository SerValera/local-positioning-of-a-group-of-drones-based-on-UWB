close all; clc; clear all;

file = fopen('MyFile.txt', 'w');
T = ['N', '\t', 'noise_distance_percent','\t', 'x_rover', '\t', 'y_rover', '\t', 'x_pred_mean_n', '\t', 'y_pred_mean_n', '\t', 'er_x', '\t', 'er_y', '\t', 'dtime', '\n'];
fprintf(file, T); 

%size of field
x_grid = [0 1000];
y_grid = [0 1000];
%number of beacons
max_N = 5; %min 3
%noise for distance from Rover to Beacnos
noise_distance = 5; %Percent

%---generate Rover coordinates, number of beacons, coordinates and calculate distance---
[x_rover, y_rover, N, x, y, l, l_n] = func.gen_cord(x_grid, y_grid, max_N, noise_distance);

%number_of_generation
generation = 100;

x_pred_gen = zeros(generation, 1);
y_pred_gen = zeros(generation, 1);
time_mes = zeros(generation, 1);

total_time = 0;
for k = 1:generation  
    tic
    %---noise generation to the coordinates and distance----
    for i = 1:N
        l_n(i) = l(i) + (rand(1)*2 - 1) * l(i)*noise_distance/100;
    end

    [x_pred_mean, y_pred_mean, mask_radius] = func.find_cord_by_mask(N, x, y, l_n, y_grid, x_grid, noise_distance);
 
    x_pred_gen(k) = x_pred_mean;
    y_pred_gen(k) = y_pred_mean;
    
    toc
    dtime = toc;
    total_time = total_time + dtime;
    time_mes(k) = total_time;
    
    T = [N, noise_distance, x_rover, y_rover, x_pred_mean, y_pred_mean, dtime];
    fprintf(file, '%i\t%f\t%f\t%f\t%f\t%f\t%f\n', T);   % запись матрицы в файл (40 байт)
end
total_time

fclose(file);

x_pred_gen_mean = mean(x_pred_gen)
y_pred_gen_mean = mean(y_pred_gen)


%----Ploting coordinates + noise----
%---making circle for plot raduous l, center points x, y---
th = 0:pi/100:2*pi;
[~,c_p] = size(th);
x_c = zeros(N, c_p);
y_c = zeros(N, c_p);
for i = 1:N
    x_c(i,:) = l(i) * cos(th) + x(i);
    y_c(i,:) = l(i) * sin(th) + y(i);
end


line = sprintf('Initial coordinates with NOISE');
figure('Name', line,'NumberTitle','off'); 

plot(x_c(1, :), y_c(1, :), 'g','DisplayName','Radius'); hold on;
for i = 2:N
    plot(x_c(i, :), y_c(i, :), 'g', 'HandleVisibility', 'off'); hold on;
end

plot(x, y, 'ob', 'MarkerSize',10, 'DisplayName','Beacons position'); hold on;
plot(x_pred_gen, y_pred_gen, '.b', 'MarkerSize',15, 'DisplayName','Prediction position'); hold on;
plot(x_rover, y_rover, '.r', 'MarkerSize',15, 'DisplayName','Rover position'); hold on;
plot(x_pred_gen_mean, y_pred_gen_mean, '.m',  'MarkerSize',15, 'DisplayName','Prediction position mean'); hold on;
axis([x_grid(1) x_grid(2) y_grid(1) y_grid(2)]);
xlabel('x'), ylabel('y');
lgd = legend;
hold off

