function [new_pos, new_vel, new_mass] = MakeCollision (pos1, pos2, vel1, vel2, m1, m2)

    impulse_ = -1+(1+1).*rand(12,3); % min+(max-min).*(12x3 array from 0 to 1)
    average_impulse = sum(impulse_)/12; %gennemsnit (1x3 array)
    impulse_ = impulse_ - average_impulse;
    
    mass_ = [m1/3;m1/6;m1/6;m1/9;m1/9;m1/9;m2/3;m2/6;m2/6;m2/9;m2/9;m2/9];
    
    vel_ = impulse_(:,1)./mass_+impulse_(:,2)./mass_+impulse_(:,3)./mass_;
    
    k_ = 0.5 * m * v.^2; % I dont know what to do here :c
    ktot_ = sum(k_); % help me Lars
    factor = sqrt(ktot/ktot_); % you are my only hope
    
    
end