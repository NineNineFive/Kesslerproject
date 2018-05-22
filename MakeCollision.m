function [pos_new, vel_new, mass_new] = MakeCollision (pos1, pos2, vel1, vel2, m1, m2)
    impuls1 = [m1*vel1];   %impuls1 p = m*v
    impuls2 = [m2*vel2];   %impuls2 p = m*v
    % Center of mass 
    cm = (m1*pos1+m2*pos2)/(m1+m2); 

    % Velocity i Center of mass 
   % ---> %vcm = sum(impuls1)+sum(impuls2)/(m1+m2); % Velocity - Center of Mass
    %% vi skal have 2 dimensioner ind, men har kun 1, i need help!

    disp("Pos1");
    disp(pos1);
    disp("Pos2");
    disp(pos2);
    
    disp("vel1");
    disp(vel1);
    
    disp("vel2");
    disp(vel2);
    
    disp("m1");
    disp(m1);
    
    disp("m2");
    disp(m2);
    
    disp("cm");
    disp(cm);
    
    disp("impuls");
    disp(impuls1);
    
    disp("sum of impuls1");
    disp(sum(impuls1));
    
    disp("sum of impuls2");
    disp(sum(impuls2));
    
    disp("vcm");
    disp(vcm);
    
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