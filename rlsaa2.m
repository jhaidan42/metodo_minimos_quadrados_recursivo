function [sys, x0] = rlsaa2(t,x,u,flag)

if flag == 0
    ninput=2;				% Num de entradas u(k) e y(k)
    nout=2;				% Num de saidas = parametros
    theta(1:2,1:2)=1;
    P(1:2,1:2)=1;
    K(1,1:2)=1;
    
    x0 = [1 1 1 1 1 1 1 1]';          % Inicializa vetor de estados (coluna)
    
    sys = [0;size(x0,1); nout; ninput;0;0];  % Depois que defini, nunca mudei desde 19xx!
%---------------------------------------------------------------------
% flag = 2 --> retorna estados do sistema
elseif flag == 2 
    phi(1,1) = u(1); 
    phi(2,1) = u(2);
    theta(1,2) = x(1); 
    theta(1,2) = x(2);
    K(1,1) = x(3); 
    K(1,2) = x(4);
    P(1,1) = x(5);
    P(2,1) = x(6);
    P(1,2) = x(7); 
    P(2,2) = x(8);
 
    K = (P*phi(:,1))\(eye(2)+phi(:,1)'*P*phi(:,1));
    
    theta(:,1) = theta(:,2) + K'*(u(1)-phi(:,1)'*theta(:,2));
    
    P = P - K*phi(:,1)*P;
    
    sys = [theta(:,1); K'; ; P(:,1); P(:,2)];
    
%---------------------------------------------------------------------
% flag = 3 --> Retorna vetor de saida

elseif flag == 3
    sys = [x(1); x(2)];
end

