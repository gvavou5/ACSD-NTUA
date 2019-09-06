%% PI CONTROLLER - SSAE - ERGASTHRIAKH ASKHSH 1 
%% Vavouliotis Giorgos - 03112083

clear all; close all; clc;

%% Do the Computations and show the plots for PI controller

mkdir PI_Results;

% these are the best pair of parameters that i can choose. The settling
% time can't be reduce any more without damage the overshoot and the rise
% time. Only if i have a pid controller i could reduce the settling time by
% decreasing the Kd parameter.
Kp   = 14.5;    % gain
Ki   = 10;      % gain
% ***** Sunarthsh Metaforas *****
indx1 = 4500*Kp; indx2 = 4500*Ki;
smp1  = 1; 
smp2  = 361.2; 
smp3  = indx1;
smp4  = indx2;
% i use tf ==> Create transfer function model, convert to transfer function model
% create the plot of hs 
hs = tf([indx1 indx2], [smp1 smp2 smp3 smp4]);
figure(1);
step(hs);    % Step response plot of dynamic system.
stepinfo(hs) % See the Rise time, settling time, and other step response characteristics in command window
cd  PI_Results;
title('Step Response');
print -djpeg Step_Response_Result.jpg;
cd ../
time = linspace(0,20,100000); % i will use time as input for my simulation.
Res  = ((time.^2)./2).*heaviside(time); % use the heaviside function to take the right result
% i use lsim ==> Simulate time response of dynamic system to arbitrary inputs
figure(2);
cd  PI_Results;
plot(time,Res);
title('Parabolic');
xlabel('Time(s)');
print -djpeg Parabolic.jpg;
cd ../
OutVal  = lsim(hs,Res,time);
% Show the plot and print them in the right directory
plotval = OutVal'-Res;
figure(3); 
plot(time, abs(plotval));
title('Parabolic Error');
xlabel('Time(s)');
cd  PI_Results;
print -djpeg Error.jpg;
cd ../


