clc
clear

tstart = cputime;

T_k = zeros(41,21);
T_k(41,:) = 100;

T_k_1 = zeros(41,21);
T_k_1(41,:) = 100;

condition = true;
iterations = 0;
beta = 1;
w = 1.80;

compute_tstart = cputime;

while condition
         for i = 2:40
             for j = 2:20
                 T_k_1(i,j) = (1-w)*T_k(i,j) + ((T_k(i,j+1) + T_k_1(i,j-1) + (beta^2)*T_k(i+1,j) + (beta^2)*T_k_1(i-1,j))*w)/(2*(1+beta^2));
             end
         end
         error = 0;
         for i = 2:40
             for j = 2:20
                 error = error + abs(T_k_1(i,j) - T_k(i,j));
             end
         end
         iterations = iterations + 1;
         T_k = T_k_1;
         condition = (error > 0.01);
end
compute_time = cputime - compute_tstart;

total_time = cputime - tstart;