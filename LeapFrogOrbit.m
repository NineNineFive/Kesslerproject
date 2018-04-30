function [ttable,xtable,ytable,p] = LeapFrogOrbit(n,p,t_end,dt);

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

     for i2=1:1:n
         % The LeapFrog method
         t = t + dt;   % Update the time
         
         % Calculate acceleration on a mass attached to spring
         a_x = -GM*(x/((x_0.^2+y_0.^2)^1.5));      
         a_y = -GM*(y/((x_0.^2+y_0.^2)^1.5));  
         
         % Update the velocity
         v_x = v_x + a_x*dt; 
         v_y = v_y + a_y*dt;
         
         % Update the position
         x = x + v_x*dt;
         y = y + v_y*dt;

         % t, v, and x are stored for later use, e.g., plot(ttable,xtable)
         ttable(i, i2) = t;
         xtable(i, i2) = x;
         ytable(i, i2) = y;
         
         p(2,i) = x;
         p(3,i) = y;
         p(10,i) = t;
     end

end