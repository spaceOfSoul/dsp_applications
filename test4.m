clear all
close all
fclose all
clc

pkg load signal

%% Digital filter design
w = linspace(0, 10000*pi, 1000);

% Step 1. Analog filter design (Butterworth)
N = 5;
wc = 2076*pi;
[b_s, a_s] = butter(N, wc, "s");

freq_resp = freqs(b_s, a_s, w);
magRes = abs(freq_resp);
magRes_dB = 20*log10(magRes/max(magRes));
phaRes = angle(freq_resp);

figure(1),
subplot(1,2,1), plot(w, magRes_dB, 'linewidth', 3)
subplot(1,2,2), plot(w, phaRes, 'linewidth', 3)

b_s = [b_s,0,0,0,0,0];
[z_s, p_s, g] = tf2zp(b_s, a_s);  % output: zero, pole, fitler gain

figure(2), zplane(z_s, p_s);
axis([-12000 12000 -12000 12000]);

% Step 2. Filter conversion via Impluse Invariant Method
Ts = 0.0001;
p_z = exp(p_s*Ts);
z_z = [0;0;0;0;0];
figure(3), zplane(z_z, p_z);

[b_z, a_z] = zp2tf(z_z, p_z, g);

freq_resp = freqz(b_z, a_z);
magRes = abs(freq_resp);
magRes_dB = 20*log10(magRes/max(magRes));
phaRes = angle(freq_resp);

figure(4),
subplot(1,2,1), plot(magRes_dB, 'linewidth', 3)
subplot(1,2,2), plot(phaRes, 'linewidth', 3)

% Step 3 Verification => Digital filter design
Ts = 0.0001;
fs = 1/Ts;
fm = fs/2;
wm = 2*pi*fm;
wp = 1404*pi;
ws = 8268*pi;
rp = 1;
rs = 60;
#[N, wc]= buttord(wp, ws, rp, rs, "s");
[N, wc]= buttord(wp/wm, ws/wm, rp, rs);
[b_z2, a_z2] = butter(N,wc);

[z_z2, p_z2, g_z2] = tf2zp(b_z2, a_z2);
figure, zplane(z_z2, p_z2);

freq_resp = freqz(b_z2, a_z2);
magRes = abs(freq_resp);
magRes_dB = 20*log10(magRes/max(magRes));
phaRes = angle(freq_resp);

figure,
subplot(1,2,1), plot(magRes_dB, 'linewidth', 3)
subplot(1,2,2), plot(phaRes, 'linewidth', 3)

























