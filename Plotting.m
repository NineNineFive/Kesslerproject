function [] = Plotting(p,ttable,xtable,ytable,r,n, live_simulation,t,collisionCounter,collisionPos)
    if(live_simulation==true)
        % Plotting
        figure(2);

        hold off
        plot(p(2,:), p(3,:), '.'); % particles current position
        text(p(2,:),p(3,:),"P"+p(1,:));
        
        axis equal;
        axis([-7000000 7000000 -7000000 7000000])
        grid on;
        xlabel('X position');
        ylabel('Y position');
        hold on;
        for i=1:1:size(p,2)
            if collisionCounter>0
                plot(collisionPos(1,:), collisionPos(2,:),'X');
            end
        end

        earth = viscircles([0 0],r,'Color',[0 0.4 0]); % The earth

        text(0,900000,"Tidsskridt k�rt: "+ t);
        text(0,300000,"Kollisioner = "+ collisionCounter);
        text(0,-300000,"antal partikler = "+ size(p,2));
        %plot(xtable(:,n),ytable(:,n)); % Particles travel in orbit
    else
        
%| 1: id | 2: x | 3: y | 4: z | 5: vel x |6: vel y | 7: vel z | 8: acceleration x | 9: acceleration y | 10: acceleration z | 11: v_0 | 12: objSize | 13: objMass |
%14: kineticEnergy % | 15: collisionCounter | 16: collisionPos x | 17: collisionPos y | 18: collisionPos z | 19: rh |
        
    % Plotting
    figure(2);
    axis equal;
    %axis([-7000000 7000000 -7000000 7000000])
    grid on;     
    hold on;
    xlabel('X position');
    ylabel('Y position');
    earth = viscircles([0 0],r,'Color',[0 0.4 0]); % The earth
    for i = 1:1:size(p,2)
        plot(p(2,:), p(3,:), '.'); % particles current position
        text(p(2,:),p(3,:),"P"+p(1,:));
        
        plot(xtable(i,:),ytable(i,:)); % Particles travel in orbit
        if collisionCounter>0
            plot(collisionPos(1,:), collisionPos(2,:),'X');
        end
    end

    text(0,900000,"Tidsskridt k�rt: "+ t);
    text(0,300000,"Kollisioner = "+ collisionCounter);
    text(0,-300000,"antal partikler = "+ size(p,2));
    end
end


% not live function of plot
% function [] = Plotting(p,ttable,xtable,ytable,r,n)

% end
