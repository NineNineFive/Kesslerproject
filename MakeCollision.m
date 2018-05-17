function [pos_new, vel_new, mass_new] = MakeCollision (pos1, pos2, vel1, vel2, m1, m2)
    impuls = [m1*vel1 ; m2*vel2];   %impuls p = m*v

    % Center of mass 
    cm = (m1*pos1+m2*pos2)/(m1+m2); 

    % Velocity i Center of mass 
    vcm = sum(impuls)/(m1+m2); % Velocity - Center of Mass
    
    % frame
    vel1 = vel1 - vcm; % 1x2= 1x2 - 1x2
    vel2 = vel2 - vcm;

    impulse_new = -1+(1+1).*rand(12,2); % min+(max-min).*(12x3 array from 0 to 1)
    average_impulse = sum(impulse_new)/12; %gennemsnit (1x3 array)
    impulse_new = impulse_new - average_impulse;

    mass_new = [m1/3;m1/6;m1/6;m1/9;m1/9;m1/9;m2/3;m2/6;m2/6;m2/9;m2/9;m2/9];
    vel_new = (impulse_new(:,1:2)./mass_new);
    
    % old kinetic energy
    k_old = 0.5 * [m1;m2] .* [norm(vel1)^2;norm(vel2)^2];
    k_tot_old = sum(k_old);

    % new kinetic energy
    k_new = 0.5 * mass_new .* vel_new .^ 2;
    k_tot_new = sum(k_new);

    % factor
    factor = sqrt(k_tot_old ./ k_tot_new); 

    vel_new = vel_new .* factor;

    vel_new = vel_new + vcm;

    pos_new = cm;
end

%     % Partikel 1
%     p(15,i) = p(15,i)+1; % is 1 if collision happened and is recorded in the particles data
%     p(16:17,i) = p(2:3,i); % Position of collisions  
% 
%     impuls = p(13,i)*p(5:6,i);   %impuls p = m*v
%     p(14,i) = 1/2*p(12,i)*( norm(p(5:6,i)) )^2; % Formlen for energi: 1/2*objMasse*(velocity)^2
% 
% 
%     % Partikel 2
%     p(15,j) = p(15,j)+1; % is 1 if collision happened and is recorded in the particles data
%     p(16:17,j) = p(2:3,j);
% 
% 
%     impuls2 = p(13,j)*p(5:6,j);
%     p(14,j) = 1/2*p(13,j)*(norm(p(5:6,j))^2); % Formlen for energi: 1/2*objMasse*(velocity)^2
% 
% 
%     % Center of mass frame
%     vcm = (impuls+impuls2)/(p(13,i)+p(13,j)); % Velocity - Center of Mass
% 
%     % CM frame 
%     vel1indframe = [p(5,i);p(6,i)] - vcm;      %vel1indframe = vel1 - vcm; 
%     vel2indframe = [p(5,j);p(6,j)] - vcm; 
% 
%     % Energi (ikke bevaret)
% 
%     k_ind1 = (1/2)*p(13,i)*norm([p(5,i);p(6,i)])^2;
%     k_ind2 = (1/2)*p(13,j)*norm([p(5,j);p(6,j)])^2;
% 
%     %energisum = p(16,i)+p(16,j);
%     %energiud = energisum*(0.9);
% 
%     k_ud1 = (k_ind1)*0.9;
%     k_ud2 = (k_ind2)*0.9;
%     k_0 = (k_ud1+k_ud2);
% 
% 
%     % Kollision i frame 
%     vel1udframe = -vel1indframe;
%     vel2udframe = -vel2indframe;
% 
%     % Frame kredsløb 
%     vel1ud = vel1udframe + vcm; 
%     vel2ud = vel2udframe + vcm; 
% 
% 
%     %sqrt(k_ind1)*[p(5,i);p(6,i)]
% 
%     % Set new velocity for existing particles
%     p(5:6,i) = -p(5:6,i);
%     p(5:6,j) = -p(5:6,j);
