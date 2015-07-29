%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Advanced Digital Signal Processing:
% Imaging and Image Processing
%
% Exercise 3: Problem 1
%
% Generating the scene
%
% group number : 10
% authors      : Harsha , Dinesh, Beenish
%

%% all parameters are defined in this script:
sceneParams();

%% TO DO: compute starting point y_s
sensor.ystart = scene.ylim(2) + scene.xlim(2)*tan((pi/180)*(beam.phi/2));
sensor.yend   = scene.ylim(1) - scene.xlim(2)*tan((pi/180)*(beam.phi/2));

%% TO DO: compute number of pings given the interelement spacing (params.di)
sensor.u = sensor.ystart:-params.di:sensor.yend;
numPings = floor(((sensor.ystart-sensor.yend)/params.di)+1);
%isNumPingsCorrect = (numPings == length(sensor.u))

Tfinal = 3*(scene.Rmax)/params.c;

% time
t = 0:1/chirp.fs:Tfinal;

% number of fast-time samples
numSamples = length(t);

ee = zeros(numPings, numSamples);
ss = zeros(numPings, numSamples);

for ii=1:numPings
    for jj=1:targets.num
        %% TO DO: compute the distance between target and sensor position
        dx = targets.x(jj) - sensor.x;
        dy = targets.y(jj) - sensor.u(ii);
        
        dist = sqrt (dx^2 + dy^2);
        t_ldn = 2*dist/params.c;
        % angle between elements and targets
        theta = atan2(dy, dx);
        
        % make sure the signal is in bounds (rectangular beam pattern)
        if (abs(theta) <= beam.phi/180*pi)
            %% TO DO: compute the reflected signal
            
            ee(ii,:) = ee(ii,:) + ((targets.reflection*p(t-t_ldn)))/dist;
        end
    end
end

%% TO DO: simulation noise
Ps = (sum((abs(ee(:))).^2))/(numPings * Tfinal);
Pn = Ps / (10^(params.SNR_db/10));
noise_var = Pn/2;

nRe = sqrt(noise_var*(numPings * Tfinal) / numel(ee))*randn(numPings,numSamples);
nIm = sqrt(noise_var*(numPings * Tfinal) / numel(ee))*randn(numPings,numSamples);

ee = ee + (nRe + 1i*nIm);

%% TO DO: baseband conversion (demodulation step)
for ii=1:numPings
    ee(ii,:) = ee(ii,:) .* exp(-1i*2*pi*chirp.fc*t);
end
figure;
subplot(2,1,1);
plot(t, abs(ee)); xlabel('t [s]'); ylabel('|ee(t)| (in baseband)');

%% TO DO: Pulse compression
h_f = conj(p(Tfinal-t)).*exp(-1i*2*pi*chirp.fc*t);
for ii=1:numPings
    x=conv(ee(ii,:),h_f);
    ss(ii,:) = x(1,numSamples:end);
end
subplot(2,1,2);
plot(t, abs(ss)); xlabel('t [s]'); ylabel('|ss(t)| (in baseband)');
% print('-dpng', '-r300', 'fig1.png')


figure;
imagesc(t, sensor.u, abs(ss)); title('ss'); axis xy; xlabel('t in s'); ylabel('u in m');
% print('-dpng', '-r300', 'fig2.png')

figure;
imagesc(t, sensor.u, abs(ee)); title('ee'); axis xy; xlabel('t in s'); ylabel('u in m');
% print('-dpng', '-r300', 'fig3.png')

save('scene', 'ss', 'sensor');

