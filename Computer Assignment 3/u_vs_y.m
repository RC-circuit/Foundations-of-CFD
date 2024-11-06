u_ghia = [0, -0.03717, -0.04192, -0.04775, -0.06434, -0.10150, -0.15662, -0.21090, -0.20581, -0.13641, 0.00332, 0.23151, 0.68717, 0.73722, 0.78871, 0.84123, 1];
y = [0, 0.0547, 0.0625, 0.0703, 0.1016, 0.1719, 0.2813, 0.4531, 0.50, 0.6172, 0.7344, 0.8516, 0.9531, 0.9609, 0.9688, 0.9766, 1];


% Plot the first data
plot(u_ghia, y, 'r--', 'LineWidth', 2);  % Plot with red color and solid line

hold on;  % Hold the current plot

% Plot the second data
plot(u(:,26),0:0.02:1, 'cyan', 'LineWidth', 1); % Plot with blue color and dashed line



% Add legend
legend('Ghia plot', 'my plot');

% Add labels and title
xlabel('u');
ylabel('y');
title('u v/s y at x = 0.5 ; Re = 100');

hold off; % Release the hold on the current plot
