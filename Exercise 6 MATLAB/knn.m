function pred = knn(testData, trainData, trainLabels, K)
% Input arguments
% testData:  p x d, trainData to classify 
% trainData:   q x d, labeled reference trainData
% trainLabels: q x 1 in [0, L-1], class trainLabels
% K: number of nearest neighbors
%
% Output:
% pred:   p x 1, predicted trainLabels

trainLabels = trainLabels+1;

numTest  = size(testData,1);
numTrain = size(trainData,1);
numClasses = max(trainLabels);

pred = zeros(numTest,1);

for ii = 1:numTest
  
  % compute distance to each training trainData 

  % find (indices of) minimum distances

  % get respective trainLabels

  % count class occurrences in K-neighborhood
  
  % find most occurrences within this neighborhood

end

pred = pred - 1;