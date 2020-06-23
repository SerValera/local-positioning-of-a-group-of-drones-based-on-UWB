%task1 from Tsuru
close all; clc; clear all;

%size of field
x_grid = [0 1000];
y_grid = [0 1000];

%---Rover coordinates---
x_rover = 500;
y_rover = 500;

%beacons coordinates
N = 4;
x = [100 900 900 100];
y = [100 100 900 900];
noise_coordinates = 50;
noise_distance = 0;

delta_pix = 25;

%---generate distance to the Rover---
for i = 1:N 
    l(i)=sqrt(((x(i)-x_rover))^2+(y(i)-y_rover)^2);
end

%---adding noise to the coordinates and distance----
for i = 1:N
    x_n(i) = x(i) + randn*noise_coordinates;
    y_n(i) = y(i) + randn*noise_coordinates;
    l_n(i)=sqrt(((x_n(i)-x_rover))^2+(y_n(i)-y_rover)^2);
end

%---making mask---
mask_radius = make_mask(N, y_grid, x_grid, x, y, l, delta_pix);

%---making mask NOISE---
mask_radius_n = make_mask(N, y_grid, x_grid, x_n, y_n, l_n, delta_pix);

%---searching the max value---
[x_pred, y_pred, max_valeu_px] = find_max(y_grid, x_grid, mask_radius);
[x_pred_n, y_pred_n, max_valeu_px_n] = find_max(y_grid, x_grid, mask_radius_n);


%---taking max coordinates---
x_max = [];
y_max = [];
x_max_n = [];
y_max_n = [];
for i = 1:y_grid(2)
    for j = 1:x_grid(2)
        if mask_radius_n(i, j) == max_valeu_px_n
            x_max_n = [x_max_n j];
            y_max_n = [y_max_n i];
        end
        if mask_radius(i, j) == max_valeu_px
            x_max = [x_max j];
            y_max = [y_max i];
        end
    end
end

Average_calculation();
dtime = toc;
toc

%---making circle raduous l, center points x, y---
th = 0:pi/100:2*pi;
[uuu,c_p] = size(th);
x_c = zeros(N, c_p);
y_c = zeros(N, c_p);
x_nc = zeros(N, c_p);
y_nc = zeros(N, c_p);
for i = 1:N
    x_c(i,:) = l(i) * cos(th) + x(i);
    y_c(i,:) = l(i) * sin(th) + y(i);
    x_nc(i,:) = l_n(i) * cos(th) + x_n(i);
    y_nc(i,:) = l_n(i) * sin(th) + y_n(i);
end




%--------------------FINCTIONS---------------------
function mask = make_mask(N, y_grid, x_grid, x, y, l, delta_pix)
    mask = zeros(x_grid(2), y_grid(2));
    for k = 1:N
        for i = 1:y_grid(2)
            for j = 1:x_grid(2)
                r = sqrt(((x(k) - j))^2 + (y(k)-(y_grid(2) - i))^2);
                if (r >= l(k)-delta_pix) && (r <= l(k)+delta_pix)
                    mask(i, j) =  mask(i, j) + 1;
                end
            end
        end
    end
end

function [x_pred, y_pred, max_valeu_px] = find_max(y_grid, x_grid, mask_radius)
    x_pred = -1;
    y_pred = -1;
    max_valeu_px = -1;
    for i = 1:y_grid(2)
        for j = 1:x_grid(2)
            if mask_radius(i, j) > max_valeu_px
                x_pred = j;
                y_pred = i;
                max_valeu_px = mask_radius(i, j);
            end
        end
    end
end




