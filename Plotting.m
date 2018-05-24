function [] = Plotting(p,xtable,ytable,r,n, live_simulation,t,collisionCounter,collisionPos,activeParticles,inactiveEarthParticles,inactiveSpaceParticles,simHeight,start_partikel_antal)
    if(live_simulation==true)
        % Plotting
        hold off
        plot(p(2,activeParticles), p(3,activeParticles), '.'); % particles current position
        text(p(2,activeParticles),p(3,activeParticles),"P"+p(1,activeParticles),'FontSize', 8,'horizontalAlignment', 'center','verticalAlignment', 'bottom');
        axis equal;
        axis([-10000000 10000000 -10000000 10000000])
        grid on;
        grid minor;
        title("Simulation: Højde mellem "+simHeight(1)+" og "+simHeight(2)+" meters højde fra jorden");
        xlabel('X position');
        ylabel('Y position');
        hold on;
        for i=1:1:size(p,2)
            if collisionCounter>0
                plot(collisionPos(1,:), collisionPos(2,:),'X');
                plot(p(2,inactiveEarthParticles), p(3,inactiveEarthParticles), '*'); % (Earth)
                plot(p(2,inactiveSpaceParticles), p(3,inactiveSpaceParticles), '*'); % (Space)
            end
        end
        viscircles([0 0],r,'Color',[0 0.1 0]); % The earth
        text(0,2100000,"Tidsskridt Kørt: "+ t,'FontSize',10,'horizontalAlignment', 'center');
        text(0,1400000,"Kollisioner = "+ collisionCounter,'FontSize',10,'horizontalAlignment', 'center');
        text(0,700000,"Start Antal Partikler = "+ start_partikel_antal,'FontSize',10,'horizontalAlignment', 'center');
        text(0,0,"Aktive Partikler = "+ size(activeParticles,2),'FontSize',10,'horizontalAlignment', 'center');
        text(0,-700000,"Partikler på jorden = "+ size(inactiveEarthParticles,2),'FontSize',10,'horizontalAlignment', 'center');
        text(0,-1400000,"Partikler udenfor Sim = "+ size(inactiveSpaceParticles,2),'FontSize',10,'horizontalAlignment', 'center');
    else
        % Plotting
        hold on;
        axis equal;
        grid on;
        grid minor;
        title("Simulation: Højde mellem "+simHeight(1)+" og "+simHeight(2)+" meters højde fra jorden");
        xlabel('X position');
        ylabel('Y position');
        viscircles([0 0],r,'Color',[0 0.1 0]); % The earth
        for i = 1:1:size(p,2)
            plot(p(2,activeParticles), p(3,activeParticles), '.'); % particles current position
            plot(p(2,inactiveEarthParticles), p(3,inactiveEarthParticles), '*'); % (Earth)
            plot(p(2,inactiveSpaceParticles), p(3,inactiveSpaceParticles), '*'); % (Space)
            text(p(2,activeParticles),p(3,activeParticles),"P"+p(1,activeParticles),'FontSize', 8,'horizontalAlignment', 'center','verticalAlignment', 'bottom');

            plot(xtable(i,:),ytable(i,:),'-'); % Particles travel in orbit
            if collisionCounter>0
                plot(collisionPos(1,:), collisionPos(2,:),'X');
            end
        end
        text(0,2100000,"Tidsskridt Kørt: "+ t,'FontSize',10,'horizontalAlignment', 'center');
        text(0,1400000,"Kollisioner = "+ collisionCounter,'FontSize',10,'horizontalAlignment', 'center');
        text(0,700000,"Start Antal Partikler = "+ start_partikel_antal,'FontSize',10,'horizontalAlignment', 'center');
        text(0,0,"Aktive Partikler = "+ size(activeParticles,2),'FontSize',10,'horizontalAlignment', 'center');
        text(0,-700000,"Partikler på jorden = "+ size(inactiveEarthParticles,2),'FontSize',10,'horizontalAlignment', 'center');
        text(0,-1400000,"Partikler udenfor Sim = "+ size(inactiveSpaceParticles,2),'FontSize',10,'horizontalAlignment', 'center');
    end
end
