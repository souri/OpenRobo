% Author: Souri
% Date: May 08,2011
% Script to compute forward/ inverse kinematics of Robot Arm v1.0

clear all;

fprintf('aquiring theta values...\n');

theta1i = -pi/2:0.5:pi/2; %base rotation angle
theta2i = -pi/2:0.5:pi/2; %link1 rot angle
theta3i = -pi/2:0.5:pi/2; %link2 rot angle
theta4i = -pi/2:0.5:pi/2; %link3 rot angle

theta1 = -90:3:90; %base rotation angle
theta2 = -90:3:90; %link1 rot angle
theta3 = -90:3:90; %link2 rot angle
theta4 = -90:3:90; %link3 rot angle

fprintf('aquiring link data...\n');

L1= link([pi/2 0 0 15.8 0], 'standard');
L2=link([0 14.5 0 0 0], 'standard');
L3=link([0 14 0 0 0], 'standard');
L4=link([0 14 0 0 0], 'standard');
r = robot({L1 L2 L3 L4});
plot(r,[0 0 0 0])

fprintf('testing fwd and inv kinematics...\n');

qzin=[0*(pi/180) 90*(pi/180) 0*(pi/180) 0*(pi/180)]; % joint angles

qz = qzin + [pi/2 pi/2 0 0]
qz(1,3) = -qz(1,3)
qz(1,1) = -qz(1,1)

plot(r,qz)
F = fkine(r,qz)
%I = ikine(r,F)

fprintf('test completed...\n');
fprintf('starting to compute the fwd kinematics relation table...\n');

% 
%                 XYZ(i,j,k,l) = a;
%                 XYZ(i,j+1,k,l) = b;
%                 XYZ(i,j+1,k+1,l) = c;
%                 XYZ(i,j+1,k+1,l+1) = d

% 
i=1; j=1; k=1; l=1;
for a = theta1
    for b = theta2
        for c = theta3
            for d = theta4
                qzin=[a*(pi/180) b*(pi/180) c*(pi/180) d*(pi/180)];
                qz = qzin + [pi/2 pi/2 0 0];
                qz(1,3) = -qz(1,3);
                qz(1,1) = -qz(1,1);
                F = fkine(r,qz);
                X(i,j)= a;
                X(i,j+1)= b;
                X(i,j+2)= c;
                X(i,j+3)= d;
                X(i,j+4)= F(1,4);
                Y(i,j)= a;
                Y(i,j+1)= b;
                Y(i,j+2)= c;
                Y(i,j+3)= d;
                Y(i,j+4)= F(2,4);
                Z(i,j)= a;
                Z(i,j+1)= b;
                Z(i,j+2)= c;
                Z(i,j+3)= d;
                Z(i,j+4)= F(1,4);
                i= i+1;
                fprintf('Current a,b,c,d = %d %d %d %d',a,b,c,d);
                fprintf('\n')
            end
        end
    end
end

%inverse kinematics calculations
%input is x,y,z in T matrix
%o/p is in terms of theta1,theta2,theta3,theta4

            
        