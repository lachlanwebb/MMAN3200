close all
%reading in data
A = xlsread('data_2.xls');
t = A(:,1); %s
V = A(:,2); %V
h_d = A(:,3); %cm
h_2 = A(:,4); %cm

%parameters
R1 = 7.1956E3; 
R2 = 2.9943E4;
A1 = 9.3363E-3; 
A2 = 2.0319E-3; 
qi = 6.96E-6;

%zeroing data
h0 = -1.6; 
h_2 = h_2-h0; 
%plotting 
hold on
pos = find(h_2>0,1);
plot(t(pos:end)-15,h_2(pos:end))
plot(t(pos:end)-15,h_d(pos:end)) 
xlabel('Time (s)')
ylabel('Water height (cm)')
legend('h_2 (zeroed)','h_2_,_d_e_s_i_r_e_d','Location','SouthEast')
xlim([-15,t(end)])
ylim([-0.5,22])

%stage 0
stage0 = 1:151; 
V(stage0) =[];h_2(stage0) =[];h_d(stage0)=[]; t(stage0)=[]; t = t-t(1);

%stage 1
figure
hold on
t_s1 = t(1:3001);
h2_s1 = h_2(1:3001);
hd_s1 = h_d(1:3001); 
plot(t_s1,h2_s1)
plot(t_s1,hd_s1)
i = 1097;
t_ss = t(i:3001)-t(i);
h_ss = h_2(i:3001)-h_2(i);


% filter
% moving average filter
freq = 10; %Hz
num = 1000*freq;
coeff = ones(1, num)/num;
h_filt = filter(coeff,1,h_ss);
fDelay = (length(coeff)-1)/2;
t_delay = t_ss-fDelay/num; 

plot(t_delay+t(i),h_filt+h_2(i),'--k')
hd = 0.17; 
hss = median(h_filt+h_2(i))/100; 
K = hss/(R2*(hd-hss));
E = hd/(1+R2*K); 
xlim([0,t_s1(end)])
ylim([0.5,22])
xlabel('Time (s)')
ylabel('Water height (cm)')
legend('h_2','h_2_,_d_e_s_i_r_e_d','(h_2)_s_s','Location','SouthEast')