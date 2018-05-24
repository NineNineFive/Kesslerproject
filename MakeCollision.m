function [pos_new, vel_new, mass_new, size_new] = MakeCollision (pos1, pos2, vel1, vel2, m1, m2, size1, size2)
    impuls1 = [m1*vel1];   %impuls1 p = m*v
    impuls2 = [m2*vel2];   %impuls2 p = m*v
    % Center of mass 
    cm = (m1*pos1+m2*pos2)/(m1+m2); 

    % Velocity i Center of mass 
    vcm = (impuls1+impuls2)/(m1+m2); % Velocity - Center of Mass

    % frame
    vel1 = vel1 - vcm; % 1x2= 1x2 - 1x2
    vel2 = vel2 - vcm;

    impuls_new = -1+(1+1).*rand(12,2); % min+(max-min).*(12x3 array from 0 to 1)
    average_impulse = sum(impuls_new)/12; %gennemsnit (1x3 array)
    impuls_new = impuls_new - average_impulse;

    mass_new = [m1/3;m1/6;m1/6;m1/9;m1/9;m1/9;m2/3;m2/6;m2/6;m2/9;m2/9;m2/9];
    size_new = [size1/3;size1/6;size1/6;size1/9;size1/9;size1/9;size2/3;size2/6;size2/6;size2/9;size2/9;size2/9];
    vel_new = (impuls_new(:,1:2)./mass_new);
    
    % old kinetic energy
    k_old = 0.5 * [m1;m2] .* [norm(vel1).^2;norm(vel2).^2];
    k_tot_old = sum(k_old);

    % new kinetic energy
    k_new = 0.5 * mass_new .* vel_new .^ 2;
    k_tot_new = sum(k_new);

    % factor
    factor = sqrt(k_tot_old ./ k_tot_new); 

    vel_new = vel_new .* factor;
    
    % De skal ud af frame
    vel_new = vel_new + repmat(vcm',[12,1]);

    pos_new = cm;
end