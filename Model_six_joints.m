%simbolic constants
syms q1 q2 q3 q4 q5 q6 q7 L1 L2 L3 L4 L5 L6 L7  'real'
syms dq1 dq2 dq3 dq4 dq5 dq6 dq7 ddq1 ddq2 ddq3 ddq4 ddq5 ddq6 ddq7 'real'
%matrix declaration
T10=[ cos(q1) -sin(q1) 0 0
      sin(q1)  cos(q1) 0 0 
      0         0      1 L1
      0         0      0 1];

T21=[ sin(q2)  cos(q2)   0 0
      0         0      1 0
      cos(q2)    -sin(q2)   0 0
      0         0      0 1];
  
T32=[ cos(q3)   -sin(q3) 0 L2
      0         0        1 0
      -sin(q3)   -cos(q3)   0 0
      0         0        0 1];
  
T43=[ cos(q4) -sin(q4)  0  L3
     0          0      -1  0
     sin(q4)   cos(q4)  0  0
     0          0       0   1];
 
 
T54=[cos(q5) -sin(q5)  0  L4
    0           0      -1 0
    sin(q5)  cos(q5)   0  0
    0         0        0  1];

T65=[-sin(q6) -cos(q6)   0  L5
     0          0       -1  0
     cos(q6)  -sin(q6)   0  0
     0          0       0   1];
 
 T76=[cos(q7) -sin(q7)  0  0
      0         0       -1 -L6
      sin(q7) cos(q7)   0   0
      0         0       0   1];
  
     
  
%the geometrical model  
T30=T10*T21*T32*T43*T54*T65*T76;

%to obtain the kinematic model

%defining the rotation matrices
R10=T10(1:3,1:3);
R21=T21(1:3,1:3);
R32=T32(1:3,1:3);
R43=T43(1:3,1:3);
R54=T54(1:3,1:3);
R65=T65(1:3,1:3);
R76=T76(1:3,1:3);

R30=T30(1:3,1:3);

%position vector<?
r1=T10(1:3,4:4);
r2=T21(1:3,4:4);
r3=T32(1:3,4:4);
r4=T43(1:3,4:4);
r5=T54(1:3,4:4);
r6=T65(1:3,4:4);
r7=T76(1:3,4:4);
r8=[0 0 L7]';
%robot base, initial values
w0=[0 0 0]';
dw0=[0 0 0]';
v0=[0 0 0]';
g=9.8;%gravitational acceleration
dv0=[0 0 g]';
k=[0 0 1]';
%angular velocity
w1=R10'*w0 + dq1*k;
w2=R21'*w1 + dq2*k;
w3=R32'*w2 + dq3*k;
w4=R43'*w3 + dq4*k;
w5=R54'*w4 + dq5*k;
w6=R65'*w5 + dq6*k;
w7=R76'*w6 + dq7*k;
%skew symmetric matrices
w0x=skewSymmetric(w0);
w1x=skewSymmetric(w1);
w2x=skewSymmetric(w2);
w3x=skewSymmetric(w3);
w4x=skewSymmetric(w4);
w5x=skewSymmetric(w5);
w6x=skewSymmetric(w6);
w7x=skewSymmetric(w7);

%linear velocity
v1=R10'*(v0+w0x*r1);
v2=R21'*(v1+w1x*r2);
v3=R32'*(v2+w2x*r3);
v4=R43'*(v3+w3x*r4);
v5=R54'*(v4+w4x*r5);
v6=R65'*(v5+w5x*r6);
v7=R76'*(v6+w6x*r7);

%angular acceleration
dw1=R10'*dw0+R10'*w0x*dq1*k+ddq1*k;
dw2=R21'*dw1+R21'*w1x*dq2*k+ddq2*k;
dw3=R32'*dw2+R32'*w2x*dq3*k+ddq3*k;
dw4=R43'*dw3+R43'*w3x*dq4*k+ddq4*k;
dw5=R54'*dw4+R54'*w4x*dq5*k+ddq5*k;
dw6=R65'*dw5+R65'*w5x*dq6*k+ddq6*k;
dw7=R76'*dw6+R76'*w6x*dq7*k+ddq7*k;

%skew symmetric matrices
dw0x=skewSymmetric(dw0);
dw1x=skewSymmetric(dw1);
dw2x=skewSymmetric(dw2);
dw3x=skewSymmetric(dw3);
dw4x=skewSymmetric(dw4);
dw5x=skewSymmetric(dw5);
dw6x=skewSymmetric(dw6);
dw7x=skewSymmetric(dw7);


%linear acceleration
dv1=R10'*(dv0+dw0x*r1+w0x*w0x*r1);
dv2=R21'*(dv1+dw1x*r2+w1x*w1x*r2);
dv3=R32'*(dv2+dw2x*r3+w2x*w2x*r3);
dv4=R43'*(dv3+dw3x*r4+w3x*w3x*r4);
dv5=R54'*(dv4+dw4x*r5+w4x*w4x*r5);
dv6=R65'*(dv5+dw5x*r6+w5x*w5x*r6);
dv7=R76'*(dv6+dw6x*r7+w6x*w6x*r7);

