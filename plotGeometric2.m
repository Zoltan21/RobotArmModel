%testing the geometrical model
%giving some values to the system
L1=103.35*10e-2;
L2=125.83*10e-2;
L3=1.4;
theta1=0.1:0.1:0.1;
theta2=0:0.1:pi/2;
theta3=-pi/2:0.1:pi/2;

[Q1,Q2,Q3]=meshgrid(theta1,theta2,theta3);


X=L3*(sin(Q1).*sin(Q3) + cos(Q1).*cos(Q3).*sin(Q2)) + L2*cos(Q1).*sin(Q2);
Y=L2*sin(Q1).*sin(Q2) - L3*(cos(Q1).*sin(Q3) - cos(Q3).*sin(Q1).*sin(Q2));
Z=L1 + L2*cos(Q2) + L3*cos(Q2).*cos(Q3);

%plotting the results
scatter3(X(:),Y(:),Z(:));