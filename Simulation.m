function [ttable,xtable,ytable,p] = Simulation(n,p,t_end,dt);

% Initalize empty tables
[ttable,xtable,ytable] = deal(zeros(size(p,2),n));

for i=1:1:size(p,2)
    
     % Start the simulation at the initial contitions.
     t = 0;
     GM = p(4,i);
     x = deal(p(5,i));
     y = deal(p(6,i));
     x_0 = p(5,i);
     y_0 = p(6,i);
     
     
     v_0 = p(9,i);
     vinkel = p(7,i);
    
     v_x0 = -v_0*sin(vinkel);
     v_y0 = v_0*cos(vinkel);
     
     v_x = v_x0;
     v_y = v_y0;

     for n=1:1:n
         % The LeapFrog method
         t = t + dt;   % Update the time
         
         % Calculate acceleration on a mass attached to spring
         a_x = -GM*(x/((x_0.^2+y_0.^2)^1.5));      
         a_y = -GM*(y/((x_0.^2+y_0.^2)^1.5));  
         
         
         
         % Update the velocity
         v_x = v_x + a_x*dt; 
         v_y = v_y + a_y*dt;
         v = [v_x;v_y];
         
         
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

         % t, v, and x are stored for later use, e.g., plot(ttable,xtable)
         ttable(i, n) = t;
         xtable(i, n) = x;
         ytable(i, n) = y;
         
         p(2,i) = x;
         p(3,i) = y;
         p(10,i) = t;
     end

end