% L.B.I.P Thilakasiri - E/16/367
% EE357 Communication Systems: Laboratary 01 - DSB-SC Section III

% general specifications
ac = 1;
am = 0.5;
fs = 1000000;                         
t1 = 0:1/fs:8/10000;  
len = length(t1);
fm = 3000;
fc = 250*1000;
fn = fs/len;
ff = -fs/2:fn:fs/2-fn;

% signal specifications
mt = am*cos(2*pi*fm.*t1);              
wc = 2*pi*fc;
ct = ac*cos(wc.*t1);
st = ac.*(mt).*cos(wc.*t1);

% vector to save the index values
ind = zeros(1,50);
% vector to store db difference between i/p & o/p signals
db = zeros(1,50);

figure(1)
plot(t1,mt,'r');
hold on;

for i = 0:(pi/50):pi
    x = (round(i*50/pi));
    ind(x+1) = x;
    ct2 = ac*cos(wc.*t1 + i);
    et = 2*ct2.*st;
    cof = 30000/(fs/2);               
    order = 5;
    [b,a] = butter(order,cof);
    fot = filter(b,a,et);    %filter output signal t-domain 
    plot(t1,fot);
    legend("Original Message Signal");
    hold on;
    db(x+1) = 20*log10(1/max(fot));
end

% percentage shifts and db difference plots
figure(2)
plot(ind, db);
xlabel('Number of Shifts')
ylabel('db')
title("Attenuation of Output Maximum Value in db");
grid on;
