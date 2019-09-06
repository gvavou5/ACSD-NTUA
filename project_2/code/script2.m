% Vavouliotis Giorgos (03112083)
% Exercise 2 - SSAE 2016 
clc; clear all; close all;

%% A
% take the given parameteres manually 
A  = [0,1,0,0;20.6,0,0,0;0,0,0,1;-0.5,0,0,0];
B  = [0;-1;0;0.5];
C  = [1,0,0,0;0,0,1,0];
D  = [0;0];
z  = 0.5;
wn = 4;

MySim1 
% see the report for explanations 
ControlArray = [B A*B A^2*B A^3*B];
Controldet = Controldet(ControlArray);
% check system's Controllability
if (Controldet ~= 0 ) display('The System is Controllable')
else display('The System is Uncontrollable') end
% take the PoleArray 
p1r = -z*wn;
p2r = p1r;
p1i =  round(wn*sqrt(1-z^2),3);
p2i =  round(-wn*sqrt(1-z^2),3);
%place the PoleArray at -100 and -200
PoleArray = [p1r+1i*p1i, p2r+1i*p2i, -100, -200];
% find the right K 
K=place(A,B,PoleArray);
% Run simulation 
MySim2
sim('MySim2');

figure()
plot(time,x(:,1))

figure()
plot(time,x(:,2))

figure()
plot(time,x(:,3))

figure()
plot(time,x(:,4))


%% B
% see the report for explanations
Q = ones(4,4);
R = 1;
[K_new,S,E] = lqr(A,B,Q,R);
%Run simulation
MySim2  
sim('MySim2');

figure()
plot(time,x(:,1))

figure()
plot(time,x(:,2))

figure()
plot(time,x(:,3))

figure()
plot(time,x(:,4))


%% C 
%Run simulation 
MySim3  
sim('MySim3');

figure()
plot(time,x(:,1))

figure()
plot(time,x(:,2))

figure()
plot(time,x(:,3))

figure()
plot(time,x(:,4))

%% D 
%see report for exlanations
ObArray = [C;C*A;C*A^2;C*A^3];
check = length(A)-rank(ObArray);
if (check == 0 ) display('System Observable ')
else display('System not Observable') end
Kn = place(A',C',PoleArray)';
MySim4
sim('MySim4');

figure()
plot(time,x(:,1))

figure()
plot(time,x(:,2))

figure()
plot(time,x(:,3))

figure()
plot(time,x(:,4))

Q = ones(4,4); R = 1;
[K_new,S,E] = lqr(A,B,Q,R); K = K_new;
MySim4
sim('MySim4');

figure()
plot(time,x(:,1))

figure()
plot(time,x(:,2))

figure()
plot(time,x(:,3))

figure()
plot(time,x(:,4))

%% E 
% renew the parameters
A=[0,1,0,0;20.9,0,0,0;0,0,0,1;-0.8,0,0,0];
B=[0;-1;0;0.5];
C=[1,0,0,0;0,0,1,0];
D=[0;0];
z = 0.5;
wn = 4;

ControlArray = [B A*B A^2*B A^3*B];
Controldet = Controldet(ControlArray);

if (Controldet ~= 0 ) display('The System is Controllable')
else display('The System is Uncontrollable') end

p1r = -z*wn;
p1i   =  round(wn*sqrt(1-z^2),3);
p2r =  -z*wn;
p2i   =  round(-wn*sqrt(1-z^2),3);

PoleArray=[p1r+1i*p1i,p2r+1i*p2i,-100,-200];
K = place(A,B,PoleArray);

MySim2
sim('MySim2');

figure()
plot(time,x(:,1))

figure()
plot(time,x(:,2))

figure()
plot(time,x(:,3))

figure()
plot(time,x(:,4))

