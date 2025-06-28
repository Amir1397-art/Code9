% Constants
gamma = 1.4;  % Specific heat ratio
P1 = 100;     % kPa (initial pressure)
V1 = 0.287*300/100;          % m^3 (initial volume)
T1 = 300;     % K (initial temperature)
rc = 12;      % Compression ratio
rp = 1.7;     % Pressure ratio (P3/P2)
cutoff_ratio = 1.55;  % Cut-off ratio (V4/V3)

 
% Dual Cycle Calculations
V2 = V1 / rc;
P2 = P1 * (rc ^ gamma);
T2 = T1 * (rc ^ (gamma - 1));
 
P3 = rp * P2;
T3 = T2 * rp;
V3 = V2;
 
V4 = cutoff_ratio * V3;
T4 = T3 * cutoff_ratio;
P4 = P3;
 
V5 = V1;
P5 = P4 * ((V4 / V5) ^ gamma);
 
% Otto Cycle Calculations
T3_otto = T2 * rp;
P3_otto = P2 * (T3_otto / T2);
V4_otto = V1;
P4_otto = P3_otto * ((V3 / V4_otto) ^ gamma);
 
% Diesel Cycle Calculations
cutoff_ratio_diesel = 1.55;
V3_diesel = cutoff_ratio_diesel * V2;
P3_diesel = P2;
V4_diesel = V1;
P4_diesel = P3_diesel * ((V3_diesel / V4_diesel) ^ gamma);
 
% Generate P-V points
% Dual Cycle
V_dual = [linspace(V1, V2, 100), linspace(V2, V3, 2),linspace(V3, V4, 100), linspace(V4, V5, 100), linspace(V5, V1, 2)]; 
         
P_dual = [P1*(V1./linspace(V1,V2,100)).^gamma, linspace(P2,P3,2),linspace(P3,P4,100), P4*(V4./linspace(V4,V5,100)).^gamma, linspace(P5,P1,2)];          

 
% Otto Cycle
V_otto = [linspace(V1, V2, 100), linspace(V2, V3, 2),linspace(V3, V4_otto, 100), linspace(V4_otto, V1, 2)];
         
P_otto = [P1*(V1./linspace(V1,V2,100)).^gamma, linspace(P2,P3_otto,2), 
P3_otto*(V3./linspace(V3,V4_otto,100)).^gamma, linspace(P4_otto,P1,2)];
 
% Diesel Cycle
V_diesel = [linspace(V1, V2, 100), linspace(V2, V3_diesel, 100),linspace(V3_diesel, V4_diesel, 100), linspace(V4_diesel, V1, 2)];
           
P_diesel = [P1*(V1./linspace(V1,V2,100)).^gamma, linspace(P2,P3_diesel,100),P3_diesel*(V3_diesel./linspace(V3_diesel,V4_diesel,100)).^gamma, linspace(P4_diesel,P1,2)];        
  
 
% Plotting
figure;
plot(V_dual, P_dual, 'b-', 'LineWidth', 2);

hold on;
plot(V_otto, P_otto, 'r--', 'LineWidth', 2);
plot(V_diesel, P_diesel, 'g-.', 'LineWidth', 2);
hold off;
 
xlabel('Volume (m^3)', 'FontSize', 12);
ylabel('Pressure (kPa)', 'FontSize', 12);
title('P-V Diagram Comparison(Compression Ratio = 12)', 'FontSize', 14);
legend('Dual Cycle', 'Otto Cycle', 'Diesel Cycle');
grid on;
xlim([0, 1.1]);
ylim([0, 6000]);