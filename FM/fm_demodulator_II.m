% L.B.I.P Thilakasiri - E/16/367
% EE357 Communication Systems: Laboratary 02 - Demodulation Using Differentiation

% (a) 1 kHz sinusoidal message signal

clear all;
close all;

% General Specifications
fm = 1000;      % Message Freq
fc = 20000;     % Carrier Freq
fs = 500000;    % Sampling Freq
t1 = 0:1/fs:2;  
len = length(t1);
ac = 1;         % Carrier Amplitude
am = 1;         % Message Amplitude
fn = fs/len;
ff = -fs/2:fn:fs/2-fn;
beta = 1;       % Beta Value
kf = 1;
del_f = kf*am; 
ct = ac*cos(2*pi*fc.*t1);   % Carrier Signal
mt = am*cos(2*pi*fm.*t1);   % Message Signal
% FM Signal
fmt = ac*cos(2*pi*fc.*t1 + beta*sin(2*pi*fm.*t1)); 

% Envelope Detection Using Hilberts Transform
dif_fmt = diff(fmt)/(fc);   % first derivative
hil_mt = abs(hilbert(dif_fmt)); 
demod_fm = hil_mt - mean(hil_mt); % Remove DC
amp = max(demod_fm); % Normalizing

% Plots
figure(1)
subplot(4,1,1)
plot(t1,mt)
xlim([0,1/100])
title("Message Signal");
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,2)
plot(t1,fmt);
xlim([0,1/100])
title("FM Signal");
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,3)
plot(t1(1:end-1),dif_fmt);
hold on;
plot(t1(1:end-1),hil_mt,'r')
xlim([0,1/100])
ylim([-2/100000,2/100000])
title("Differentiated Signal & Envelope in Red");
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,4)
plot(t1(1:end-1),demod_fm/amp);
xlim([0,1/100])
ylim([-1,1])
title("Normalized Demodulated FM Signal");
xlabel('Time (s)')
ylabel('Amplitude')


% (b) a 1 kHz Rectangular Pulse Train

w = 0.0005;                  % Width of a Pulse                  
t2 = 0 : 1/fs : 0.01;        % Signal Evaluation Time
d = 0 : 1/1e3 : 0.01;        % Pulse Delay Times  
mst = pulstran(t2,d,@rectpuls,w); % Sqaure Pulse Train

% int_mst = cumtrapz(mst);
% fmst = ac*cos(2*pi*fc.*t2 + 2*pi*del_f.*int_mst); 
fmst = fmmod(mst,fc,fs,fm);  % FM Signal

dif_fmst = diff(fmst)/fc;   % first derivative
hil_mst = abs(hilbert(dif_fmst)); % Envelope Detection
demod_fmst = hil_mst - mean(hil_mst); % Remove DC
amp_mst = max(demod_fmst);

% Plots
figure(2)
subplot(4,1,1);
plot(t2,mst);
xlim([0,5/1000])
title("Message Signal");
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,2);
plot(t2,fmst);
xlim([0,5/1000])
title("FM Signal");
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,3);
plot(t2(1:end-1),dif_fmst);
hold on;
plot(t2(1:end-1),hil_mst,'r') 
xlim([0,5/1000])
ylim([-2/100000,2/100000])
title("Differentiated Signal & Envelope in Red");
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,4);
plot(t2(1:end-1),demod_fmst/amp_mst);
xlim([0,5/1000])
title("Normalized Demodulated FM Signal");
xlabel('Time (s)')
ylabel('Amplitude')
grid on;
