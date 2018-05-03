function [ttable,xtable,ytable,p] = Simulation(n,p,t_end,dt);

% Initalize empty tables
[ttable,xtable,ytable] = deal(zeros(size(p,2),n));

     % Start the simulation at the initial contitions.
     t = 0;
     GM = p(4,:);
     x = deal(p(5,:));
     y = deal(p(6,:));
     
     
     v_0 = p(9,:);
     vinkel = p(7,:);
    
     v_x0 = -v_0.*sin(vinkel);
     v_y0 = v_0.*cos(vinkel);
     
     v_x = v_x0;
     v_y = v_y0;

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
         
        for i=1:1:size(p,2) 
         for j=i:1:size(p,2)
            displacement = p(2:3,i)-p(2:3,j);
            distance(i,j) = sum(displacement.^2);
            if(distance(i,j)<=100+100)
                p(11,i) = true; 
                p(12,i) = distance(i,j);
            else
                p(11,i) = false;
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

end