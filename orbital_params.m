function [a, epsilon] = orbital_params(positions, velocities, ...
                                          masses, G, dt)
    
    D = size(positions, 2) ; % number of dimensions

    % need positions and velocities at the same time. Easiest to 
    % rewind positions by half a time step (to update the
    % velocities by half a time step would require forces)
    adjusted_positions = positions-0.5*velocities*dt;
    
    
    % assume the first body is the sun and then calculate params
    % for each other body as if it was the only body in orbit
    % around the sun
    nplanets = size(positions,1) - 1;
    p_sun = adjusted_positions(1,:);
    v_sun = velocities(1,:);
    m_sun = masses(1);
    % make arrays for the results, size nplanets
    a = zeros(nplanets);
    epsilon = zeros(nplanets);
    
    % we calculate the relative displacement and velocities, and
    % reduced mass for each planet relative to the sun.
    % Then we use formulas in Chapter 2 of Carroll and Ostlie,
    % Introduction to Modern Astrophysics, to calculate semi-major
    % axis and eccentricity. These require calculating first the
    % potential and kinetic energy, and angular momentum for a
    % given two-body system (ignoring all other bodies)
    
    for pdx = 1:nplanets
        pos = adjusted_positions(pdx+1,:);
        vel = velocities(pdx+1,:);
        mass = masses(pdx+1);
        mu = (mass*m_sun)/ (mass+m_sun); % reduced mass
        p_rel = pos-p_sun; % relative displacement
        v_rel = vel - v_sun; % relative velocity
        dist = sqrt(sum(p_rel.^2));
        
        Epot = - G * m_sun * mass / dist;
        Ekin = 0.5 * mu * sum(v_rel.^2);
        Etot = Epot + Ekin;
        a(pdx) = -G*m_sun*mass/(2*Etot);
        % angular momentum is just one number in 2D, but a vector
        % in 3D
        if D == 3
            L = mu*[p_rel(2)*v_rel(3) - p_rel(3)*v_rel(2),
                    p_rel(3)*v_rel(1) - p_rel(1)*v_rel(3),
                    p_rel(1)*v_rel(2) - p_rel(2)*v_rel(1)];
            
        else
            L = mu*[p_rel(1)*v_rel(2) - p_rel(2)*v_rel(1)];
        end   
        L2 = sum(L.^2);
        epsilon(pdx) = sqrt(1 - L2 / (mu^2*G*(m_sun+mass)*a(pdx) ) );
    end
    
    

end
