function [] = Plotting(p,ttable,xtable,ytable,r,n, live_simulation)
    if(live_simulation==true)
        % Plotting
        figure(2);

        hold off
        plot(p(2,:), p(3,:), '.'); % particles current position
        axis equal;
        axis([-7000000 7000000 -7000000 7000000])
        grid on;
        xlabel('X position');
        ylabel('Y position');
        hold on;
        for i=1:1:size(p,2)
            if p(14,i)~=0&&p(15,i)~=0
                plot(p(14,i), p(15,i),'X');
            end
        end

        earth = viscircles([0 0],r,'Color',[0 0.4 0]); % The earth
        %for i=1:1:size
        %colls = 
        colls = 0;
        for i=1:1:size(p,2)
            colls = colls+p(13,i);
        end
        text(0,300000,"Kollisions = "+ colls);
        text(0,-300000,"Particle count = "+ size(p,2));
        %plot(xtable(:,n),ytable(:,n)); % Particles travel in orbit
    else
            % Plotting
     figure(2);
     axis equal;
     grid on;
     hold on;
     xlabel('X position');
     ylabel('Y position');
     earth = viscircles([0 0],r,'Color',[0 0.4 0]); % The earth
     for i = 1:1:size(p,2)
         plot(p(2,:), p(3,:), '.'); % particles current position
         plot(xtable(i,:),ytable(i,:)); % Particles travel in orbit
         if p(14,i)~=0&&p(15,i)~=0
             plot(p(14,i), p(15,i),'X');
         end
     end
    end
end


% not live function of plot
% function [] = Plotting(p,ttable,xtable,ytable,r,n)

% end
