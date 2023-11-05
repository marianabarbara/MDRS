%% TASK 1
%% 1 a)
P = 100000;
lambda = 1800;
C = [10, 20, 30, 40];
f = 1000000;

for index = 1:length(C)
    N = 20;
    alpha=0.1;
    PL = zeros(1,N);
    APD = zeros(1,N);
    MPD = zeros(1,N);
    TT = zeros(1,N);
    
    for i = 1:N
        [PL(i), APD(i), MPD(i), TT(i)] = Simulator1(lambda,C(index),f,P);
    end  
    
    fprintf('C = %d\n',C(index));
   
    mediaAPD = mean(APD);
    termAPD = norminv(1-alpha/2)*sqrt(var(APD)/N);
    fprintf('Av. Packet Delay (ms)= %.2e +-%.2e\n', mediaAPD, termAPD);
    APD_Res(index) = mediaAPD;
    APD_Err(index) = termAPD;
end

figure(1);
bar(C,APD_Res);
grid on
xlabel("Link bandwidth (Mbps)");
ylabel("Packet Delay");
title(["Average Packet Delay"]);
hold on
er = errorbar(C,APD_Resultsc,APD_Err,APD_Err);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';
hold off

%% 1 b) - NÃO ESTÁ A DAR BEM, ACHO EU
lambda = 1800;
C = [10*10^6, 20*10^6, 30*10^6, 40*10^6];
f = 1000000;
N = 20;  

x = 64:1518;

prob = zeros(1,1518);
prob(packetSize) = (1 - 0.19 - 0.23 -0.17) / (length(packetSize)-3);
prob(64) = 0.19;
prob(110) = 0.23;
prob(1518) = 0.17;

for index=1:numel(C)
     
    Spacket = x.*8./C(index);
    Spacket2= Spacket.^2;
    E = sum(prob(x).*Spacket);
    E2 = sum(prob(x).*Spacket2);
    avgPacketSize = sum(prob(x).*x);

    APD_theo = (((lambda.*E2) ./ (2*(1-lambda.*E)))+E)*10^3; %converter em ms

    fprintf('C = %.2e \n',C(index));
    fprintf('Av. Packet Delay= %.2e \n',APD_theo);
end

figure(2);
bar(C, APD_theo);
hold on
grid on
title("Average Packet Deplay (MG1 queueing model)");
xlabel('Link bandwidth (Mbps)');
ylabel('Average packet delay (ms)');
hold off


%% 1 c)

%% 1 d)

%% 1 e)