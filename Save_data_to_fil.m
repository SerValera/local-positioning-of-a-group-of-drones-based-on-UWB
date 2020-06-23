

file = fopen('MyFile.txt','w');
for i = 1:100
    task1();
    T = [N, noise_coordinates, x_grid(2), x_rover, y_rover, x_pred_mean, y_pred_mean, er_x, er_y, dtime];
    fprintf(file, '%f\t', [T]');
    fprintf(file, '\n');
end 
fclose(file);