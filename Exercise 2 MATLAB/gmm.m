function samples = gmm(eps, mu1, mu2, sig1, sig2, N)
% creates samples from a Gaussian mixture
%
% eps:          contamination factor
% mu1, sig1:    mean and standard deviation of first Gaussian
% mu2, sig2:    mean and standard deviation of second Gaussian
% N:            number of samples


% Problem 1, a)
%
% TODO:
%
% ...
%
% samples =

samples = zeros(N,1);
a=rand(N,1); % generating N random numbers within [0,1]
b_less = find(a<eps); % b_less takes all the indices 'i' of vector 'a' for which a(i) < eps
b_more = find(a>=eps); % b_more takes all the indices 'i' of vector 'a' for which a(i) >= eps
N1=length(b_less);
N2=length(b_more);

% creating a Gaussian mixture model of N samples
samples(b_less)=mu2+sig2*randn(N1,1);
samples(b_more)=mu1+sig1*randn(N2,1);


end


