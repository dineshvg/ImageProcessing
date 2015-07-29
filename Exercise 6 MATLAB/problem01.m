%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Advanced Digital Signal Processing:
% Imaging and Image Processing 
%
% Exercise 6: Problem 1
%
% k-means
%
% Group 10 
% author(s): Harsha, Dinesh, Beenish
% 

load ('data.mat');
figure;
imagesc(Y);
N= numel(Y(:));
F=Y(:);
C1=quantile(F,.3);
C2=quantile(F,.6);
for i=1:10
	d1 = pdist2(F,C1);
	d2 = pdist2(F,C2);
	r_nk=zeros(N,2);
	r_nk((d2<d1),2)=1;
	r_nk((d2>d1),1)=1;
	C1=sum((r_nk(:,1).*F))/sum(r_nk(:,1));
	C2=sum((r_nk(:,2).*F))/sum(r_nk(:,2));
end
xest = reshape(r_nk(:,1), size(Y));

figure;
imagesc(xest);


