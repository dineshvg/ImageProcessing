%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Advanced Digital Signal Processing:
% Imaging and Image Processing 
%
% Exercise 2: Problem 1
%
% Introduction into MATLAB 
%
% group number : 10
% authors      :Harsha, Dinesh, Beenish
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% b)
eps = [0.1, 0.2, 0.3];
mu1 = 0; sig1 = 1;
mu2 = 2.5; sig2 = 3;
N1=10; N2=1000; N3=100000;
N = length(eps);
sam1 = zeros(N,N1); sam2 = zeros(N,N2); sam3 = zeros(N,N3);

for i=1:N
    
    sam1(i,:)=gmm(eps(i), mu1, mu2, sig1, sig2, N1);
    sam2(i,:)=gmm(eps(i), mu1, mu2, sig1, sig2, N2);
    sam3(i,:)=gmm(eps(i), mu1, mu2, sig1, sig2, N3);
    eps(i)
    % c)
    figure;
    subplot(2,2,1);
    hist(sam1(i,:));
    title('N=10');
    subplot(2,2,2);
    hist(sam2(i,:));
    title('N=1000');
    subplot(2,2,3);
    hist(sam3(i,:));
    title('N=100000');

    %d)
    m1_sme(i) = mean(sam1(i,:));
    m2_sme(i) = mean(sam2(i,:));
    m3_sme(i) = mean(sam3(i,:));

    %e)
    m1_median(i) = median(sam1(i,:));
    m2_median(i) = median(sam2(i,:));
    m3_median(i) = median(sam3(i,:));
end

disp(m1_sme)
disp(m2_sme)
disp(m3_sme)

%g)`
clear;
eps1=0.1;
mu1=0; sig1=1;
mu2=2.5; sig2=3;
N1 = 10;
N = 100;
theta_cap_sme = zeros(N,1);
theta_cap_med = zeros(N,1);

for i=1:N
    exp = gmm(eps1, mu1, mu2, sig1, sig2, N1);
    theta_cap_sme(i) = mean(exp);
    theta_cap_med(i) = median(exp);
end
bias_sme = mean(theta_cap_sme) - mu1
bias_med = mean(theta_cap_med) - mu1
var_theta_cap_sme = mean(theta_cap_sme.^2) - mu1^2
var_theta_cap_med = mean(theta_cap_med.^2) - mu1^2
mse_sme = var_theta_cap_sme + bias_sme^2
mse_med = var_theta_cap_med + bias_med^2

