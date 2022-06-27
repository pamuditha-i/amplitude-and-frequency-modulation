% L.B.I.P Thilakasiri - E/16/367
% EE357 Communication Systems: Laboratary 01 - Square Law Demodulation

clear all;
% general specifications
ka = {0.5,0.7,1};
fm = {500,1000,1000};
fc = {2000,5000,5000};
ac = 1;
fs = 100000;                         
t1 = 0:1/fs:0.05;
len = length(t1);

% for loop for carrier, message and modulated plots
for i = 1:3
    mt = cos(2*pi*fm{i}.*t1);
    wc = 2*pi*fc{i};
    ct = ac*cos(wc.*t1);
    st = ac*(1 + ka{i}.*mt).*cos(wc.*t1);
    
    figure (i)
    subplot(3, 1, 1);
    plot(t1,mt);
    xlim([0,0.01]);
    xlabel('Time (s)')
    title("Message Signal @ ka = "+ num2str(ka{i}) +", fm = "+ num2str(fm{i}/1000) +"kHz , fc = "+ num2str(fc{i}/1000) +"kHz");
    
    subplot(3, 1, 2);
    plot(t1,ct);
    xlim([0,0.01]);
    xlabel('Time (s)')
    title("Carrier Signal @ ka = "+ num2str(ka{i}) +", fm = "+ num2str(fm{i}/1000) +"kHz , fc = "+ num2str(fc{i}/1000) +"kHz");
    
    subplot(3, 1, 3);
    plot(t1,st);
    xlim([0,0.01]);
    xlabel('Time (s)')
    title("AM Signal @ ka = "+ num2str(ka{i}) +", fm = "+ num2str(fm{i}/1000) +"kHz , fc = "+ num2str(fc{i}/1000) +"kHz");
end

% for loop for modulated frequency spectrums 
for i = 1:3
    mt = cos(2*pi*fm{i}.*t1);
    wc = 2*pi*fc{i};
    ct = ac*cos(wc.*t1);
    st = ac*(1 + ka{i}.*mt).*cos(wc.*t1);
    sw = fftshift(fft(st));
    fn = fs/len;
    ff = -fs/2:fn:fs/2-fn;
    
    figure (4)
    subplot(3, 1, i);
    plot(ff/1000, abs(sw)/len);
    xlabel('Frequency (kHz)')
    ylabel('|S(w)|')
    title("S(w) @ ka = "+ num2str(ka{i}) +", fm = "+ num2str(fm{i}/1000) +"kHz , fc = "+ num2str(fc{i}/1000) +"kHz");
end

% at the end of end of the squarer output
% new specifications
%p_mag = {1,1,1};
%s_mag = {30,60,60};
%order = {80,30,30};
order = {200,300,300};
pass_f = {1000,1900,1900};
stop_f = {1200,2100,2200};
fs2 = 50000;

% erroneous pass and stop band frequencies
%pass_f = {1500,5500,5000};
%stop_f = {2000,6000,5500};



% for loop for original message and demodulated message signals 
for i = 1:3
    mt = cos(2*pi*fm{i}.*t1);
    sw2 = abs(fftshift(fft(mt)));
    wc = 2*pi*fc{i};
    ct = ac*cos(wc.*t1);
    st = ac*(1 + ka{i}.*mt).*cos(wc.*t1);
    st = (st.^2).*2;
    fn = fs/len;
    ff = -fs/2:fn:fs/2-fn;
 
    %filter specifications
    %p_mag_n = p_mag{i};
    %s_mag_n = s_mag{i};
    order_n = order{i};
    pass_f_n = pass_f{i};
    stop_f_n = stop_f{i};
    cof = (pass_f_n + stop_f_n)/2;      % cut-off freq
    fil = designfilt('lowpassfir','FilterOrder',order_n,'CutoffFrequency',cof, ...
       'DesignMethod','window','Window',{@kaiser,15},'SampleRate',fs2);
    %fil = fir1(order_n,cof/(fs/2));
   
    % filter outputs
    %dmt = filter(fil,1,st);
    dmt = filter(fil,st);
    dmt =(sqrt(dmt)-1);     
    dmt = dmt/ka{i};
    sw3 = abs(fftshift(fft(dmt)));
   
    figure (i+4)
    subplot(4, 1, 1);
    plot(t1,mt);
    hold on;
    xlim([0,0.01]);
    xlabel('Time (s)')
    title("Message Signal @ ka = "+ num2str(ka{i}) +", fm = "+ num2str(fm{i}/1000) +"kHz , fc = "+ num2str(fc{i}/1000) +"kHz");
    
    subplot(4, 1, 2);
    plot(ff/1000, abs(sw2)/len);
    xlim([-10,10]);
    xlabel('Frequency (kHz)')
    ylabel('|S(w)|')
    title("S(w) @ ka = "+ num2str(ka{i}) +", fm = "+ num2str(fm{i}/1000) +"kHz , fc = "+ num2str(fc{i}/1000) +"kHz");

    subplot(4, 1, 3);
    plot(t1,dmt);
    xlim([0,(0.01)]);
    ylim([-1.,1.]);
    xlabel('Time (s)')
    ylabel('Amplitude')
    title("Demodulated Signal @ ka = "+ num2str(ka{i}) +", fm = "+ num2str(fm{i}/1000) +"kHz , fc = "+ num2str(fc{i}/1000) +"kHz");

    subplot(4, 1, 4);
    plot(ff/1000, abs(sw3)/len);
    xlim([-10,10]);
    xlabel('Frequency (kHz)')
    ylabel('|S(w)|')
    title("S(w) @ ka = "+ num2str(ka{i}) +", fm = "+ num2str(fm{i}/1000) +"kHz , fc = "+ num2str(fc{i}/1000) +"kHz");
end
