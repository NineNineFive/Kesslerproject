% pos is p(2:3,:); % dimensions of pos (2D)
% vel is p(5:6,:); % dimensions of vel (2D)
% acc is p(8:9,:); % dimensions of acc (2D)
function [xtable,ytable,p] = Simulation(live_simulation,p,n,dt,r,G,M,simHeight,start_partikel_antal)
    
    % Initalize empty tables
    [xtable,ytable] = deal(zeros(size(p,2),n));

    collisionCounter = 0;
    collisionPos = [];
    
    startedSim = 0;
    
    % Start the simulation at the initial contitions.
    t = 0; % Start time
    GM = G*M; % gravitition constant and the earth's mass

    for n=1:1:n
        t = t + dt;   % Update the time
        p(17,:) = vecnorm(p(2:3,:)); % Update RH
        
        % Set Particles inactive
        p(15,find(p(17,:)<r)) = 1;
        p(16,find(p(17,:)>2*10^7)) = 1;
        
        % Select particles who are active or inactive into 3 variables
        activeParticles = find(p(15,:)==0&p(16,:)==0);
        inactiveEarthParticles = find(p(15,:)==1);
        inactiveSpaceParticles = find(p(16,:)==1);
        
        % Update particles acc, vel and position
        p(8:9,activeParticles) = -GM.*(p(2:3,activeParticles)./((p(2,activeParticles).^2+p(3,activeParticles).^2).^1.5)); % Calculate the acceleration  
        p(5:6,activeParticles) = p(5:6,activeParticles) + p(8:9,activeParticles)*dt; % Update the velocity with acceleration
        p(2:3,activeParticles) = p(2:3,activeParticles) + p(5:6,activeParticles)*dt; % Update the position with velocity
        
        % Update cantCollideTimer
        p(14,activeParticles) = p(14,activeParticles)-dt; % To ensure collision detection runs without errors or forever-loops

        % Collisions
        for i=1:1:size(p(1,activeParticles),2) % Particle 1
            for j=i+1:1:size(p(1,activeParticles),2) % Particle 2
                if(i~=j && p(15,i)~=1 && p(15,j)~=1)
                    % Calculation for the 'if collision can happens'
                    pji = p(2:3,j)-p(2:3,i);
                    vij = p(5:6,j)-p(5:6,i);
                    pjiparallel = (dot(pji, vij)*vij)/(norm(vij).^2);
                    pjivinkelret = pji - pjiparallel;

                    if(p(15,i)~=1&&p(15,j)~=1&&p(14,i)<=0&&p(14,j)<=0&&(norm(pjiparallel) < norm(vij)*dt) && norm(pjivinkelret) < (p(12,i) + p(12,j))&&(p(2,i)~=p(2,j)&&p(3,i)~=p(3,j)))
                        % MakeCollision between particles
                        [pos_new, vel_new, mass_new, size_new] = MakeCollision(p(2:3,i), p(2:3,j), p(5:6,i), p(5:6,j), p(13,i), p(13,j), p(12,i), p(12,j));

                        xtable(size(xtable)+1:size(xtable)+10, 1:n) = pos_new(1);
                        ytable(size(ytable)+1:size(ytable)+10, 1:n) = pos_new(2);

                        collisionPos = [collisionPos, pos_new];
                        collisionCounter = collisionCounter+1;

                        for p_i = 1:1:size(mass_new,1)
                            cantColTimer_new = 2*dt;
                            if p_i==1
                                p(2:3,i) = pos_new;
                                p(5:6,i) = vel_new(p_i,:);
                                p(12,i) = size_new(p_i,:);
                                p(13,i) = mass_new(p_i,:);
                                p(4,i) = 0;
                                p(14,i) = cantColTimer_new;
                            elseif p_i==2
                                p(2:3,j) = pos_new;
                                p(5:6,j) = vel_new(p_i,:);
                                p(12,j) = size_new(p_i,:);
                                p(13,j) = mass_new(p_i,:);
                                p(4,j) = 0;
                                p(14,j) = cantColTimer_new;
                            else
                                id_new = size(p,2)+1;
                                v_0_new = 0;
                                objSize_new = size_new(p_i,:);
                                objMass_new = mass_new(p_i,:).';
                                values_new = [id_new;pos_new;0;vel_new(p_i,:).';0;[0;0;0];v_0_new;objSize_new;objMass_new;cantColTimer_new;0;0;0];
                                p_new = values_new;
                                p = [p, p_new];
                            end         
                        end     
                    end
                end
            end
        end

        % the particle's travel data
        for i=1:1:size(p,2)
            if(p(2,i)~=0&&p(3,i)~=0)
                xtable(i, n) = p(2,i);
                ytable(i, n) = p(3,i);
            end
        end

        % Plotting settings
        figure(1);
        if(startedSim==1)
            % live plotting
            if live_simulation==true && mod(n,1)==0 % Edit this to change plotting speed
                Plotting(p,xtable,ytable,r,n, live_simulation,t,collisionCounter,collisionPos,activeParticles,inactiveEarthParticles,inactiveSpaceParticles,simHeight,start_partikel_antal);
            end
        else
           title("Press Spacebar To Start Simulation");
           pause;
           startedSim = 1;
        end
    end
    % not live plotting
    if(live_simulation==false)
        Plotting(p,xtable,ytable,r,n,live_simulation,t,collisionCounter,collisionPos,activeParticles,inactiveEarthParticles,inactiveSpaceParticles,simHeight,start_partikel_antal);
    end
end
