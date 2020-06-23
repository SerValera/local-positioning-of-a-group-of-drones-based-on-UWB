%task1 from Tsuru
%close all; clc; clear all;

if manual_coordinate == 1    
    %size of field
    x_grid = [0 100];
    y_grid = [0 100];
    
    %Rover coordinates
    x_rover = 500;
    y_rover = 500;
    
    %noise for coordinates
    noise_coordinates = 0; %pix
    noise_distance = 5; %Percent
    
    %Beacons coordinates and distance to the Rover
    N = 4;
    x = [100 100 900 900];
    y = [100 900 900 100];
    for i = 1:N 
        l(i)=sqrt(((x(i)-x_rover))^2+(y(i)-y_rover)^2);
    end
end

if manual_coordinate == 0
    %size of field
    x_grid = [0 100];
    y_grid = [0 100];
    
    %noise for coordinates
    noise_coordinates = 0; %pix
    noise_distance = 5; %Percent
    
    %---variables---
    max_number_beacons = 10;
    min_number_beacons = 3;

    %generate Rover coordinates
    x_rover = rand(1)*x_grid(2);
    y_rover = rand(1)*y_grid(2);

    %generate number of geacons
    N = floor(min_number_beacons + rand(1)*(max_number_beacons-min_number_beacons));

    %generate beacons coordinates and distance to the Rover
    for i = 1:N
        x(i) = rand(1)*x_grid(2);
        y(i) = rand(1)*y_grid(2); 
        l(i)=sqrt(((x(i)-x_rover))^2+(y(i)-y_rover)^2);
    end
end 

%---adding noise to the coordinates and distance----
for i = 1:N
    x_n(i) = x(i) + (rand(1)*2 - 1)*noise_coordinates;
    y_n(i) = y(i) + (rand(1)*2 - 1)*noise_coordinates; 
    l_n(i) = l(i) + (rand(1)*2 - 1) * l(i)*noise_distance/100;
end
