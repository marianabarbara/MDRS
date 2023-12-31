%% TASK 2
%% 2 a)
lambda = 1500; 
C = 10;
f = 1000000;
P = 100000;
N = 20;

n = [10, 20, 30, 40];

alpha = 0.1;

PL_data = zeros(1,4);
APD_data = zeros(1,4);
MPD_data = zeros(1,4);
PL_voip = zeros(1,4);
APD_voip = zeros(1,4);
MPD_voip = zeros(1,4);
TT = zeros(1,4); 

media_APD_data = zeros(1,4);
term_APD_data = zeros(1,4);
media_APD_voip = zeros(1,4);
term_APD_voip = zeros(1,4);

for i = 1:length(n)
    for it= 1:N
        [PL_data(it), PL_voip(it), APD_data(it), APD_voip(it), MPD_data(it), MPD_voip(it), TT(it)] = Simulator3(lambda,C,f,P,n(i));
    end
    
    media_APD_data(i) = mean(APD_data);
    term_APD_data(i) = norminv(1-alpha/2)*sqrt(var(APD_data)/N);
    media_APD_voip(i) = mean(APD_voip);
    term_APD_voip(i) = norminv(1-alpha/2)*sqrt(var(APD_voip)/N);
end

figure(1);
bar(n,media_APD_data);
hold on
er = errorbar(n,media_APD_data,term_APD_data);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average Data Packet Delay');
xlabel('n (number of Data packets flows)');
ylabel('Average Data packet delay (ms)');
hold off

figure(2);
bar(n,media_APD_voip);
hold on
er = errorbar(n,media_APD_voip,term_APD_voip);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average VoIP Packet Delay');
xlabel('n (number of VoIP packets flows)');
ylabel('Average VoIP packet delay (ms)');
hold off

%% 2 b)

lambda = 1500; 
C = 10;
f = 1000000;
P = 100000;
N = 20;

n = [10, 20, 30, 40];

alpha = 0.1;

PL_data = zeros(1,4);
APD_data = zeros(1,4);
MPD_data = zeros(1,4);
PL_voip = zeros(1,4);
APD_voip = zeros(1,4);
MPD_voip = zeros(1,4);
TT = zeros(1,4); 

media_APD_data = zeros(1,4);
term_APD_data = zeros(1,4);
media_APD_voip = zeros(1,4);
term_APD_voip = zeros(1,4);

for i = 1:length(n)
    for it = 1:N
        [PL_data(it), PL_voip(it), APD_data(it), APD_voip(it), MPD_data(it), MPD_voip(it), TT(it)] = Simulator4(lambda,C,f,P,n(i));
    end
    media_APD_data(i) = mean(APD_data);
    term_APD_data(i) = norminv(1-alpha/2)*sqrt(var(APD_data)/N);
    media_APD_voip(i) = mean(APD_voip);
    term_APD_voip(i) = norminv(1-alpha/2)*sqrt(var(APD_voip)/N);
end

figure(3);
bar(n,media_APD_data);
hold on
er = errorbar(n,media_APD_data,term_APD_data);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average Data Packet Delay');
xlabel('n (number of Data packets flows)');
ylabel('Average Data packet delay (ms)');
hold off

figure(4);
bar(n,media_APD_voip);
hold on
er = errorbar(n,media_APD_voip,term_APD_voip);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average VoIP Packet Delay');
xlabel('n (number of VoIP packets flows)');
ylabel('Average VoIP packet delay (ms)');
hold off

%% 2 c)

media_APD_data = zeros(1,4);
media_APD_voip = zeros(1,4);
media_APD_data_2 = zeros(1,4);
media_APD_voip_2 = zeros(1,4);
for i= 1:length(n)
    for it= 1:N
        [media_APD_voip_2, media_APD_data_2] =  Theo_Avg_Delay_MG1(lambda, C, n(i));
    end
  
    media_APD_data(i) = mean(media_APD_data_2);
    media_APD_voip(i) = mean(media_APD_voip_2);
end
figure(5);
bar(n,media_APD_data);
hold on
grid on
title('Average Data Packet Delay');
xlabel('n (number of Data packets flows)');
ylabel('Average Data packet delay (ms)');
hold off

figure(6);
bar(n,media_APD_voip);
hold on
grid on
title('Average VoIP Packet Delay');
xlabel('n (number of VoIP packets flows)');
ylabel('Average VoIP packet delay (ms)');
hold off

function [W1, W2] = Theo_Avg_Delay_MG1(lambda, C, n)
    meanPacketVoipSize = (110+130)/2;
    bytesVoip = 110:130;
    lambdaVoip = (1/(20*10^3))*n;
    lambdaData = lambda;
    [esData, es2Data] =  ES_data(C);
    [esVoip, es2Voip] = ES_voip(C,bytesVoip);
    uVoip = (C*10^6) / (meanPacketVoipSize*8);
    uData = (C*10^6) / (esData);
    p1 = lambdaVoip / uVoip;
    p2 = lambdaData / uData;
    WQ1 = ((lambdaVoip*es2Voip) + (lambdaData.*es2Data)) / (2*(1-p1));
    WQ2 = ((lambdaVoip*es2Voip) + (lambdaData.*es2Data)) / (2*(1-p1)*(1-p1-p2));
    W1 = (WQ1 + esVoip) * 1000;
    W2 = (WQ2 + esData) * 1000;
end

function [ES, ES2] = ES_data(C)
    k = (0.41/((109 - 65 + 1)+(1517 - 111 + 1)));
    ES = 0.19 * ((64*8)/(C*10^6)) + 0.23 * ((110*8)/(C*10^6)) + 0.17 * ((1518*8)/(C*10^6));
    ES2 = 0.19 * ((64*8)/(C*10^6))^2 + 0.23 * ((110*8)/(C*10^6))^2 + 0.17 * ((1518*8)/(C*10^6))^2;
    
    for n = 65:109
        ES = ES + k * ((n*8)/(C*10^6));
        ES2 = ES2 + k * ((n * 8)/(C*10^6))^2;
    end
    for n = 111:1517
         ES = ES + k * ((n*8)/(C*10^6));
         ES2 = ES2 + k * ((n * 8)/(C*10^6))^2;
    end
end

function [ES, ES2] = ES_voip(C, v)
    ES = 0;
    ES2 = 0;
    for i = 1:size(v, 2)
        ES = ES + (((v(i)*8)/(C*10^6)))*(1/21);
        ES2 = ES2 + (( (v(i)*8)/(C*10^6))^2)*(1/21);
    end
end