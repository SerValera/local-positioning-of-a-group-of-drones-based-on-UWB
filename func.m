classdef func
    methods(Static)
        
        function [x_pred_mean, y_pred_mean, mask_radius] = find_cord_by_mask(N, x, y, l_n, y_grid, x_grid, noise_distance)
            %---making mask NOISE---
            mask_radius = func.make_mask(N, y_grid, x_grid, x, y, l_n, noise_distance);
            max_valeu_px = max(max(mask_radius));
            [x_max, y_max] = func.take_array_of_max (y_grid, x_grid, max_valeu_px, mask_radius);

            %---Average calculation---
            x_pred_mean = mean(x_max);
            y_pred_mean = y_grid(2) - mean(y_max);
        end

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
                            if (r >= l(k)-l(k)*noise_distance/100) && (r <= l(k)+l(k)*noise_distance/100)
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

        function [x_rover, y_rover, N, x, y, l, l_n] = gen_cord(x_grid, y_grid, max_N, noise_distance)
            %generate Rover coordinates
            x_rover = rand(1)*x_grid(2);
            y_rover = rand(1)*y_grid(2);

            %generate number of Beacons (from 3 to max_N)
            N = floor(3 + rand(1)*(max_N-3));

            %generate beacons coordinates and distance to the Rover
            for i = 1:N
                x(i) = rand(1)*x_grid(2);
                y(i) = rand(1)*y_grid(2); 
                l(i) = sqrt(((x(i)-x_rover))^2+(y(i)-y_rover)^2);
                l_n(i) = l(i) + (rand(1)*2 - 1) * l(i)*noise_distance/100;
            end
        end
    end
end

