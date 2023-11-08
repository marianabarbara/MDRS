%% TASK 1
%% 1 a)
P = 100000;
lambda = 1800;
C = [10, 20, 30, 40];
f = 1000000;
N = 20;
alpha=0.1;
PL = zeros(1,4); 
APD = zeros(1,4); 
MPD = zeros(1,4); 
TT = zeros(1,4);

media_APD = zeros(1,4);
term_APD = zeros(1,4);
for i= 1:length(C)
 for it= 1:N
 [PL(it), APD(it), MPD(it), TT(it)] = Simulator1(lambda,C(i),f,P);
 end
 media_APD(i) = mean(APD);
 term_APD(i) = norminv(1-alpha/2)*sqrt(var(APD)/N);
end
figure(1);
bar(C,media_APD);
hold on
er = errorbar(C,media_APD,term_APD);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average Packet Delay');
xlabel('Link bandwidth (Mbps)');
ylabel('Average packet delay (ms)');
hold off
%% 1 b)
media_APD = zeros(1,4);
media_APD_2 = zeros(1,4);

for i = 1:length(C)
 for it= 1:N
 media_APD_2 = Theo_Avg_Delay_MG1(lambda,C(i));
 end
 media_APD(i) = mean(media_APD_2);
end

figure(2);
bar(C,media_APD);
hold on
grid on
title("Average Packet Deplay (MG1 queueing model)");
xlabel('Link bandwidth (Mbps)');
ylabel('Average packet delay (ms)');
hold off

%% 1 c)
lambda = [1000, 1300, 1600, 1900];
C = 10;
f = 1000000; 
P = 100000; 
N = 20;
alpha = 0.1;

PL = zeros(1, 4);
APD = zeros(1,4);
MPD = zeros(1,4);
TT = zeros(1,4);

media_APD = zeros(1,4);
term_APD = zeros(1,4);
media_TT = zeros(1,4);
term_TT = zeros(1,4);

for i = 1:length(lambda)
    for it = 1:N
        [PL(it), APD(it), MPD(it), TT(it)] = Simulator1(lambda(i), C, f, P);
    end
    media_APD(i) = mean(APD);
    term_APD(i) = norminv(1 - alpha / 2) * sqrt(var(APD) / N);
    media_TT(i) = mean(TT);
    term_TT(i) = norminv(1 - alpha / 2) * sqrt(var(TT) / N);
end

figure(3);
bar(lambda, media_APD);
hold on
er = errorbar(lambda, media_APD, term_APD);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average Packet Delay');
xlabel('Packet Arrival Rate (pps)');
ylabel('Average packet delay (ms)');
hold off

figure(4);
bar(lambda, media_TT);
hold on
er = errorbar(lambda, media_TT, term_TT);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average Throughput');
xlabel('Packet Arrival Rate (pps)');
ylabel('Average throughput (Mbps)');
hold off

%% 1 d)
lambda = [1000, 1300, 1600, 1900];
C = 10;
f = 1000000; 
P = 100000; 
N = 20;
alpha = 0.1;
b = 10^-5;

PL = zeros(1, 4);
APD = zeros(1,4);
MPD = zeros(1,4);
TT = zeros(1,4);

media_APD = zeros(1,4);
term_APD = zeros(1,4);
media_TT = zeros(1,4);
term_TT = zeros(1,4);

for i = 1:length(lambda)
    for it = 1:N
        [PL(it), APD(it), MPD(it), TT(it)] = Simulator2(lambda(i), C, f, P, b);
    end
    media_APD(i) = mean(APD);
    term_APD(i) = norminv(1 - alpha / 2) * sqrt(var(APD) / N);
    media_TT(i) = mean(TT);
    term_TT(i) = norminv(1 - alpha / 2) * sqrt(var(TT) / N);
end

figure(5);
bar(lambda, media_APD);
hold on
er = errorbar(lambda, media_APD, term_APD);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average Packet Delay');
xlabel('Packet Arrival Rate (pps)');
ylabel('Average packet delay (ms)');
hold off

