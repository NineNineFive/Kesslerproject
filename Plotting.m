function [] = Plotting(p,ttable,xtable,ytable,r,n, live_simulation,t,collisionCounter,collisionPos,activeParticles,inactiveParticles)
    if(live_simulation==true)
        % Plotting
        hold off

        plot(p(2,activeParticles), p(3,activeParticles), '.'); % particles current position
        text(p(2,activeParticles),p(3,activeParticles),"P"+p(1,activeParticles));
        
        axis equal;
        axis([-10000000 10000000 -10000000 10000000])
        grid on;
        title("Simulation: Height between 200000 meters to 201000 meters");
        xlabel('X position');
        ylabel('Y position');
        hold on;
        for i=1:1:size(p,2)
            if collisionCounter>0
                plot(collisionPos(1,:), collisionPos(2,:),'X');
                plot(p(2,inactiveParticles), p(3,inactiveParticles), '*'); % particles current position
            end
        end

        earth = viscircles([0 0],r,'Color',[0 0.2 0]); % The earth

        text(0,900000,"Tidsskridt Kørt: "+ t);
        text(0,300000,"Kollisioner = "+ collisionCounter);
        text(0,-300000,"Aktive Partikler = "+ size(activeParticles,2));
        
    else

    % Plotting
    hold on;
    axis equal;
    %axis([-7000000 7000000 -7000000 7000000])
    grid on;     
    xlabel('X position');
    ylabel('Y position');
    earth = viscircles([0 0],r,'Color',[0 0.2 0]); % The earth
    for i = 1:1:size(p,2)
        plot(p(2,activeParticles), p(3,activeParticles), '.'); % particles current position
        plot(p(2,inactiveParticles), p(3,inactiveParticles), '*'); % particles current position
        text(p(2,activeParticles),p(3,activeParticles),"P"+p(1,activeParticles));
        
        plot(xtable(i,:),ytable(i,:),'-'); % Particles travel in orbit
        if collisionCounter>0
            plot(collisionPos(1,:), collisionPos(2,:),'X');
        end
    end

    text(0,900000,"Tidsskridt kørt: "+ t);
    text(0,300000,"Kollisioner = "+ collisionCounter);
    text(0,-300000,"Aktive Partikler = "+ size(activeParticles,2));
    end
end
