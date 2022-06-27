% L.B.I.P Thilakasiri - E/16/367
% EE357 Communication Systems: Laboratary 02 - Baseband Delay FM Demodulator 

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
ct = ac*cos(2*pi*fc.*t1);   % Carrier Signal
mt = am*cos(2*pi*fm.*t1);   % Message Signal

% FM Signal & Down Conversion
fmt = ac*cos(2*pi*fc.*t1 + beta*sin(2*pi*fm.*t1)); 
yit = fmt.*cos(2*pi*fc.*t1);
yqt = fmt.*sin(2*pi*fc.*t1);

% Butterworth Filter Specifications
[b,a] = butter(10,1*fc/(fs/2));

% Filter Outputs
yitf = filter(b,a,yit);
yqtf = filter(b,a,yqt);

% Failed Attempt - Filter Design
% order_n = 10;
% fs2 = 10000;
% cof = fc/(fs/2);
% fil = designfilt('lowpassfir','FilterOrder',order_n,'CutoffFrequency',cof, ...
%        'DesignMethod','window','Window',{@kaiser,15},'SampleRate',fs2);
% yitf = filter(fil,yit);
% yqtf = filter(fil,yqt);

% Complex FM Baseband Signal
yt = yitf + 1i*yqtf;

% Time Delay Block
n=1;            % No. of Delay units
yy = zeros(size(yt));
yy(n+1:end) = yt(1:end-n);
delay_yt = yy;  % After the Delay

conj_yt = conj(delay_yt);
wt = yt.*conj_yt;
wn = wt;        % wn Eqn Given in the Lab Sheet
vn = angle(wn); % vn Eqn Given in the Lab Sheet
length(t1)
length(mt)

% Plots
figure(1)
subplot(3,1,1);
plot(t1,mt);
xlim([0,0.05]);
title("Message Signal");
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,1,2);
plot(t1,fmt);
xlim([0,3/500]);
title("FM Signal");
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,1,3);
plot(t1,vn);
xlim([0,0.05]);
title("Demodulated Signal");
xlabel('Time (s)')
ylabel('Amplitude')
grid on;