%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Advanced Digital Signal Processing:
% Imaging and Image Processing 
%
% Exercise 4: Problem 1
%
% Backprojection 
%
% group number : 10
% authors      : Harsha, Dinesh, Beenish
%

% first load parameters
sceneParams();

% and then scene including updated parameters
load scene

%% TO DO: spatial grid
ds = params.c/(chirp.fs);

% vectors in x and y range
x = scene.xlim(1):ds:scene.xlim(2);
y = scene.ylim(1):ds:scene.ylim(2);

[X Y] = meshgrid(x,y);

% fast time vector
Tfinal = 3*(scene.Rmax)/params.c;
t = 0:1/chirp.fs:Tfinal;

% compute number of pings
numPings = size(ss, 1);

Ixy = zeros(length(y), length(x));

for ii=1:numPings 
  
  %% TO DO: compute distances to the sensors dx and dy for all possible (discrete) positions 
  DX = X - sensor.x;
  DY = Y - sensor.u(ii);
  
  %% TO DO: compute the time delay for all possible positions
  td = 2*sqrt(DX.^2+DY.^2)/params.c;
     
  % identify elements out of range
  ind_invalid = (td > max(t) );
      
  % use linear interpolation 
  Sxy = interp1(t, ss(ii,:), td);
   
  Sxy(ind_invalid) = 0;
   
  %% TO DO: combine signal components from individual receivers
  Ixy = Ixy + Sxy.*exp(1i*2*pi*chirp.fc*td);
end

figure, imagesc(x, y, abs(Ixy));
axis xy; axis image;
xlim(scene.xlim); ylim(scene.ylim);
xlabel('range [m]'), ylabel('cross range [m]');
title('reconstructed image');

figure, scatter(targets.x, targets.y);
axis xy; axis image;
xlim(scene.xlim); ylim(scene.ylim);
xlabel('range [m]'); ylabel('cross range [m]');
title('scene');
