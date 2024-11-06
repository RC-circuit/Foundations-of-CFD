clc
clear

tstart = cputime;

T_k = zeros(41,21);
T_k(41,:) = 100;

T_k_half = zeros(41,21);
T_k_half(41,:) = 100;

T_k_1 = zeros(41,21);
T_k_1(41,:) = 100;
beta = 1;

A = zeros(21,21);
for k = 1:21
    if k == 1 || k == 21
        A(k,k) = 1;
    else
        A(k,k-1) = -1;
        A(k,k) = 2*(1+(beta^2));
        A(k,k+1) = -1;
    end
end

A_1 = zeros(41,41);
for k = 1:41
    if k == 1 || k == 41
        A_1(k,k) = 1;
    else
        A_1(k,k-1) = -1*(beta^2);
        A_1(k,k) = 2*(1+(beta^2));
        A_1(k,k+1) = -1*(beta^2);
    end
end

b = zeros(1,21);
b_1 = zeros(1,41);
condition = true;
iterations = 0;

compute_tstart = cputime;

while condition
    % X sweep
    for i = 2:40
        for j = 1:21
            if j == 1 || j == 21
                b(j) = T_k(i,j);
            else
                b(j) = (beta^2)*(T_k(i+1,j) + T_k_half(i-1,j));
            end
        end
        T_k_half(i,:) = TDMA(A,b);
    end
    % Y sweep
    for j = 2:20
        for i = 1:41
            if i == 1 || i == 41
                b_1(i) = T_k_half(i,j);
            else
                b_1(i) = T_k_half(i,j+1) + T_k_1(i,j-1);
            end
        end
        T_k_1(:,j) = TDMA(A_1,b_1);
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