% L.B.I.P Thilakasiri - E/16/367
% EE357 Communication Systems: Laboratary 02 - FM Zero-Crossing Demodulation

clear all;
close all;

% General Specifications
fm = 25;      % Message Freq
fc = 300;     % Carrier Freq
fs = 50000;    % Sampling Freq
t1 = 0:1/fs:2;  
len = length(t1);
ac = 1;         % Carrier Amplitude
am = 1;         % Message Amplitude
fn = fs/len;
ff = -fs/2:fn:fs/2-fn;
del_f = 20; 
beta = del_f/fm;       % Beta Value
ct = ac*cos(2*pi*fc.*t1);   % Carrier Signal
mt = am*sin(2*pi*fm.*t1);   % Message Signal
% FM Signal
fmt = ac*cos(2*pi*fc.*t1 - beta*cos(2*pi*fm.*t1));

% Zero Crossing Capture
crossings = zeros();
for i = 1:len
    if((fmt(i)<0) && (fmt(i+1)>0))
        crossings(i) = i/fs;
    end
end

% Pulse Generator
j = 1; len_z = length(crossings);
tau = 25;    % Randomly Chosen
pul_train = zeros();

% Pulse Generation with a width of Tau
while j <= len_z
    if crossings(j) ~= 0
        k = 0;
        while k < tau
            pul_train(j + k) = 1;
            k = k + 1;
        end
        j = j + k;
    end
    j = j + 1;
end

% LPF Butterworth Filter
[b,a] = butter(3,fm/(fs/2));
lpf_fm = filter(b,a,pul_train);
demod_fm = lpf_fm - mean(lpf_fm);
zeroc = zeros(1,len_z); 

% Plots
figure(1)
plot(t1,mt)
xlim([0,0.5]);
grid on;
title("Message Signal");
xlabel('Time (s)')
ylabel('Amplitude')

figure(2)
plot(t1,fmt)
xlim([0,0.025]);
hold on;
plot(crossings,zeroc,'r*');
grid on;
title("FM Signal & Zero Crossings");
xlabel('Time (s)')
ylabel('Amplitude')

figure(3)
plot(t1,pul_train(1:end-3))
xlim([0,0.025]);
grid on;
title("Pulse Train");
xlabel('Time (s)')
ylabel('Amplitude')

figure(4)
plot(t1,demod_fm(1:end-3))
ylim([-0.02,0.02]);
xlim([0,0.5]);
grid on;
title("Demodulated FM Signal");
xlabel('Time (s)')
ylabel('Amplitude')
