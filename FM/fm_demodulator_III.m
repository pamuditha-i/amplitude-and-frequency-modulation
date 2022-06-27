% L.B.I.P Thilakasiri - E/16/367
% EE357 Communication Systems: Laboratary 02 - FM Arctangent Demodulator

clear all;
close all;

% General Specifications
fm = 1000;      % Message Freq
fc = 20000;     % Carrier Freq
fs = 100000;     % Sampling Freq
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
mt = am*cos(2*pi*fm.*t1);   % Sinusoidal Message Signal
% FM Signal
fmt = ac*cos(2*pi*fc.*t1 + beta*sin(2*pi*fm.*t1));

% BPF Butterworth Filter Specifications
low_f = (fc - fm/2); 
high_f = (fc + fm/2); 
w_l = low_f/(fs/2);
w_h = high_f/(fs/2);
[b,a] = butter(3,[w_l,w_h]);

filt_fmt = filter(b,a,fmt);
xqt = filt_fmt.*sin(2*pi*fc.*t1);
xit = filt_fmt.*cos(2*pi*fc.*t1);

% LPF Butterworth Filter Specifications
[d,c] = butter(10,1*fc/(fs/2));

% q(t) & i(t) Given in the Lab Sheet
qt = filter(d,c,xqt);
it = filter(d,c,xit);

% Four-quadrant Inverse Tangent
x_atan = atan2(qt,it);

demod_mt = diff(x_atan)/(2*pi*del_f);   % first derivative

% Plots
figure(1)
subplot(3,1,1);
plot(t1,mt);
xlim([0,0.05]);
%ylim([-1,1]);
title("Message Signal");
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,1,2);
plot(t1,fmt);
xlim([0,3/500]);
%ylim([-1,1]);
title("FM Signal");
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,1,3);
plot(t1(1:end-1),demod_mt);
xlim([0,0.05]);
ylim([-0.003,0.003]);
title("Demodulated Signal");
xlabel('Time (s)')
ylabel('Amplitude')
grid on;

% (b) for a mix of the previous 1kHz signal
% & a 10kHz signal

fm2 = 10000;
mst = am*cos(2*pi*fm2.*t1); 
%fmst = fmmod(mst,fc,fs,fm2);  % FM Signal
fmst = ac*cos(2*pi*fc.*t1 + beta*sin(2*pi*fm2.*t1));

% BPF Butterworth Filter Specifications
low_f2 = (fc - fm2/2); 
high_f2 = (fc + fm2/2); 
w_l2 = low_f2/(fs/2);
w_h2 = high_f2/(fs/2);
[b2,a2] = butter(5,[w_l2,w_h2]);

filt_fmst = filter(b2,a2,fmst);
xqt2 = filt_fmst.*sin(2*pi*fc.*t1);
xit2 = filt_fmst.*cos(2*pi*fc.*t1);

% LPF Butterworth Filter Specifications
[d2,c2] = butter(10,1*fc/(fs/2));

% q(t) & i(t) Given in the Lab Sheet
qt2 = filter(d2,c2,xqt2);
it2 = filter(d2,c2,xit2);

% Four-quadrant Inverse Tangent
x_atan2 = atan2(qt2,it2);

demod_mt2 = diff(x_atan2)/(2*pi*del_f);   % first derivative

% Plots
figure(2)
subplot(3,1,1);
plot(t1,mst);
xlim([0,0.005]);
%ylim([-1,1]);
title("Message Signal");
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,1,2);
plot(t1,fmst);
xlim([0,3/500]);
%ylim([-1,1]);
title("FM Signal");
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,1,3);
plot(t1(1:end-1),demod_mt2);
xlim([0,0.005]);
ylim([-0.002,0.002]);
title("Demodulated Signal");
xlabel('Time (s)')
ylabel('Amplitude')
grid on;