function [x] = TDMA(A,b)

N = length(b);
if length(b) ~= size(A,1)
    error('dimension mismatch')
end
% converting into an upper triangular matrix
for i = 1:N-1
    for k = i+1:N
        m = A(k,i)/A(i,i);
        b(k) = b(k) - m*b(i);
        A(k,:) = A(k,:) - m*A(i,:);
    end
end
x = zeros(1,N);

%solution phase  
for i = N:-1:1
    if i == N
        x(1,i) = b(i)/A(i,i);
    else
        x(i) = (b(i) - sum(A(i,i+1:end).*x(i+1:N)))/A(i,i);
    end

end