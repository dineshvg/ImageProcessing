%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Advanced Digital Signal Processing:
% Imaging and Image Processing 
%
% Exercise 5: Problem 1
%
% Gibbs sampling from a multivariate Gaussian distribution
%
% author(s): Harsha, Dinesh, Beenish
% group: 10


Sigma = [1 0; 0 1];
% Sigma = [1 0.7; 0.7 1];
% Sigma = [1 0.9; 0.9 1];
mu = [2 1];

Lambda = inv(Sigma);
x1 = 0;
x2 = 0;

nSamples = 100;
x = zeros(nSamples,2);

% TO DO: sampling
for kk = 1:nSamples   
  x1 =  (mu(1)-((Lambda(1,2)/Lambda(1,1))*(x2-mu(2))))+sqrt(Lambda(1,1)^-1)*randn(1);
  x2 =  (mu(2)-((Lambda(1,2)/Lambda(2,2))*(x1-mu(1))))+sqrt(Lambda(2,2)^-1)*randn(1);
  x(kk,: ) = [x1 x2]; 
end

% plotting
figure;

% TO DO: plot drawn samples
scatter(x(:,1),x(:,2))
hold('on');

x1lin =  linspace(min(x(:,1)), max(x(:,1)), 100);
x2lin =  linspace(min(x(:,2)), max(x(:,2)), 100);
[X Y] = meshgrid(x1lin, x2lin);

% TO DO: use X Y to create a contour plot of the Gaussian
p = mvnpdf([X(:) Y(:)],mu,Sigma);
p = reshape(p,size(X));
contour(X,Y,p);
print('-dpng', '-r300', '1001.png');
axis equal


