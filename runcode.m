% Reset past variables
clear 

% Plotting settings
live_simulation = false;

% Simulation settings
start_partikel_antal = 16; % Particle quantity
t_end = 1500; % Simulation seconds
dt = 1; % Time-step 
n = ceil(t_end/dt); % Number of steps simulation has to run

r = 6.378e6; % Orbits radius from earth
G = 6.67e-11; % Graviation constant
M = 5.98e24; % The Earths Mass


% Random seed
rng(0);

% Particle Start Parameters 
id = zeros(1,start_partikel_antal);
position = zeros(3,start_partikel_antal); % Position: x,y,z
velocity = zeros(3,start_partikel_antal); % velocity: x,y,z
acceleration = zeros(3,start_partikel_antal); % acceleration x,y,z
v_0 = zeros(1,start_partikel_antal); % for velocity calculation
simHeight = [200000;201000];
h = randi([simHeight(1),simHeight(2)],1,start_partikel_antal); % Random height in meters
objSize = randi([1,15],1,start_partikel_antal); % Random radius size in meters
angle = deg2rad(randi([1 360],1,start_partikel_antal)); % Random angle from earth
inverted = randi([0,1],1,start_partikel_antal); % Random inverted direction
objMass = zeros(1,start_partikel_antal);
collisionCounter = zeros(1,start_partikel_antal); % Count of collision
collisionPos = ones(3,start_partikel_antal); % Last collision x,y,z
rh = r+h;
cantCollideTimer = ones(1,start_partikel_antal);
inactiveEarth = zeros(1,start_partikel_antal);
inactiveSpace = zeros(1,start_partikel_antal);

% Set some of the particle parameters
for i=1:1:start_partikel_antal
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

values = [id;position;velocity;acceleration;v_0;objSize;objMass;cantCollideTimer;inactiveEarth;inactiveSpace;rh];
p = values;
clear id position acceleration velocity v_0 objSize objMass kineticEnergy collisionCounter collisionPos cantCollideTimer inactiveEarth inactiveSpace time rh values;

% Saving the Startparameters
pStart = p;

% Simulation
[xtable, ytable,p] = Simulation(live_simulation,p,n,dt,r,G,M,simHeight,start_partikel_antal);
clear live_simulation n dt r G M simHeight;

% Clear variables from workspace
clear i ;
%clear;