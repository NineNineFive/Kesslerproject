function [ttable,xtable,ytable,p] = Simulation(live_simulation,p,n,dt,r,G,M)

% Initalize empty tables
[ttable,xtable,ytable] = deal(zeros(size(p,2),n));
    
     % Start the simulation at the initial contitions.
     t = 0; % Start time
     % pos = p(2:3,:); % dimensions of pos (2D)
     % vel = p(5:6,:); % dimensions of vel (2D)
     % acc = p(8:9,:); % dimensions of acc (2D)
     GM = G*M; % gravititions constant and the earths mass

    for n=1:1:n
         t = t + dt;   % Update the time   
         p(8:9,:) = -GM.*(p(2:3,:)./((p(2,:).^2+p(3,:).^2).^1.5)); % Calculate the acceleration  
         p(5:6,:) = p(5:6,:) + p(8:9,:)*dt; % Update the velocity with acceleration
         p(2:3,:) = p(2:3,:) + p(5:6,:)*dt; % Update the position with velocity
         
%| 1: id | 2: x | 3: y | 4: z | 5: vel x |6: vel y | 7: vel z | 8: acceleration x | 9: acceleration y | 10: acceleration z | 
%11: v_0 | 12: objSize | 13: objMass | %14: kineticEnergy % | 15: collisionCounter | 
%16: collisionPos x | 17: collisionPos y | 18: collisionPos z | 19: rh |
         
         % Collisions
             for i=1:1:size(p,2) % Particle 1
                for j=1:1:size(p,2) % Particle 2
                     if(i~=j)
                        % parallel
                        pji = p(2:3,j)-p(2:3,i);
                        vij = p(5:6,j)-p(5:6,i);
                        % pjiparallel = (dot((p(2:3,j)-p(2:3,i)), p(5:6,j)-p(5:6,j))*p(5:6,j)-p(5:6,j))/(norm(p(5:6,j)-p(5:6,j)).^2);
                        pjiparallel = (dot(pji, vij)*vij)/(norm(vij).^2);
                        
                        % vinkelret
                        
                        pjivinkelret = pji - pjiparallel;
                        
                        % then - if((norm(Pijparallel)<norm(vij)*dt)&&norm(pjivinkelret)<p(11,i) + p(11,j))
                        if((norm(pjiparallel) < norm(vij)*dt) && norm(pjivinkelret) < p(12,i) + p(12,j))
                            % Partikel 1
                            p(15,i) = p(15,i)+1; % is 1 if collision happened and is recorded in the particles data
                            p(16:17,i) = p(2:3,i); % Position of collisions  
                            
                            impuls = p(13,i)*p(5:6,i);   %impuls p = m*v
                            p(14,i) = 1/2*p(12,i)*( norm(p(5:6,i)) )^2; % Formlen for energi: 1/2*objMasse*(velocity)^2
                            
                                
                            % Partikel 2
                            p(15,j) = p(15,j)+1; % is 1 if collision happened and is recorded in the particles data
                            p(16:17,j) = p(2:3,j);
                          
                            
                            impuls2 = p(13,j)*p(5:6,j);
                            p(14,j) = 1/2*p(13,j)*(norm(p(5:6,j))^2); % Formlen for energi: 1/2*objMasse*(velocity)^2
                            
                            
                            % Center of mass frame
                            vcm = (impuls+impuls2)/(p(13,i)+p(13,j)); % Velocity - Center of Mass
                            
                            % CM frame 
                            vel1indframe = [p(5,i);p(6,i)] - vcm;      %vel1indframe = vel1 - vcm; 
                            vel2indframe = [p(5,j);p(6,j)] - vcm; 
                            
                            % Energi (ikke bevaret)
                            
                            k_ind1 = (1/2)*p(13,i)*norm([p(5,i);p(6,i)])^2;
                            k_ind2 = (1/2)*p(13,j)*norm([p(5,j);p(6,j)])^2;
                            
                            %energisum = p(16,i)+p(16,j);
                            %energiud = energisum*(0.9);
                            
                            k_ud1 = (k_ind1)*0.9;
                            k_ud2 = (k_ind2)*0.9;
                            k_0 = (k_ud1+k_ud2);
                            
                           
                            % Kollision i frame 
                            vel1udframe = -vel1indframe;
                            vel2udframe = -vel2indframe;
                            
                            % Frame kredsløb 
                            vel1ud = vel1udframe + vcm; 
                            vel2ud = vel2udframe + vcm; 
                            
                            
                            %sqrt(k_ind1)*[p(5,i);p(6,i)]
                            
                            % Set new velocity for existing particles
                            p(5:6,i) = -p(5:6,i);
                            p(5:6,j) = -p(5:6,j);

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
