clear all
close all
fclose all
clc

pkg load signal;

%% Description:
Wp = 1404*pi;
Ws = 8268*pi;
rp = 1;
rs = 60;
Ts = 0.0001;
w = linspace(0, 10000*pi, 1000);
f = w/(2*pi);


## Step 1. Pre-warping
pWp = 2*tan(Wp*Ts/2)/Ts;
pWs = 2*tan(Ws*Ts/2)/Ts;

## Step 2. Design analogue chebyshev filter
[N, Wc] = cheb1ord(pWp, pWs, rp, rs, "s")
[b, a] = cheby1(N, rp, Wc, "s")

#freq_resp = freqs(b,a,w);
b = [b, 0, 0, 0];
[s_z, s_p, g] = tf2zp(b, a);
figure(1), zplane(s_z,s_p);

## Step 3. Digital converting
z_p = (1 + s_p*Ts/2)./(1 - s_p*Ts/2);
z_z = [-1,-1,-1];

[z_b, z_a] = zp2tf(z_z, z_p, 1);

## verification
freq_resp_s = freqs(b(1), a, w);
freq_resp_z = freqz(z_b, z_a);

## response analysis in s-plane
mag_resp = abs(freq_resp_s);
mag_resp = mag_resp/max(mag_resp);
s_mag_resp_dB = 20*log10(mag_resp);

mag_resp = abs(freq_resp_z);
mag_resp = mag_resp/max(mag_resp);
z_mag_resp_dB = 20*log10(mag_resp);

figure(2),
subplot(1,2,1), plot(w, s_mag_resp_dB, 'linewidth', 3);
subplot(1,2,2), plot(z_mag_resp_dB, 'linewidth', 3);