figure(6);
bar(lambda, media_TT);
hold on
er = errorbar(lambda, media_TT, term_TT);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average Throughput');
xlabel('Packet Arrival Rate (pps)');
ylabel('Average throughput (Mbps)');
hold off


%% 1 e) - Simulador 1 Novo

lambda = [1000, 1300, 1600, 1900];
C = 10;
f = 1000000; 
P = 100000; 
N = 20;
alpha = 0.1;

PL = zeros(1, 4);
APD = zeros(1,4);
MPD = zeros(1,4);
TT = zeros(1,4);

media_APD = zeros(1,4);
term_APD = zeros(1,4);
media_TT = zeros(1,4);
term_TT = zeros(1,4);

for i = 1:length(lambda)
    for it = 1:N
        [PL(it), APD(it), MPD(it), TT(it)] = Simulator1_new(lambda(i), C, f, P);
    end
    media_APD(i) = mean(APD);
    term_APD(i) = norminv(1 - alpha / 2) * sqrt(var(APD) / N);
    media_TT(i) = mean(TT);
    term_TT(i) = norminv(1 - alpha / 2) * sqrt(var(TT) / N);
end

figure(3);
bar(lambda, media_APD);
hold on
er = errorbar(lambda, media_APD, term_APD);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average Packet Delay');
xlabel('Packet Arrival Rate (pps)');
ylabel('Average packet delay (ms)');
hold off

figure(4);
bar(lambda, media_TT);
hold on
er = errorbar(lambda, media_TT, term_TT);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average Throughput');
xlabel('Packet Arrival Rate (pps)');
ylabel('Average throughput (Mbps)');
hold off




%% 1. e) - Simulador 2 Novo

lambda = [1000, 1300, 1600, 1900];
C = 10;
f = 1000000; 
P = 100000; 
N = 20;
alpha = 0.1;
b = 10^-5;

PL = zeros(1, 4);
APD = zeros(1,4);
MPD = zeros(1,4);
TT = zeros(1,4);

media_APD = zeros(1,4);
term_APD = zeros(1,4);
media_TT = zeros(1,4);
term_TT = zeros(1,4);

for i = 1:length(lambda)
    for it = 1:N
        [PL(it), APD(it), MPD(it), TT(it)] = Simulator2_new(lambda(i), C, f, P, b);
    end
    media_APD(i) = mean(APD);
    term_APD(i) = norminv(1 - alpha / 2) * sqrt(var(APD) / N);
    media_TT(i) = mean(TT);
    term_TT(i) = norminv(1 - alpha / 2) * sqrt(var(TT) / N);
end

figure(5);
bar(lambda, media_APD);
hold on
er = errorbar(lambda, media_APD, term_APD);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average Packet Delay');
xlabel('Packet Arrival Rate (pps)');
ylabel('Average packet delay (ms)');
hold off

figure(6);
bar(lambda, media_TT);
hold on
er = errorbar(lambda, media_TT, term_TT);
er.Color = [0 0 0];
er.LineStyle = 'none';
grid on
title('Average Throughput');
xlabel('Packet Arrival Rate (pps)');
ylabel('Average throughput (Mbps)');
hold off



function W1 = Theo_Avg_Delay_MG1(lambda,C)
    [es, es2] = ES_data(C);
    W1 = (((lambda*es2 ) / (2 * (1 - lambda*es))) + es) * 1000;
end

function [es, es2] = ES_data(C)
    k = (0.41/((109 - 65 + 1)+(1517 - 111 + 1)));
    es = 0.19*((64*8)/(C*10^6)) + 0.23*((110*8)/(C*10^6)) + 0.17*((1518*8)/(C*10^6));
    es2 = 0.19*((64*8)/(C*10^6))^2 + 0.23*((110*8)/(C*10^6))^2 + 0.17*((1518*8)/(C*10^6))^2;
    for n = 65:109
        es = es + k * ((n*8)/(C*10^6));
        es2 = es2 + k * ((n * 8)/(C*10^6))^2;
    end
    for n = 111:1517
         es = es + k * ((n*8)/(C*10^6));
         es2 = es2 + k * ((n * 8)/(C*10^6))^2;
    end
end