%final relation
    %velocitiy
    w0_3=R30*w3;
    v0_3=R30*v3;
    %accelerations
    dw0_3=R30*dw3;
    dv0_3=R30*dv3;
    
%dynamical model

rc1=[0 0 L1/2]';
%rc1=[0 0 L1]';
rc2=[L2/2 0 0]';
rc3=[L3/2 0 0]';
%rc3=[L2 0 0]';
rc4=[L4/2 0 0]';
rc5=[L5/2 0 0]';
rc6=[0 -L6/2 0]';
rc7=[0 0 L7/2]';

vc1=dv1+dw1x*rc1+w1x*w1x*rc1;
vc2=dv2+dw2x*rc2+w2x*w2x*rc2;
vc3=dv3+dw3x*rc3+w3x*w3x*rc3;
vc4=dv4+dw4x*rc4+w4x*w4x*rc4;
vc5=dv5+dw5x*rc5+w5x*w5x*rc5;
vc6=dv6+dw6x*rc6+w6x*w6x*rc6;
vc7=dv7+dw7x*rc7+w7x*w7x*rc7;

%mass of elements
syms M1 M2 M3 M4 M5 M6 M7 'real'

%external forces
F1=M1*vc1;
F2=M2*vc2;
F3=M3*vc3;
F4=M4*vc4;
F5=M5*vc5;
F6=M6*vc6;
F7=M7*vc7;

%inertia moments matrix:
syms I1x I1y I1z I2x I2y I2z I3x I3y I3z 
syms I4x I4y I4z I5x I5y I5z I6x I6y I6z I7x I7y I7z 'real'
I1=[I1x 0 0; 0 I1y 0; 0 0 I1z];
I2=[I2x 0 0; 0 I2y 0; 0 0 I2z];
I3=[I3x 0 0; 0 I3y 0; 0 0 I3z];
I4=[I4x 0 0; 0 I4y 0; 0 0 I4z];
I5=[I5x 0 0; 0 I5y 0; 0 0 I5z];
I6=[I6x 0 0; 0 I6y 0; 0 0 I6z];
I7=[I7x 0 0; 0 I7y 0; 0 0 I7z];
%I1=eye(3);
%I2=eye(3);
%external torques generate by the force Fi
N1=I1*dw1+w1x*I1*w1;
N2=I2*dw2+w2x*I2*w2;
N3=I3*dw3+w3x*I3*w3;
N4=I4*dw4+w4x*I4*w4;
N5=I5*dw5+w5x*I5*w5;
N6=I6*dw6+w6x*I6*w6;
N7=I7*dw7+w7x*I7*w7;

%connection forces
f8=[0 0 0]';
n8=[0 0 0]';
%empty matrix
R87=zeros(3);

%f7=R87*f8+F7;
f7=[0 0 0]';
f6=R76*f7+F6;
f5=R65*f6+F5;
f4=R54*f5+F4;
f3=R43*f4+F3;
f2=R32*f3+F2;
f1=R21*f2+F1;

%skew symmetric matrices
rc1x=skewSymmetric(rc1);
rc2x=skewSymmetric(rc2);
rc3x=skewSymmetric(rc3);
rc4x=skewSymmetric(rc4);
rc5x=skewSymmetric(rc5);
rc6x=skewSymmetric(rc6);
rc7x=skewSymmetric(rc7);

r1x=skewSymmetric(r1);
r2x=skewSymmetric(r2);
r3x=skewSymmetric(r3);
r4x=skewSymmetric(r4);
r5x=skewSymmetric(r5);
r6x=skewSymmetric(r6);
r7x=skewSymmetric(r7);
r8x=skewSymmetric(r8);

%torques generated by the connection forces


%n7=R87*n8+rc7x*F7+r8x*R87*f8+N7;
n7=[0 0 0]';
n6=R76*n7+rc6x*F6+r7x*R76*f7+N6;
n5=R65*n6+rc5x*F5+r6x*R65*f6+N5;
n4=R54*n5+rc4x*F4+r5x*R54*f5+N4;
n3=R43*n4+rc3x*F3+r4x*R43*f4+N3;
n2=R32*n3+rc2x*F2+r3x*R32*f3+N2;
n1=R21*n2+rc1x*F1+r2x*R21*f2+N1;

%final final results

Qm=[n1'*k; n2'*k; n3'*k; n4'*k; n5'*k; n6'*k];

Ta1=n1'*k;
Ta2=n2'*k;
Ta3=n3'*k;
Ta4=n4'*k;
Ta5=n5'*k;
Ta6=n6'*k;


  