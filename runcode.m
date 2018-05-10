% Reset past variables
clear 


% Simulation settings (leap-frog)
t_end = 800; % Simulation seconds
partikel_antal = 25; % Particle quantity

% Particles Data
% p = zeros(10,partikel_antal); % 10 variabler i partiklen, x antal partikler


dt = 1; % Time-step
n = ceil(t_end/dt); % Number of steps simulation has to run

r = 6.378e6; % Orbits radius from earth
G = 6.67e-11; % Graviation constant
M = 5.98e24; % Mass

% Particle Start Parameters 
p = zeros(15,partikel_antal);

for i=1:1:size(p,2)
    id(i) = i;
    tid(i) = i;
    h = randi([200000,400000],1,1); %højde i meter
    inverted = randi([0,1],1,1);
    if(inverted==1) v_0(i) = sqrt(G*M/(r+h));
    else v_0(i) = -sqrt(G*M/(r+h));
    end  
    angle(i) = deg2rad(randi([1 360],1,1));
    x(i) = (r+h)*cos(angle(i));
    y(i) = (r+h)*sin(angle(i));
    v_x(i) = -v_0(i)*sin(angle(i)); % V_x = -(V_0) * sin(vinkel)
    v_y(i) = v_0(i)*cos(angle(i)); % V_y = (V_0) * cos(vinkel)
    rh(i) = r+h;
    GM(i) = G*M;
    objsize(i) = randi([1,15],1,1);
    objm(i) = (10^(2.51*log(objsize(i)*2)+1.93))*10^-3;
    distance(i) = 0;
    collided(i) = 0;
    xColl(i) = 0;
    yColl(i) = 0;
end

% Particle data (p)
%| 1:id | 2:x | 3:y | 4:GM | 5:v_x |6:v_y | 7:vi | 8:rh | 9:v_0 | 10:tid |
%11:objsize % | 12: objmCollision (true/false) | 13: coll X | 14: Coll Y | 15:
%Collision (true/false) |
values = [id;x;y;GM;v_x;v_y;angle;rh;v_0;tid;objsize;objm;collided;xColl;yColl;];
p = values;

% Simulation
[ttable, xtable, ytable,p] = Simulation(n,p,t_end,dt,r);

% not live plotting
%Plotting(p,ttable,xtable,ytable,r);


% Clear variables from workspace
clearvars id dt G v h G M GM tid pv v_x v_y v_0 r rh t x y values inverted angle i n objsize collided distance xColl yColl; 