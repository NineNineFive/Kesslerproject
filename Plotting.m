function [] = Plotting(p,ttable,xtable,ytable,r,n)
    % Plotting
    figure(2);

        hold off
        plot(p(2,:), p(3,:), '.'); % particles current position
        axis equal;
        grid on;
        xlabel('X position');
        ylabel('Y position');
        hold on;
        for i=1:1:size(p,2)
            if p(13,i)~=0&&p(14,i)~=0
                plot(p(13,i), p(14,i),'X');
            end
        end

        earth = viscircles([0 0],r,'Color',[0 0.4 0]); % The earth
        %plot(xtable(:,n),ytable(:,n)); % Particles travel in orbit

end


% not live function of plot
% function [] = Plotting(p,ttable,xtable,ytable,r,n)
%     % Plotting
%      figure(2);
%      axis equal;
%      grid on;
%      hold on;
%      xlabel('X position');
%      ylabel('Y position');
%      earth = viscircles([0 0],r,'Color',[0 0.4 0]); % The earth
%      for i = 1:1:size(p,2)
%          plot(p(2,:), p(3,:), '.'); % particles current position
%          plot(xtable(i,:),ytable(i,:)); % Particles travel in orbit
%          if p(13,i)~=0&&p(14,i)~=0
%              plot(p(13,i), p(14,i),'X');
%          end
%      end
% end
