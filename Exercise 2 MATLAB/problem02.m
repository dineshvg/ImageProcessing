%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Advanced Digital Signal Processing:
% Imaging and Image Processing
%
% Exercise 2: Problem 2
%
% Introduction into MATLAB
%
% group number : 10
% authors      : Harsha, Dinesh, Beenish
%

%% chirp signal parameters: signal p(t)
% sampling frequency [Hz]
chirp.fs = 50000;
%carrier frequency [Hz]
chirp.fc = 12000;
% Bandwidth [Hz]
chirp.B = 8000;
% Chirp pulse duration
chirp.Tp = 0.005;

%% TO DO: complete values

% Chirp rate
chirp.alpha = chirp.B/(2*chirp.Tp);
% Modified chirp carrier
chirp.beta = (chirp.fc)-(chirp.alpha*chirp.Tp);

chirp.alpha = 2*pi*chirp.alpha;
chirp.beta  = 2*pi*chirp.beta;

%% scene parameters [m]
scene.xlim = [20 30];

%% general parameters
% propagation speed in seawater [m/s]
params.c  = 1500;

%% targets (all aligned on x-axis (=sensor axis), you can assume y=0 for simplicity )
targets.x          = [20,30,21,28];  % [m]
targets.num        = length(targets.x);
targets.reflection = 0.1;

%% sensor parameters
% position of sensor
sensor.x = 0;

%% pulse (use p as a function of the time t)
p = @(t) ( (t >= 0 & t < chirp.Tp) .* exp(1i * chirp.beta * t + 1i * chirp.alpha * t.^2 ));
% p is defined as a function handle (a link) to an anonymous function of t.
% You can use p just like a function named p, with input arguments t:
% -> Example:   t = 1:N;
%               signal = p(t);


Tfinal = 3*(scene.xlim(2))/params.c;    % maximally considered signal delay

t = 0:1/chirp.fs:Tfinal;

figure;
subplot(2,1,1);
plot(t, abs(p(t))); xlabel('t [s]'); ylabel('signal envelope |p(t)|');
subplot(2,1,2);
plot(t, phase(p(t))); xlabel('t [s]'); ylabel('signal phase( p(t) )');  % quadratic

numSamples = length(t);
ee = zeros(1,numSamples);
d_n = targets.x - sensor.x;
t_n = 2*d_n/params.c;

%% TO DO: compute received signal, ee, including all target-receiver distances
for tt = 1:targets.num
    ee = ee + ((targets.reflection*p(t-t_n(tt)))/d_n(tt));
end

%% TO DO: convert to baseband (demodulation)
ee = ee .* exp(-1i*2*pi*chirp.fc*t);

figure;
subplot(2,1,1);
plot(t, abs(ee)); xlabel('t [s]'); ylabel('|ee(t)| (in baseband)');

%% TO DO: matched filter (in base band)
h_f = conj(p(Tfinal-t)).*exp(-1i*2*pi*chirp.fc*t);


%% TO DO: filter signal

ss = conv(ee,h_f);
ss = ss(numSamples:end);

subplot(2,1,2);
plot(t, abs(ss)); xlabel('t [s]'); ylabel('|ss(t)| (in baseband)');



%% spatial resolution
dx = 2/chirp.fs * params.c;

x = scene.xlim(1):dx:scene.xlim(2);

Ix = interp1(t*params.c/2, ss, x);

figure;
subplot(2,1,1); scatter(targets.x, zeros(targets.num, 1)); xlabel('range [m]'); ylabel('targets');
subplot(2,1,2); plot(x,abs(Ix)); xlabel('range [m]'); ylabel('detected targets');


