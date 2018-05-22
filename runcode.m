% Reset past variables
clear 

% Plotting settings
live_simulation = true;

% Simulation settings
partikel_antal = 10; % Particle quantity
t_end = 1000; % Simulation seconds
dt = 1; % Time-step
n = ceil(t_end/dt); % Number of steps simulation has to run

r = 6.378e6; % Orbits radius from earth
G = 6.67e-11; % Graviation constant
M = 5.98e24; % The Earths Mass

% Particle Start Parameters 
id = zeros(1,partikel_antal);
position = zeros(3,partikel_antal); % Position: x,y,z
velocity = zeros(3,partikel_antal); % velocity: x,y,z
acceleration = zeros(3,partikel_antal); % acceleration x,y,z
v_0 = zeros(1,partikel_antal); % for velocity calculation
h = randi([201000,201000],1,partikel_antal); % Random height in meters
objSize = randi([1,15],1,partikel_antal); % Random radius size in meters
angle = deg2rad(randi([1 360],1,partikel_antal)); % Random angle from earth
inverted = randi([0,1],1,partikel_antal); % Random inverted direction
objMass = zeros(1,partikel_antal);
collisionCounter = zeros(1,partikel_antal); % Count of collision
collisionPos = ones(3,partikel_antal); % Last collision x,y,z
rh = r+h;
cantCollideTimer = ones(1,partikel_antal);
disabled = zeros(1,partikel_antal);

% Set some of the particle parameters
for i=1:1:partikel_antal
    id(i) = i;
    
    if(inverted(i)==1) 
        v_0(i) = sqrt(G*M/(r+h(i)));
    else
        v_0(i) = -sqrt(G*M/(r+h(i)));
    end  
    
    position(:,i) = [(r+h(i))*cos(angle(i)); (r+h(i))*sin(angle(i)); 0];
    velocity(:,i) = [-v_0(i)*sin(angle(i)); v_0(i)*cos(angle(i)); 0];
    objMass(i) = (10^(2.51*log(objSize(i)*2)+1.93))*10^-3;
end


clear inverted h angle;

% Particle data (p)
%| 1: id | 2: x | 3: y | 4: z | 5: vel x |6: vel y | 7: vel z | 8:
%acceleration x | 9: acceleration y | 10: acceleration z | 11: v_0 | 12:
%objSize | 13: objMass | 14: cantCollideTimer | 15: disabled |

values = [id;position;velocity;acceleration;v_0;objSize;objMass;cantCollideTimer;disabled;];
p = values;
clear id position velocity v_0 objSize objMass kineticEnergy collisionCounter collisionPos time rh values nocollisionsplz;

% Simulation
[ttable, xtable, ytable,p] = Simulation(live_simulation,p,n,dt,r,G,M);
clear live_simulation n dt r G M;

% Clear variables from workspace
clear i;
%clear;