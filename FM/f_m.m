% L.B.I.P Thilakasiri - E/16/367
% EE357 Communication Systems: Laboratary 02 - Frequency Modulation

% General Specifications
fc = 200;      % carrier freq
fm = 10;       % message freq
fs = 10000;                          
t1 = 0:1/fs:4;  
len = length(t1);

% beta values for a) b) c) d) e) f)
beta = {0,0.25,0.5,1.0,2.405,3.838}; 
kf = 1;
ac = 1;
q = {'a)','b)','c)','d)','e)','f)'};
fn = fs/len;
ff = -fs/2:fn:fs/2-fn;

ct = ac*cos(2*pi*fc.*t1);

for i = 1:6
    
    % message signal specifications
    Am = beta{i}*fm/kf;
    fprintf('Am value for question %s: %d \n', q{i},Am);
    mt = Am*cos(2*pi*fm.*t1);
    
    % FM signal specifications
    fmt = ac*cos(2*pi*fc.*t1 + beta{i}*sin(2*pi*fm.*t1));
    figure (i)
    plot(t1,fmt);
    xlim([0,0.3]);
    title("FM signal for "+ (q{i}));
    xlabel('Time (s)')
    ylabel('Amplitude')
    grid on;

end


for i = 1:6
    
    % message signal specifications
    Am = beta{i}*fm/kf;
    mt = Am*cos(2*pi*fm.*t1); 
    % FM signal specifications
    fmt = ac*cos(2*pi*fc.*t1 + beta{i}*sin(2*pi*fm.*t1));
    figure (i+6)
    subplot(2, 1, 1);
    plot(t1,fmt);
    xlim([0,0.3]);
    title("FM(t) for "+ (q{i}));
    xlabel('Time (s)')
    ylabel('Amplitude')
    
    fmf = fftshift(fft(fmt));
    
    subplot(2, 1, 2);
    plot(ff/1000, abs(fmf)/len);
    xlim([-0.4,0.4]);
    xlabel('Frequency (kHz)')
    ylabel('|FM(f)|')
    title("FM(f) for "+ (q{i}));
    grid on;

end

beta_q4 = 4;
fm = {20,25,50,65};

for i = 1:4
    
    % message signal specifications
    Am = beta_q4*fm{i}/kf;
    mt = Am*cos(2*pi*fm{i}.*t1); 
    % FM signal specifications
    fmt = ac*cos(2*pi*fc.*t1 + beta{i}*sin(2*pi*fm{i}.*t1));
    figure (i+12)
    subplot(2, 1, 1);
    plot(t1,fmt);
    xlim([0,0.4]);
    title("FM(t) @ beta = "+ beta_q4 +" and fm = "+ num2str(fm{i})+"Hz");
    xlabel('Time (s)')
    ylabel('Amplitude')

    fmf = fftshift(fft(fmt));
    
    subplot(2, 1, 2);
    plot(ff/1000, abs(fmf)/len);
    xlabel('Frequency (kHz)')
    ylabel('|FM(f)|')
    title("FM(f) @ beta = "+ beta_q4 +" and fm = "+ num2str(fm{i})+"Hz");
    grid on;

end