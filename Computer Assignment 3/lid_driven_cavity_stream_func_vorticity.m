clc
clear

tolerance = 1e-4;
Nx = 51;
Ny = 51;
Re = 100;
gamma = 1/Re;
delta = 1/(Nx-1);
u_inf = 1;
rho = 1;

psi_k = zeros(Ny,Nx);
psi_k_1 = zeros(Ny,Nx);

vor_k = zeros(Ny,Nx);
vor_k_1 = zeros(Ny,Nx);

P_k = zeros(Ny,Nx);
P_k_1 = zeros(Ny,Nx);

u = zeros(Ny,Nx);
u(Ny,:) = u_inf;
v= zeros(Ny,Nx);

condition = true;
iter = 0;
beta = delta/(2*gamma);

while condition

    for i = 2:Ny-1
        for j = 2:Nx-1
            vor_k_1(i,j) = 0.25*(vor_k_1(i,j-1)*(1 + beta*u(i,j)) + vor_k_1(i-1,j)*(1 + beta*v(i,j)) ...
                + (1 - beta*u(i,j))*vor_k(i,j+1) + (1 - beta*v(i,j))*vor_k(i+1,j));            
        end
    end
    
    for i = 2:Ny-1
        for j = 2:Nx-1 
            psi_k_1(i,j) = 0.25*(psi_k(i,j+1) + psi_k(i+1,j) + psi_k_1(i-1,j) + psi_k_1(i,j-1) + (delta^2)*vor_k_1(i,j)); 
        end        
    end
    
    
    for i = 2:Ny-1
        for j = 2:Nx-1
            u(i,j) = (psi_k_1(i+1,j) - psi_k_1(i-1,j))/(2*delta);
            v(i,j) = -(psi_k_1(i,j+1) - psi_k_1(i,j-1))/(2*delta);  
        end
    end

    vor_k_1(1,:) = -2*psi_k_1(2,:)/(delta^2);
    vor_k_1(Ny,:) = -2*(u_inf*delta + psi_k_1(Ny-1,:))/(delta^2);
    vor_k_1(:,1) = -2*psi_k_1(:,2)/(delta^2);
    vor_k_1(:,Nx) = -2*psi_k_1(:,Nx-1)/(delta^2);
    
    
    error = 0;

    for i = 1:Ny
        for j = 1:Nx
            error = error + abs(vor_k_1(i,j) - vor_k(i,j));
        end
    end

    condition = (error > tolerance);
    iter = iter + 1;

    psi_k = psi_k_1;
    vor_k = vor_k_1;


end

%this is using the stream function equation to evaluate pressure (uncomment
%to use it)
for i = 2:Ny-1
    for j = 2:Nx-1
        K = ((psi_k_1(i,j+1) -2*psi_k_1(i,j) + psi_k_1(i,j-1))/(delta^2))*((psi_k_1(i+1,j) -2*psi_k_1(i,j) + psi_k_1(i-1,j))/(delta^2)) - ((psi_k_1(i+1,j+1) + psi_k_1(i-1,j-1) - psi_k(i-1,j+1) - psi_k_1(i+1,j-1))/(4*delta^2))^2;
        P_k_1(i,j) = 0.25*(P_k_1(i-1,j) + P_k(i+1,j) + P_k(i,j+1) + P_k_1(i,j-1) - 2*rho*K*delta^2);
    end
end

P_k_1(1,:) = P_k_1(2,:);
P_k_1(Ny,:) = P_k_1(Ny-1,:);
P_k_1(:,1) = P_k_1(:,2);
P_k_1(:,Nx) = P_k_1(:,Nx-1);

%this is using the NS X-direction equation to evaluate pressure (use either
%this block of code or the above one which uses stream function)
% for i = 2:Ny-1
%     for j = 2:Nx-1
%         P_k_1(i,j) = 0.5*rho*((u(i,j+1) - u(i,j-1))*u(i,j) + (u(i,j+1) - u(i,j-1))*v(i,j)) + P_k(i,j+1) - (rho/(Re*delta))*(u(i+1,j) + u(i-1,j) + u(i,j+1) + u(i,j-1));
%     end
% end
% 
% P_k_1(1,:) = P_k_1(2,:);
% P_k_1(Ny,:) = P_k_1(Ny-1,:);
% P_k_1(:,1) = P_k_1(:,2);
% P_k_1(:,Nx) = P_k_1(:,Nx-1);