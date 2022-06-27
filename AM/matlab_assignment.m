% L.B.I.P Thilakasiri - E/16/367
% EE357 Communication Systems: Laboratary 01 - MATLAB EXERCISE

clear all 

% general specifications
fs = 10000;                        
t1 = 0:1/fs:1-1/fs;                 
fc1 = 200;                          
ac1 = 2;                           
len = length(t1);

% modulation section and specifications
ac = ac1; t = t1; k = 1; fm1 = 10; am1 = 1;
vdc = 1; omegam = 2*pi*fm1; omegac = 2*pi*fc1;
u = {0,0.25,0.5,1}; 
fn = fs/len;
ff = -fs/2:fn:fs/2-fn;
%u = 1;

for i = 1:4
    
    % carrier signal specifications = c_wav1
    c_wav1 = ac1*sin(2*pi*fc1*t1);
    figure (i)
    subplot(3, 2, 1);
    plot(t1,c_wav1);
    xlim([0,0.1]);
    ylim([-2.5,2.5]);
    title("Carrier Signal @ u = "+ num2str(u{i}));
    xlabel('Time (s)')
    ylabel('Amplitude')

    % message signal specifications
    
    m_wav1 = am1*sin(2*pi*fm1*t1);
    subplot(3, 2, 3)
    plot(t1,m_wav1);
    title("Message Signal @ u = "+ num2str(u{i}));
    xlabel('Time (s)')
    ylabel('Amplitude')
    
    xam = k*ac*vdc*(1 + u{i}*cos(omegam*t)).*cos(omegac*t);
    subplot(3, 2, 5);
    plot(t1,xam);
    title("AM Signal @ u = "+ num2str(u{i}));
    xlabel('Time (s)')
    ylabel('Amplitude')
    
    f_c_wav1 = fftshift(fft(c_wav1));
    f_m_wav1 = fftshift(fft(m_wav1));
    f_xam = fftshift(fft(xam));

    subplot(3, 2, 2)
    plot(ff, abs(f_c_wav1)/len);
    xlim([-250,250]);
    title("Carrier Signal @ u = "+ num2str(u{i}));
    xlabel('Frequency (Hz)')
    ylabel('Magnitude')

    subplot(3, 2, 4)
    plot(ff, abs(f_m_wav1)/len);
    xlim([-50,50]);
    ylim([0,0.6]);
    title("Message Signal @ u = "+ num2str(u{i}));
    xlabel('Frequency (Hz)')
    ylabel('Magnitude')

    subplot(3, 2, 6)
    plot(ff, abs(f_xam)/len);
    xlim([-300,300]);
    title("AM Signal @ u = "+ num2str(u{i}));
    xlabel('Frequency (Hz)')
    ylabel('Magnitude') 
end


% square wave section
figure(2+i);
subplot(3,2,1)      % plotting the carrier signal
plot(t1,c_wav1);
xlim([0,0.1]);
ylim([-2.5,2.5]);
title('Carrier Signal')
xlabel('Time (s)')
ylabel('Amplitude')

fsq = 10; % square wave frequency
sq = square(2*pi*fsq.*t1);
subplot(3,2,3)
plot(t1,sq);
ylim([-1.2,1.2])
title('Square Signal')
xlabel('Time (s)')
ylabel('Amplitude')

swc = fftshift(fft(c_wav1));
subplot(3,2,2);
plot(ff, abs(f_c_wav1)/len);
xlim([-250,250]);
title('Carrier Signal'); 

swsq = fftshift(fft(sq));
subplot(3,2,4);
plot(ff,abs(swsq)/len);
ylim([0,0.65]);
xlim([-2000,2000]);
title('Frequency Spectrum of Square Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

u = 1;
xam2 = k*ac*vdc*(1 + u.*sq).*cos(omegac*t);
subplot(3,2,5)
plot(t1,xam2);
ylim([-5,5]);
title('Modulated Signal')
xlabel('Time (s)')
ylabel('Magnitude')

swmd = fftshift(fft(xam2));
subplot(3,2,6);
plot(ff,abs(swmd)/len);
xlim([-2000,2000]);
title('Frequency Spectrum of Modulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

% envelope detection
figure(3+i);
ac = ac1; t = t1; m_wav = m_wav1; k = 1;
vdc = 1; omegam = 2*pi*fm1; omegac = 2*pi*fc1;
plot(t1,xam);
ylim([-4.5,4.5]);
xlabel('Time (s)');
ylabel('Xam (V)');
grid on;
hold on;
enve = k*vdc*ac*(1+u.*cos(2*pi*fm1*t));
plot(t,enve,'r');
legend('Modulated Signal','Envelope Detector')