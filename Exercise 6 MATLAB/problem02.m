%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Advanced Digital Signal Processing:
% Imaging and Image Processing
%
% Exercise 6: Problem 2
%
% Iterated Conditional Modes (ICM)
%Group 10
% author(s): Harsha, Dinesh, Beenish
%

% load the data
load 'data.mat';

neighborhood = [0 1; 1 0; 0 -1; -1 0];

% target and background labels
Tlabel = 1;
Blabel = 0;

maxIter = 20;

% neighborhood parameter
beta = 1;

Xhat = zeros(size(Y));

%% TO DO: init Xhat
Xhat(Y>.5)=1;
figure;
subplot 211; imagesc(Y);
subplot 212; imagesc(Xhat);  title('initilized image'); drawnow;

for iter = 1:maxIter
    
    X = Xhat;
    t = find(X == 1);
    b = find(X == 0);
    
    % estimate parameters of distribution
    ray_est_t = raylfit(Y(t(:)));
    ray_est_b = raylfit(Y(b(:)));
    
    for xx = 2:size(Y, 2)-1
        for yy = 2:size(Y, 1)-1
            
            % estimate log likelihoods
            llh_t = log(raylpdf(Y(yy,xx),ray_est_t));
            llh_b = log(raylpdf(Y(yy,xx),ray_est_b));
            
            
            % estimate log prior
            lp_t = 0;
            lp_b = 0;
            
            for nn = 1:size(neighborhood, 1)
                a=neighborhood(nn,:)+[yy,xx];
                if(X(a(1),a(2))==1)
                    lp_t=lp_t+1 ;
                else
                    lp_b=lp_b+1;
                end
                
                % log posterior
                % Since we are taking log,multiplication becomes addition
                lpp_t = llh_t+beta*lp_t;
                lpp_b = llh_b+beta*lp_b;
                
                if (lpp_t > lpp_b)
                    Xhat(yy,xx) = Tlabel;
                else
                    Xhat(yy,xx) = Blabel;
                end
            end
        end
    end
    
    fprintf('changes: %d\n', sum(X(:) ~= Xhat(:)));
end

figure;
imagesc(Xhat); title('final estimate X');

