
%linearize the equations
%using Jacobian

syms q01 q02 q03 dq01 dq02 dq03 ddq01 ddq02 ddq03 'real'

    q1=q01;
    q2=q02;
    q3=q03;
    dq1=dq01;
    dq2=dq02;
    dq3=dq03;
    ddq1=ddq01;
    ddq2=ddq02;
    ddq3=ddq03;  

N=length(Qm);

%the x0 term
y=eval(Qm);
clear q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3 
syms q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3 'real'

for i=1:N
    %getting the derivative of each matrix
    %Qm(i)

    coeffM=jacobian(Qm(i),[q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3]);
    %give the x0 values
    q1=q01;
    q2=q02;
    q3=q03;
    dq1=dq01;
    dq2=dq02;
    dq3=dq03;
    ddq1=ddq01;
    ddq2=ddq02;
    ddq3=ddq03;  
    
    %now we have the first order derivatives
    coeffM2=eval(coeffM);
    clear q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3
    syms q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3 'real'
    
    y(i) = y(i) + coeffM2(1)*(q1-q01) + coeffM2(2)*(q2-q02) + coeffM2(3)*(q3-q03) ...
                + coeffM2(4)*(dq1-dq01) + coeffM2(5)*(dq2-dq02) + coeffM2(6)*(dq3-dq03) ...
                + coeffM2(7)*(ddq1-ddq01) + coeffM2(8)*(ddq2-ddq02) + coeffM2(9)*(ddq3-ddq03);

end
% 
% q01=0;
% q02=0;
% q03=0;
% yMod=eval(y)

