%% a
t=0:0.1:20;
N=length(t)

%% b
y=zeros(1,N);

%% c
for i=1:N
    y(i)=cos(2*pi*t(i));
end
figure;
subplot(2,1,1)
plot(t,y)
xlabel('t');
ylabel(' y=cos(2\pit)');
title('Computed using for loop');

min(y)
max(y)

%% e
y=cos(2*pi*t);
subplot(2,1,2)
plot(t,y);
xlabel('t');
ylabel(' y=cos(2\pit)');
title('Computed without using loop');

%% f
t=0:0.1:10000;
N=length(t);
y=zeros(1,N);
tic;
for i=1:N
    y(i)=cos(2*pi*t(i));
end
toc;
tic;
y=cos(2*pi*t);
toc;

