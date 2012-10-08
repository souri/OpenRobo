l1 = 18; % length of first arm
l2 = 18; % length of second arm
l3 = 16.5;
theta1 = -pi/2:0.4:pi/2; % all possible theta1 values
theta2 = -pi/2:0.4:pi/2; % all possible theta2 values
theta3 = -pi/2:0.4:pi/2; % all possible theta3 values

[THETA1, THETA2, THETA3] = meshgrid(theta1, theta2, theta3); % generate a grid of theta1 and theta 2 values


X = l1 * cos(THETA1) + l2 * cos(THETA1 + THETA2); % compute x coordinates
Y = l1 * sin(THETA1) + l2 * sin(THETA1 + THETA2); % compute y coordinates

data1 = [X(:) Y(:) THETA1(:)]; % create x-y-theta1 dataset
data2 = [X(:) Y(:) THETA2(:)]; % create x-y-theta2 dataset

plot(X(:), Y(:), 'r.');
axis equal;
xlabel('X')
ylabel('Y')
fprintf('-->%s\n','Start training first ANFIS network. It may take one minute depending on your computer system.')
anfis1 = anfis(data1, 7, 150, [0,0,0,0]); % train first ANFIS network
fprintf('-->%s\n','Start training second ANFIS network. It may take one minute depending on your computer system.')
anfis2 = anfis(data2, 6, 150, [0,0,0,0]); % train second ANFIS network