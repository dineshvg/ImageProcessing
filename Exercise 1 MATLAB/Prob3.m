
%% a
load data.mat;
script_prob_2();
D = xl:0.02:xu;
a_d = 1-normcdf(D,mu_N,sig_N);
p_d = 1-normcdf(D,mu_T,sig_T);
figure(10)
subplot(2,1,1)
plot(a_d,p_d)
title('ROC');
xlabel('Probability of false alarm, \alpha(\delta)');
ylabel('Probability of correct detection, p_d(\delta)');

clear variables
%% b
load data2.mat
script_prob_2();
D = xl:0.02:xu;
a_d = 1-normcdf(D,mu_N,sig_N);
p_d = 1-normcdf(D,mu_T,sig_T);
figure(10)
subplot(2,1,2)
plot(a_d,p_d)
title('ROC');
xlabel('Probability of false alarm, \alpha(\delta)');
ylabel('Probability of correct detection, p_d(\delta)');