% Reset past variables
clear 

% Simulation settings (leap-frog)
t_end = 600; % Simulation seconds
partikel_antal = 50; % Particle quantity

% Particles Data
p = zeros(10,partikel_antal); % 10 variabler i partiklen, x antal partikler


dt = 10; % Time-step
n = ceil(t_end/dt); % Number of steps simulation has to run

r = 6.378e6; % Orbits radius from earth
G = 6.67e-11; % Graviation constant
M = 5.98e24; % Mass


for i=1:1:size(p,2)
    inverted = randi([0,1],1,1);
    h = randi([250000,2000000],1,1);
    id(i) = i;
    vi(i) = deg2rad(randi([1 360],1,1));
    x(i) = 0;
    y(i) = 0;
    tid(i) = i;
    x_0(i) = (r+h)*cos(vi(i));
    y_0(i) = (r+h)*sin(vi(i));
    rh(i) = r+h;
    if(inverted==1)
        v_0(i) = sqrt(G*M/(r+h));
    else
        v_0(i) = -sqrt(G*M/(r+h));
    end    
    GM(i) = G*M;
end

%| 1:id | 2:x | 3:y | 4:GM | 5:x_0 |6:y_0 | 7:vi | 8:rh | 9:v_0 | 10:tid |
values = [id;x;y;GM;x_0;y_0;vi;rh;v_0;tid;];
p = values;



% LeapFrog Orbit Function
[ttable, xtable, ytable,p] = LeapFrogOrbit(n,p,t_end,dt);

% plotting
figure(1);
plot(ttable(i,:),xtable(i,:));
hold on
plot(ttable(i,:),ytable(i,:));

figure(2);
axis equal;
grid on;
hold on;
xlabel('X position');
ylabel('Y position');
earth = viscircles([0 0],r,'Color',[0 0.4 0]); % The earth
%earth.LineWidth = 1;
%earth.Color = 'black';
for i = 1:1:size(p,2)
    plot(p(2,:), p(3,:), "."); % particles current position
    plot(xtable(i,:),ytable(i,:)); % Particles travel in orbit
end




% Clear variables from workspace
clearvars id dt G v h G M GM tid pv x_0 y_0 v_0 r rh t x y values inverted vi i n; 