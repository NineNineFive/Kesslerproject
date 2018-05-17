function [new_pos, new_vel, new_mass] = MakeCollision (pos1, pos2, vel1, vel2, m1, m2)

    %impulse_ = -1+(1+1).*rand(12,3); % min+(max-min).*(12x3 array from 0 to 1)
    %average_impulse = sum(impulse_)/12; %gennemsnit (1x3 array)
    %impulse_ = impulse_ - average_impulse;
    
    %mass_ = [m1/3;m1/6;m1/6;m1/9;m1/9;m1/9;m2/3;m2/6;m2/6;m2/9;m2/9;m2/9];
    
    %vel_ = impulse_(:,1)./mass_+impulse_(:,2)./mass_+impulse_(:,3)./mass_;
    
    %k_ = 0.5 * m * v.^2; % I dont know what to do here :c
    %ktot_ = sum(k_); % help me Lars
    %factor = sqrt(ktot/ktot_); % you are my only hope
    
    new_pos = 0;
    new_vel = 0;
    new_mass = 0;
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
