function [ttable,xtable,ytable,p] = Simulation(n,p,t_end,dt);

% Initalize empty tables
[ttable,xtable,ytable] = deal(zeros(size(p,2),n));

     % Start the simulation at the initial contitions.
     t = 0;
     GM = p(4,:);
     x = p(5,:); % x_0
     y = p(6,:); % y_0
     
     vinkel = p(7,:);
     
     v_x = -p(9,:).*sin(vinkel); % V_x = -(V_0) * sin(vinkel)
     v_y = p(9,:).*cos(vinkel); % V_y = (V_0) * cos(vinkel)

     for n=1:1:n
         % The LeapFrog method
         t = t + dt;   % Update the time
         
         % Calculate acceleration on a mass attached to spring
         a_x = -GM.*(x./((x.^2+y.^2).^1.5));      
         a_y = -GM.*(y./((x.^2+y.^2).^1.5));  
         
         
         
         % Update the velocity
         v_x = v_x + a_x.*dt; 
         v_y = v_y + a_y.*dt;
         v = [v_x;v_y];
         
         
         % Distancen tager forhold til alle partiklers sum
         % den skal kun tage forhold til en partikel for sig's sums
         for i=1:1:size(p,2) 
             for j=i+1:1:size(p,2)
                 displacem = p(2:3,i)-p(2:3,j); % displacem=par1xy-par2xy
                 distance = sum(displacem.^2);
                 if(distance<=100+100)
                    p(13,i) = true; 
                    p(12,i) = distance;
                    %disp(distance);
                 else
                     %disp(distance);
                     %p(13,i) = false;
                     %p(12,i) = distance;
                    
                 end
             end
         end
         
         % Update the position
         x = x + v_x*dt;
         y = y + v_y*dt;

         
         p(2,:) = x;
         p(3,:) = y;
         p(10,:) = t;
         
         % t, v, and x are stored for later use, e.g., plot(ttable,xtable)
         for i=1:1:size(p,2)
             ttable(i, n) = p(10,i);
             xtable(i, n) = p(2,i);
             ytable(i, n) = p(3,i);
         end
         

end