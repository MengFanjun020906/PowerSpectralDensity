clear
close all
clc

%生成随机信号
noiseLevel=2;
signal = rand(80000,1);
noise = randn(80000,1) * noiseLevel;
signal = signal + noise;

X = signal;
Fs = 2e3;
L = length(X);
Y = fft(X);%傅立叶变换
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1)=2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
%频谱
subplot(221);
plot(f,P1);
ylim([0 0.05]);
title('频谱');
xlabel('f(Hz)');
ylabel('|P1(f)|(单位:mV)');
%功率谱
subplot(222);
plot(f,10*log10(P1.^2));%将W转为dBm
title('功率谱');
xlabel('f(Hz)');
ylabel('|P1(f)|^2(单位:dBm)');
%第二种方法求功率谱
subplot(223);
pwelch(signal,[],[],[],Fs,'power');
title('Welch功率谱');
%功率谱密度
subplot(224);
pwelch(signal,[],[],[],Fs);
