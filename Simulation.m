% pos is p(2:3,:); % dimensions of pos (2D)
% vel is p(5:6,:); % dimensions of vel (2D)
% acc is p(8:9,:); % dimensions of acc (2D)
function [ttable,xtable,ytable,p] = Simulation(live_simulation,p,n,dt,r,G,M)
    
    % Initalize empty tables
    [ttable,xtable,ytable] = deal(zeros(size(p,2),n));

    % Start the simulation at the initial contitions.
    t = 0; % Start time
    GM = G*M; % gravitition constant and the earth's mass

    for n=1:1:n
        t = t + dt;   % Update the time   
        p(8:9,:) = -GM.*(p(2:3,:)./((p(2,:).^2+p(3,:).^2).^1.5)); % Calculate the acceleration  
        p(5:6,:) = p(5:6,:) + p(8:9,:)*dt; % Update the velocity with acceleration
        p(2:3,:) = p(2:3,:) + p(5:6,:)*dt; % Update the position with velocity

        % Collisions
        for i=1:1:size(p,2) % Particle 1
            for j=1:1:size(p,2) % Particle 2
                if(i~=j)
                    % Calculation for the 'if collision can happens'
                    pji = p(2:3,j)-p(2:3,i);
                    vij = p(5:6,j)-p(5:6,i);
                    pjiparallel = (dot(pji, vij)*vij)/(norm(vij).^2);
                    pjivinkelret = pji - pjiparallel;

                    if((norm(pjiparallel) < norm(vij)*dt) && norm(pjivinkelret) < p(12,i) + p(12,j))
                        % MakeCollision between particles
                        [new_pos, new_vel, new_mass] = MakeCollision(p(2:3,i), p(2:3,j), p(5:6,i), p(5:6,j), p(13,i), p(13,j));
                    end
                end
            end
        end

        % the particle's travel data
        for i=1:1:size(p,2)
            ttable(i, n) = n;
            xtable(i, n) = p(2,i);
            ytable(i, n) = p(3,i);
        end

        % live plotting
        if live_simulation==true && mod(n,15)==0
            Plotting(p,ttable,xtable,ytable,r,n, live_simulation,t);
        end
    end

    % not live plotting
    if(live_simulation==false)
        Plotting(p,ttable,xtable,ytable,r,n,live_simulation,t);
    end
end
