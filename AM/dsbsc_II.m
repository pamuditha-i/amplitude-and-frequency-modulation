% L.B.I.P Thilakasiri - E/16/367
% EE357 Communication Systems: Laboratary 01 - DSB-SC Section II
clear all;
% general specifications
ac = 1;
am = 0.5;
fs = 1000000;                         
t1 = 0:1/fs:8;  
len = length(t1);
fm = 15000;
fc = 250*1000;
cof = 2*15*1000;          % cut-off freq
l_cof = fc - cof;         % lower cut-off freq
h_cof = fc + cof;         % higher cut-off freq
order = 3;                            
fn = fs/len;
ff = -fs/2:fn:fs/2-fn;

% signal specifications
mt = am*cos(2*pi*fm.*t1);
wc = 2*pi*fc;
ct = cos(wc.*t1);
swm = abs(fftshift(fft(mt)));

% Nonlinear DSB-SC Modulation
x1t = (mt + ct);
x2t = (-mt + ct);

% non-linear device
a = 2;
b = 1;
y1t = a*(x1t) + b*((x1t).^2);
y2t = a*(x2t) + b*((x2t).^2);
zt1 = y1t - y2t;
l_cof1 = l_cof/(fs/2);
h_cof1 = h_cof/(fs/2);

[c,d] = butter(3,([l_cof1 h_cof1]));
st = filter(c,d ,zt1);
%    'HalfPowerFrequency1',(l_cof/(fs/2)),'HalfPowerFrequency2',(h_cof/(fs/2)), ...
%    'SampleRate',fs/2);
%st = filter(d,zt1);
% modulated output
swmm = abs(fftshift(fft(st))); 

% Demodulator
st = st/8;
x3t = (st + ct);
x4t = (-st + ct);
a = 2;
b = 1;
y3t = a*(x3t) + b*((x3t).^2);
y4t = a*(x4t) + b*((x4t).^2);
zt2 = y3t - y4t;

% filter from Section I
cof2 = 30000/(fs/2);               
order2 = 5;
[bb, aa] = butter(order2,cof2);
fot = filter(bb, aa, zt2);
swdm = abs(fftshift(fft(fot))); % demodulated output

figure (1)
subplot(3, 2, 1);
plot(t1,mt);
xlim([0,0.001]);
xlabel('Time (s)')
title("Message Signal");

subplot(3, 2, 3);
plot(t1,st);
xlim([0,0.001]);
xlabel('Time (s)')
title("AM Signal");

subplot(3, 2, 5);
plot(t1,fot);
xlim([0,0.001]);
xlabel('Time (s)')
title("Demodulated Signal");

subplot(3, 2, 2);
plot(ff/1000, abs(swm)/len);
ylim([0,0.3]);
xlabel('Frequency (kHz)')
ylabel('Magnitude')
title("AM Signal Frequency Spectrum");

subplot(3, 2, 4);
plot(ff/1000, abs(swmm)/len);
xlabel('Frequency (kHz)')
ylabel('Magnitude')
title("Modulated Signal Frequency Spectrum");

subplot(3, 2, 6);
plot(ff/1000, abs(swdm)/len);
xlabel('Frequency (kHz)')
ylabel('Magnitude')
title("Demodulated Signal Frequency Spectrum");

