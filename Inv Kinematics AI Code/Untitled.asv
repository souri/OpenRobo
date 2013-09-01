% Author: Souri
% Date: May 08,2011

% theta1 : link1 angle
% theta2 : link2 angle
% theta3 : rotation angle
% a : link1 length
% b : link2 (end effector link) length
% c : base link length

% Training ANFIS data:
% anfis function parameters:
% The first parameter to anfis is the training data
% The second parameter is the number of membership functions used to characterize each input and output (increasing value of this parameter will give improved accuracy but takes a lot of time to train anfis data)
% The third parameter is the number of training epochs
% The last parameter is the options to display progress during training.
% The values for number of epochs and the number of membership functions have been arrived at after a fair amount of experimentation with different values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
l1 = 15.8; % set length of first arm
l2 = 14.5; % set length of second arm
l3 = 14; %set length of third arm
b = 15.8; % set height of base arm

theta1 = -pi/2:0.5:pi/2; % all possible theta1 values
theta2 = -pi/2:0.5:pi/2; % all possible theta2 values
theta3 = -pi/2:0.5:pi/2; % all possible theta3 values
alpha = -pi/2:0.5:pi/2; % all possible base rotation values
%temp = theta3;

[THETA1, THETA2, THETA3] = meshgrid(theta1, theta2, theta3); % generate a grid of theta1,theta2, theta3, alpha values
[THETA1, THETA2, ALPHA] = meshgrid(theta1, theta2, alpha);

%Z = l1 * cos(THETA1) + l2 * cos(THETA1 + THETA2) + l3*cos(THETA1 + THETA2 + THETA3); % compute Z coordinates
r = ((l1 * sin(THETA1)+ l2 * sin(THETA1 + THETA2) + l3 * sin(THETA1 + THETA2 + THETA3)).^2 + (l1 * cos(THETA1)+ l2 * cos(THETA1 + THETA2) + l3 * cos(THETA1 + THETA2 + THETA3)).^2).^.5 ;
beta = atan((l1 * sin(THETA1)+ l2 * sin(THETA1 + THETA2) + l3 * sin(THETA1 + THETA2 + THETA3))./(l1 * cos(THETA1)+ l2 * cos(THETA1 + THETA2) + l3 * cos(THETA1 + THETA2 + THETA3)));


X = r.*sin(beta).*cos(ALPHA);
Y = r.*sin(beta).*sin(ALPHA);
Z = r.*cos(beta) - 6;

% X = r.*sin(ALPHA);
% Y = r.*cos(ALPHA);

% r = (((l1 * cos(THETA1) + l2 * cos(THETA1 + THETA2) + l3 * cos(THETA1 + THETA2 + THETA3)).^2 + (l1 * sin(THETA1) + l2 * sin(THETA1 + THETA2) + l3 * sin(THETA1 + THETA2 + THETA3)).^2).^(.5));
% theta = atan((l1 * cos(THETA1) + l2 * cos(THETA1 + THETA2) + l3 * cos(THETA1 + THETA2 + THETA3))./(l1 * sin(THETA1) + l2 * sin(THETA1 + THETA2) + l3 * sin(THETA1 + THETA2 + THETA3)));

% X = r .* cos(THETA3) .* cos(theta); % compute x coordinates
% Y = r .* sin(THETA3) .* cos(theta); % compute y coordinates

data1 = [X(:) Y(:) Z(:) THETA1(:)]; % create x-y-z-theta1 dataset
data2 = [X(:) Y(:) Z(:) THETA2(:)]; % create x-y-z-theta2 dataset
data3 = [X(:) Y(:) Z(:) THETA3(:)]; % create x-y-z-theta3 dataset
data4 = [X(:) Y(:) Z(:) ALPHA(:)]; % create x-y-z-theta3 dataset

plot3(X(:), Y(:), Z(:))
axis square;
grid on;
xlabel('X')
ylabel('Y')
zlabel('Z')
title('Locus of XYZ co-ordinates generated for all theta1, theta2, theta3, alpha combinations using derived FK formulae')
  
fprintf('-->%s\n','Start training first ANFIS network. It may take one minute depending on your computer system.')
anfis1 = anfis(data1, 7, 150, [0,0,0,0]); % train first ANFIS network
fprintf('-->%s\n','Start training second ANFIS network. It may take one minute depending on your computer system.')
anfis2 = anfis(data2, 7, 150, [0,0,0,0]); % train second ANFIS network
fprintf('-->%s\n','Start training third ANFIS network. It may take one minute depending on your computer system.')
anfis3 = anfis(data3, 7, 150, [0,0,0,0]); % train third ANFIS network
fprintf('-->%s\n','Start training fourth ANFIS network. It may take one minute depending on your computer system.')
anfis4 = anfis(data4, 5, 150, [0,0,0,0]); % train third ANFIS network

XYZ_input=[0 30 0]
fprintf('Converting the input data to standard coordinate system. Translating the Z axis.')
XYZ=XYZ_input - [0 0 b]

THETA1P = evalfis(XYZ, anfis1) % theta1 predicted by anfis1
THETA2P = evalfis(XYZ, anfis2) % theta2 predicted by anfis2
THETA3P = evalfis(XYZ, anfis3) % theta3 predicted by anfis3
ALPHAP = evalfis(XYZ, anfis4) % alpha predicted by anfis3
fprintf('Predicted value of Theta1, Theta2, Theta3 and ALPHA = %f %f %f %f',THETA1P,THETA2P,THETA3P,ALPHAP)
fprintf('\n')