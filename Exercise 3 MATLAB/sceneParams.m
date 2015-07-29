%% chirp signal parameters
% sampling frequency [2*pi*Hz]
chirp.fs = 50000;
%carrier frequency [2*pi*Hz]
chirp.fc = 12000;
% Bandwidth [2*pi*Hz]
chirp.B = 8000; 
% Chirp pulse duration
chirp.Tp = 0.005;
% Chirp rate
chirp.alpha = chirp.B / (chirp.Tp * 2);                   
% Modified chirp carrier
chirp.beta = chirp.fc - chirp.B / 2;

%% general parameters
% propagation speed in seawater [m/s]
params.c  = 1500;
% simulation noise level
params.SNR_db = 3;
% interelement spacing
params.di = params.c/(2*chirp.fc);

%% sensor parameters
% position of sensor
sensor.x = 0;
sensor.y = 0;

%% scene parameters
% scene boundaries (in meters)
scene.xlim = [20 30];
scene.ylim = [-3 3];
% min and max ranges
% scene.Rmin = sqrt( (scene.xlim(1)-sensor.x)^2 + (scene.ylim(1)-sensor.y)^2); 
scene.Rmax = sqrt( (scene.xlim(2)-sensor.x)^2 + (scene.ylim(2)-sensor.y)^2);  

% horizontal beamwith (in degree)
beam.phi = 10;

%% object parameters
targets.x = [20.1,30,21,28];
targets.y = [-1.04838709677419,0.103686635944702,-3,3]; 
% number of objects
targets.num        = length(targets.x); 
targets.reflection = 0.1;

%% pulse
p = @(t) ( (t > 0 & t < chirp.Tp) .* exp(2*pi*1i * chirp.beta * t + 2*pi*1i * chirp.alpha * t.^2 ));
