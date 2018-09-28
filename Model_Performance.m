% Student: Victor Pugliese
% R#: 11492336
clear
format long
D=xlsread('Drift_Velocity_Analysis Performance',1,'H3:H150');
rho_L=xlsread('Drift_Velocity_Analysis Performance',1,'C3:C150');
rho_G=xlsread('Drift_Velocity_Analysis Performance',1,'D3:D150');
Drift_Vel_Exp=xlsread('Drift_Velocity_Analysis Performance',1,'I3:I150');
Ang_Deg=xlsread('Drift_Velocity_Analysis Performance',1,'A3:A150');
Ang_Rad=Ang_Deg*pi/180;
Cos_Theta=cos(Ang_Rad);
Sin_Theta=sin(Ang_Rad);
R=xlsread('Drift_Velocity_Analysis Performance',1,'M3:M150');
Eo=xlsread('Drift_Velocity_Analysis Performance',1,'N3:N150');
aux1=(-log10(R./Eo)).^7.443;
m=7.928*(10^-7)*(-log10(R./Eo)).^7.443+0.3276;
Fr_l=10.^(-m);
Fr=Fr_l.*(Cos_Theta+Sin_Theta);
vd_L=Fr.*(9.80665*D.*(1-rho_G./rho_L)).^0.5;

%Support Vector Regression Model
SV=xlsread('Drift_Velocity_Analysis Performance',2,'A2:D26');
alpha=xlsread('Drift_Velocity_Analysis Performance',2,'A29:A153');
b=xlsread('Drift_Velocity_Analysis Performance',2,'C29');
Fr_SV=zeros(1,length(R));
for i=1:length(R)
    Fr_SV(i) = SVR_prediction(SV,alpha,b,Cos_Theta(i),Sin_Theta(i),R(i),Eo(i));
end
vd_SV=Fr_SV'.*(9.80665*D.*(1-rho_G./rho_L)).^0.5;
t=1:length(R);
figure(1)
subplot(2,1,1)
plot(t,Drift_Vel_Exp,'*',t,vd_SV,'o')
xlabel('Observations')
ylabel('Drift Velocity [m/s]')
title('Predictions from the SVR model')
legend('Experimental Data','Model')
subplot(2,1,2)
plot(t,Drift_Vel_Exp,'*',t,vd_L,'o')
xlabel('Observations')
ylabel('Drift Velocity [m/s]')
title('Predictions from Livinus model')
legend('Experimental Data','Model')