clc
clear

tstart = cputime;

T_k = zeros(41,21);
T_k(41,:) = 100;

T_k_1 = zeros(41,21);
T_k_1(41,:) = 100;

beta = 1;
w = 1.28;

A = zeros(21,21);
for k = 1:21
    if k == 1 || k == 21
        A(k,k) = 1;
    else
        A(k,k-1) = -w;
        A(k,k) = 2*(1+(beta^2));
        A(k,k+1) = -w;
    end
end

b = zeros(1,21);
condition = true;
iterations = 0;

compute_tstart = cputime;

while condition
    for i = 2:40
        for j = 1:21
            if j == 1 || j == 21
                b(j) = T_k(i,j);
            else
                b(j) = (beta^2)*w*(T_k(i+1,j) + T_k_1(i-1,j)) + 2*(1-w)*(1+(beta^2))*T_k(i,j);
            end
        end
        T_k_1(i,:) = TDMA(A,b);
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