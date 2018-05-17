R1 = 7.1956E3; 
R2 = 2.9943E4;
A1 = 9.3363E-3; 
A2 = 2.0319E-3; 
qs = 7.2E-5;
h0 = 0.06; 

t = 0:0.01:1000; 

h2 = qs*R2/(A1*R1-A2*R2)*(exp(-t/(A1*R1))-exp(-t/(A2*R2)))+h0;

plot(t,h2*100)
ylim([0.0595*100,0.074*100])
xlabel('Time (s)')
ylabel('Water height (cm)')