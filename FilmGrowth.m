% Simulation of Film Growth by Kinect Monte Carlo Method
% Using Periodic Boundary Conditions
% Jingshan Du, Zhejiang University, dujingshan@zju.edu.cn
clc
clear
global Position Potential T k MeshNum;
% Parameters
maxStep = 7000;

MeshNum = 100;
alpha = 2;
cutoff = 4;
DistanceOfEquilibrium = 1;  % of two atoms
E0 = 0.2;   % Equilibrium Energy
Estep = 10; % The kinect energy of disposed atoms (by steps)
Esup = -10; % Energy due to the support
StepToSave = [100 400 700 1000 4000 7000];savei=1;

T = 300;    % Kelvin
k = 8.617e-5;   % k/e (J->eV)

% Variables
Position = zeros(MeshNum,MeshNum);   % 1=blank, 0=deposited
Potential = Esup*ones(MeshNum,MeshNum);

r0 = DistanceOfEquilibrium;
% Calculate the matrix of limited-area potential
FP = @(r) E0*(exp(-2*alpha*(r/r0-1))-2*exp(-alpha*(r/r0-1)));
LAp = zeros(2*cutoff+1);
for cx = 1:(2*cutoff+1)
    for cy = 1:(2*cutoff+1)
        LAp(cx,cy) = FP(sqrt((cx-cutoff-1)^2+(cy-cutoff-1)^2));
    end
end
LAp(cutoff+1,cutoff+1) = 0;
% [LAp(3,1) LAp(3,5) LAp(1,3) LAp(5,3)] = deal(FP(2));
% [LAp(3,2) LAp(3,4) LAp(2,3) LAp(4,3)] = deal(FP(1));
% [LAp(2,2) LAp(2,4) LAp(4,2) LAp(4,4)] = deal(FP(sqrt(2)));
% Main Loop
for step = 1:maxStep
    [x y] = NewAtom(MeshNum);
    ProcessMove(x,y,Estep);
    UpdatePotential(LAp, cutoff, Esup);
    % Visualization
    figure(1)
    surf(Position)
    view(0,90)
    colormap([1 1 1; 0 0 0])
    pause(1e-10)
    % Save figure
    if any(StepToSave==step)
        saveas(gcf,[num2str(step),'.png']);
    end
end