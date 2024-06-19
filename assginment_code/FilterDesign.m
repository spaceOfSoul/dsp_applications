clear all
close all
clc
pkg load signal # 필터 디자인 함수가 들어있는 패키지

# digital filter design
w = linspace(0,10000*pi, 1000);
f = w/(2*pi);

# 아날로그 필터 디자인
# butterwooth filter (지난 주에 디자인한거)
N = 5;
Wc = 2076*pi; # cut-off freq

[b_s,a_s] = butter(N,Wc,'s'); # 아날로그 영역 필터 계수

freq_response = freqs(b_s,a_s,w);

magnitude_res = abs(freq_response);
# db scale로
magnitude_res_db = 20*log10(magnitude_res/max(magnitude_res));

phase_res = angle(freq_response);

# plot
figure;
subplot(2,1,1);
plot(f, magnitude_res,'color', 'b');
title("magnitide");

subplot(2,1,2);
plot(f, phase_res,'color', 'b');
hold on;
title("angle");

b_s = [b_s;0;0;0;0;0];
[z_s,p_s,k] = tf2zp(b_s,a_s); # zero matrix z, pole vector p, gain vector k

figure(2);
zplane(z_s,p_s);
title("s-plane")

#
Ts = 1e-4;
p_z = exp(p_s*Ts);
z_z = [0;0;0;0;0];

figure(3);
zplane(z_z,p_z);
title("z-plane (after smpling)");

[b_z, a_z]=zp2tf(z_z,p_z, k);

freq_response = freqz(b_z,a_z);

magnitude_res = abs(freq_response);
magnitude_res_db = 20*log10(magnitude_res/max(magnitude_res));
phase_res = angle(freq_response);

# plot
figure(4);
subplot(2,1,1);
plot(magnitude_res_db);
title("magnitide (db sclase)");

subplot(2,1,2);
plot(phase_res);
hold on;
title("phase");

# verification => digital filter design

Ts = 1e-4;
fs = 1/Ts;
fm = fs/2;
wm = 2*pi*fm;
Wp = 1404*pi;
Ws = 8268*pi;
rp = 1;
rs = 60;
[N,Wc] = buttord(Wp/wm, Ws/wm, rp, rs);

[b_z2, a_z2] = butter(N, Wc);

[z_z2, p_z2, g_z2] = tf2zp(b_z2, a_z2);
figure(5);
zplane(z_z2, p_z2);

# response check
freq_response = freqz(b_z2,a_z2);

magnitude_res = abs(freq_response);
magnitude_res_db = 20*log10(magnitude_res/max(magnitude_res));
phase_res = angle(freq_response);

# plot
figure(6);
subplot(2,1,1);
plot(magnitude_res_db);
title("magnitide (db scale)");

subplot(2,1,2);
plot(phase_res);
hold on;
title("phase");
