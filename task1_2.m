close all
%reading in data
A = xlsread('data_1.xls');
t = A(:,1); %s
V = A(:,2); %V
h_1 = A(:,3); %cm
h_2 = A(:,4);  %cm
%%
%zeroing data 
step = find(V>0,1,'first'); %
h0_1 = 1.615; % from curve fit of a-b*exp(-c*x)
h_1 = h_1 - h0_1;
h0_2 = 0.127; % from curve fit of a-b*exp(-c*x)
h_2 = h_2-h0_2; 

pos = find(h_1>0,1);
figure(1)
hold on
plot(t(pos:end)-15,h_1(pos:end))
figure(2)
hold on
plot(t(pos:end)-15,h_2(pos:end))
V(1:step-1) = []; h_1(1:step-1) =[];h_2(1:step-1)=[]; t(1:step-1)=[]; t = t-t(1);

%% task 1
% from curve fit
a = 0.0148; 
k = 0.07412; 
t_fit = 0:0.01:t(end);
fit1 = @(t)(k/a-k/a*exp(-a*t));
h1_fit = fit1(t_fit);
figure(1)
plot(t_fit,h1_fit)
xlabel('Time (s)')
ylabel('Water height (cm)')
xlim([-15,t(end)])
ylim([-0.3,6])

h1 = k/a*1E-2; %m
q = 6.96E-6;
R1 = h1/q;

% A calc
h63 = 0.63*h1*1E2; %cm
i = find(abs(h1_fit -h63) < 1E-3);
t63 = mean(t_fit(i));
A1 = t63/R1;

plot(t63,h63,'ok','MarkerSize',5, 'MarkerFaceColor','k')
legend('h_1 (zeroed)','Fitted curve','Location','SouthEast')


text(t63,h63,'h_6_3_%= 3.16 cm', 'FontSize', 8)
text(t63,h63,'t_6_3_%= 67.2 s', 'FontSize', 8)


%% task 2 
figure(2)
b = 60.84;
c = 0.2084; 
fit2 = @(x)(c*(1+(67.18*exp(-x/67.18)-b*exp(-x/b))/(b-67.18)));
h2_fit = fit2(t_fit)*100;
plot(t_fit,h2_fit)
xlim([-15,t(end)])
ylim([-1,25])
xlabel('Time (s)')
ylabel('Water height (cm)')
legend('h_2 (zeroed)','Fitted curve','Location','SouthEast')

R2 = c/q; 
A2 = b/R2; 