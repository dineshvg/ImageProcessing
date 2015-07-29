%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Advanced Digital Signal Processing:
% Imaging and Image Processing 
%
% Exercise 5: Problem 2
%
% Gibbs' sampling from a MRF using the Ising Model
%
% author(s): Harsha , Dinesh, Beenish
% group: 10

szImage = 1000;
beta    = 0.5;

% reset random number generator 
% (if it does not work, simply comment the code)
% defaultStream = RandStream.getDefaultStream();
% reset(defaultStream);

% TO DO: initialize image
X = zeros(szImage, szImage);
index = randn(szImage,szImage);
X(index>0.5) = 1;
X(index<0.5) = -1;

maxIter = 100;
% maxIter = 1000;

for ii = 1:maxIter
  
  % show current image	
  % show every 10th image, it was taking long time
  if(mod(ii, 10) == 0)
      imagesc(X(2:end-1,2:end-1)); axis image; colormap gray; drawnow;
  end
    
  for xx = 2:szImage-1
    for yy = 2:szImage-1

      % p(x = +1 | X\x)
      U = (X( yy, xx-1) == -1) + ...
          (X( yy, xx+1) == -1) + ...
          (X( yy-1, xx) == -1) + ...
          (X( yy+1, xx) == -1);

      V = (X( yy, xx-1) == 1) + ...
          (X( yy, xx+1) == 1) + ...
          (X( yy-1, xx) == 1) + ...
          (X( yy+1, xx) == 1);
         
     
     pw = beta * (U - V);

     p = 1 / (1 + exp(pw));
     
      if rand(1) < p
        X(yy,xx) = 1; 
      else
        X(yy,xx) = -1;
      end
    end
  end
  
end

