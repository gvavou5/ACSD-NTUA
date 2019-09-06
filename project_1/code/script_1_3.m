%% PID CONTROLLER - SSAE - ERGASTHRIAKH ASKHSH 1
%% Vavouliotis Giorgos - 03112083

clear all; close all; clc;

%% Do the Computations and show the plots for PID controller

mkdir PID_Results;

% dosmena apo ekfwnhsh askhshs
K     = 2.718*(10^9);
val1  = 1; val2 = 3008; val3 = 400.26;

j = 0; bound = 15*11*10*11*2*11;

for K_p = 0:0.1:15
        for K_i = 0:0.1:10
            for K_d = 0:0.1:2
                % i dont explain again. The work down here is similar
                % to work that i have exlained in script_1_1 and script_1_2 
                %i   = i+1;
                lu1 = K*K_d; lu2 = K*K_p; lu3 = K*K_i;
                du1 = lu1+400.26*3008; du2 = lu2; du3 = lu3;
                % tf ==> Create transfer function model, convert to transfer function model
                hs  = tf([lu1 lu2 lu3], [val1 val2 val3 du1 du2 du3]);
                H_s = stepinfo(hs);       
                % check if array elements that are NaN
                if ( isnan(H_s.Overshoot) )    continue; end
                % check the limitis of overshoot, risetime, settlingtime
                if ( H_s.Overshoot > 5)        continue; end
                if ( H_s.RiseTime  > 0.005 )   continue; end
                if ( H_s.SettlingTime > 0.005) continue; end
                j = j+1;
                % store the accepted
                accepted(j,:) = [K_p K_i K_d];
            end
        end
end


% then for every K_p K_i K_d do the same job as the trevious questions to see
% the result . Just delete the %{ , %}

%{

indx1 = 4500*K_d; indx2 = 4500*K_p; indx3 = 4500*K_i
smp1  = 1;
smp2  = 361.2+indx1; 
smp3  = indx2;

hs = tf([indx1 indx2], [smp1 smp2 smp3]);
figure(1);
stepplot(hs);    % Step response plot of dynamic system.
stepinfo(hs)     % See the Rise time, settling time, and other step response characteristics in command window

time = linspace(0,0.2,1600);
heavisideval = heaviside(time);
Res  = time.*heavisideval; % use the heaviside function to take the right result
figure(2);
plot(time,Res);

Outval = lsim(hs,Res,time);

%% Show the plot and print them in the right directory
plotval = Outval'-Res ;
plot(time, abs(plotval));

%}
