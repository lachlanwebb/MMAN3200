%parameters
R1 = 7.1956E3; 
R2 = 2.9943E4;
A1 = 9.3363E-3; 
A2 = 2.0319E-3; 
qi = 6.96E-6;

s = tf('s');
cLoop = R2/( (s^2)*(A1*A2*R1*R2) + s*(A1*R1 + A1*R2 + A2*R2) + 1);
rlocus(cLoop);
