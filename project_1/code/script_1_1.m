%% PD CONTROLLER - SSAE - ERGASTHRIAKH ASKHSH 1 
%% Vavouliotis Giorgos - 03112083

clear all; close all; clc;

%% Do the Computations and show the plots for PD controller

mkdir PD_Results;

Kp   = 200;    % gain
Kd   = 0.46;   % gain

% Sunarthsh Metaforas Dosmenou Susthmatos
% (4500kp+4500kd*s)/(s^2 + (361.2+4500kd)*s + 4500kp)
indx1 = 4500*Kd; indx2 = 4500*Kp;
smp1  = 1;
smp2  = 361.2+indx1; 
smp3  = indx2;

% i use tf ==> Create transfer function model, convert to transfer function model
hs = tf([indx1 indx2], [smp1 smp2 smp3]);
figure(1);
stepplot(hs);    % Step response plot of dynamic system.
stepinfo(hs)     % See the Rise time, settling time, and other step response characteristics in command window
cd  PD_Results;
title('Step Response');
print -djpeg Step_Response_Result.jpg;
cd ../

time = linspace(0,0.2,1600);
heavisideval = heaviside(time);
Res  = time.*heavisideval; % use the heaviside function to take the right result
figure(2);
cd  PD_Results;
plot(time,Res);
title('Ramp');
xlabel('Time(s)');
print -djpeg Ramp.jpg;
cd ../
% i use lsim ==> Simulate time response of dynamic system to arbitrary inputs
Outval = lsim(hs,Res,time);

%% Show the plot and print them in the right directory
figure(3);
plotval = Outval'-Res ;
plot(time, abs(plotval));
cd  PD_Results;
title('Ramp Error');
xlabel('Time(s)');
print -djpeg Error.jpg;
cd ../
