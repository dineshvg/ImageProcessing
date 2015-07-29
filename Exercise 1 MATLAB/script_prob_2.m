%% b
mu_T = mean(T)
sig_T = std(T)
mu_N = mean(N)
sig_N = std(N)

%% c
xl=min([T;N]);
xu=max([T;N]);
x=xl:0.02:xu;

%% d
p_x_K = normpdf(x,mu_T,sig_T);
p_x_H = normpdf(x,mu_N,sig_N);

%% e
figure;

hold on
plot(x,p_x_K)
plot(x,p_x_H,'r')
stem(mu_N,max(p_x_H),'r')
stem(mu_T,max(p_x_K))
hold off
legend('p(x|K)', 'p(x|H)');
xlabel('x');
ylabel('p(x|K)/p(x|H)');
text(mu_N,0,'\mu_N'), text(mu_T,0,'\mu_T')

%% f
a = sig_T^2 - sig_N^2;
b = 2*(sig_N^2*mu_T-sig_T^2*mu_N);
c = sig_T^2*mu_N^2 - sig_N^2*mu_T^2 - 2*sig_T^2*sig_N^2*(log(sig_T)-log(sig_N));
X = roots([1,(b/a),(c/a)])
i = find(roots([1,(b/a),(c/a)])>xl);
hold on
stem(X(i),1,'-')
text(X(i),0,'x_0')
hold off

