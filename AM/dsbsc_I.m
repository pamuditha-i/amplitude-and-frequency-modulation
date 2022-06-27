% L.B.I.P Thilakasiri - E/16/367
% EE357 Communication Systems: Laboratary 01 - DSB-SC Section I

% general specifications
ac = 1;
am = 0.5;
fs = 1000000;                         
t1 = 0:1/fs:8/10000;  
len = length(t1);
fm = 15000;
fc = 250*1000;
fn = fs/len;
ff = -fs/2:fn:fs/2-fn;

% signal specifications
mt = am*cos(2*pi*fm.*t1);
wc = 2*pi*fc;
ct = ac*cos(wc.*t1);
st = ac.*(mt).*cos(wc.*t1);

sw1 = abs(fftshift(fft(mt)));
sw2 = abs(fftshift(fft(st)));
dmt = 2*st.*ct;                        
sw3 = abs(fftshift(fft(dmt)));

%filter
%cof is taken from 2*pi*(2*15*1000) 
cof = 30000/(fs/2);         % cut-off freq        
order = 5;
[b,a] = butter(order,cof);

%filter output signal t-domain 
fot = filter(b,a,dmt); 
sw4 = abs(fftshift(fft(fot)));

figure (1)
subplot(4, 2, 1);
plot(t1,mt);
xlim([0,4/10000]);
xlabel('Time (s)')
title("Message Signal");

subplot(4, 2, 3);
plot(t1,st);
xlim([0,4/10000]);
xlabel('Time (s)')
title("AM Signal");

subplot(4, 2, 5);
plot(t1,dmt);
xlim([0,4/10000]);
xlabel('Time (s)')
title("Demodulated Signal");

subplot(4, 2, 7);
plot(t1,fot);
xlim([0,4/10000]);
xlabel('Time (s)')
title("Filter Output Signal");

subplot(4, 2, 2);
plot(ff/1000, abs(sw1)/(fs));
xlabel('Frequency (kHz)')
ylabel('Magnitude')
title("AM Signal Frequency Spectrum");

subplot(4, 2, 4);
plot(ff/1000, abs(sw2)/len);
xlabel('Frequency (kHz)')
ylabel('Magnitude')
title("Modulated Signal Frequency Spectrum");

subplot(4, 2, 6);
plot(ff/1000, abs(sw3)/len);
xlabel('Frequency (kHz)')
ylabel('Magnitude')
title("Demodulated Signal Frequency Spectrum");

subplot(4, 2, 8);
plot(ff/1000, abs(sw4)/len);
xlabel('Frequency (kHz)')
ylabel('Magnitude')
title("Filter Output Signal Frequency Spectrum");
