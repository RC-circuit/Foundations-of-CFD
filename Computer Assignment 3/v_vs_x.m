u_ghia = [0, 0.09233, 0.10091, 0.10890, 0.12317, 0.16077, 0.17507, 0.17527, 0.05454, -0.24533, -0.22445, -0.16914, -0.10313, -0.08864, -0.07391, -0.05906, 0];
x = [0, 0.0625, 0.0703, 0.0781, 0.0938, 0.1563, 0.2266, 0.2344, 0.50, 0.8047, 0.8594, 0.9063, 0.9453, 0.9531, 0.9609, 0.9688, 1];


% Plot the first data
plot(x, u_ghia, 'r--', 'LineWidth', 2);  % Plot with red color and solid line

hold on;  % Hold the current plot

% Plot the second data
plot(0:0.02:1,v(26,:), 'cyan', 'LineWidth', 1); % Plot with blue color and dashed line



% Add legend
legend('Ghia plot', 'my plot');

% Add labels and title
xlabel('x');
ylabel('v');
title('v v/s x at y = 0.5 ; Re = 100');

hold off; % Release the hold on the current plot
