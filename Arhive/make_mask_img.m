%task1 from Tsuru
%close all; clc; clear all;

%---making mask---
mask_radius = make_mask(N, y_grid, x_grid, x, y, l, noise_distance);

%---making mask NOISE---
mask_radius_n = make_mask(N, y_grid, x_grid, x, y, l_n, noise_distance);

%---searching the max value---
[x_pred, y_pred, max_valeu_px] = find_max(y_grid, x_grid, mask_radius);
[x_pred_n, y_pred_n, max_valeu_px_n] = find_max(y_grid, x_grid, mask_radius_n);

[x_max, y_max] = take_array_of_max (y_grid, x_grid, max_valeu_px, mask_radius);
[x_max_n, y_max_n] = take_array_of_max (y_grid, x_grid, max_valeu_px_n, mask_radius_n);

%---Average calculation---
x_pred_mean = mean(x_max);
y_pred_mean = y_grid(2) - mean(y_max);

x_pred_mean_n = mean(x_max_n);
y_pred_mean_n = y_grid(2) - mean(y_max_n);

%---Error calculation---
er_x = abs(x_pred_mean_n - x_rover);
er_y = abs(y_pred_mean_n - y_rover);

%--------------------FINCTIONS---------------------
function [x_max, y_max] = take_array_of_max (y_grid, x_grid, max_valeu_px, mask_radius)
    %---taking array of max coordinates---
    x_max = [];
    y_max = [];
    for i = 1:y_grid(2)
        for j = 1:x_grid(2)
            if mask_radius(i, j) == max_valeu_px
                x_max = [x_max j];
                y_max = [y_max i];
            end
        end
    end
end

function mask = make_mask(N, y_grid, x_grid, x, y, l, noise_distance)
    mask = zeros(x_grid(2), y_grid(2));
    for k = 1:N
        for i = 1:y_grid(2)
            for j = 1:x_grid(2)
                r = sqrt(((x(k) - j))^2 + (y(k)-(y_grid(2) - i))^2);
                if l(k)*noise_distance/200 > 1
                    if (r >= l(k)-l(k)*noise_distance/200) && (r <= l(k)+l(k)*noise_distance/200)
                        mask(i, j) =  mask(i, j) + 1;
                    end
                end
                if l(k)*noise_distance/200 <= 1
                    if (r >= l(k)-1) && (r <= l(k)+1)
                        mask(i, j) =  mask(i, j) + 1;
                    end
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



