clear all
close all
fclose all
clc
pkg load signal

%% Filter analysis
# condition
w  = linspace(0, 10000*pi, 1000);
f  = w/(2*pi);

Wp = 1404*pi;   # frequency in passband
Ws = 8268*pi;   # frequency in stopband
rp = 1;         # ripple in Passband
rs = 60;        # ripple in Stopband

# butterworth filter design by hand
N = 5;
Wc = 2076*pi;
[b, a] = butter(N, Wc, 's');    # butterworth filter
freq_resp = freqs(b,a,w);       # butterworth filter frequency response

magRes = abs(freq_resp);
magRes_dB = 20*log10(magRes/max(magRes));
phaRes = angle(freq_resp);

figure(1),
subplot(2,1,1),
plot(f, magRes, 'linestyle', ':', 'linewidth', 2, 'color', 'b');
subplot(2,1,2),
plot(f, magRes_dB, 'linestyle', ':', 'linewidth', 2, 'color', 'b');

# butterworth filter design by Octave
[N, Wc] = buttord(Wp, Ws, rp, rs, 's');
[b, a] = butter(N, Wc, 's');    # butterworth filter
freq_resp = freqs(b,a,w);       # butterworth filter frequency response

magRes = abs(freq_resp);
magRes_dB = 20*log10(magRes/max(magRes));
phaRes = angle(freq_resp);

figure(1),
subplot(2,1,1), hold on,
plot(f, magRes, 'linestyle', '-', 'linewidth', 2, 'color', 'b');
subplot(2,1,2), hold on,
plot(f, magRes_dB, 'linestyle', '-', 'linewidth', 2, 'color', 'b');









# chebyshev filter design by hand
N  = 4;
Wp = 1404*pi;
[b, a] = cheby1(N, rp, Wc, 's');
freq_resp = freqs(b,a,w);

magRes = abs(freq_resp);
magRes_dB = 20*log10(magRes/max(magRes));
phaRes = angle(freq_resp);

figure(1),
subplot(2,1,1), hold on,
plot(f, magRes, 'linestyle', ':', 'linewidth', 2, 'color', 'r');
subplot(2,1,2), hold on,
plot(f, magRes_dB, 'linestyle', ':', 'linewidth', 2, 'color', 'r');

# chebyshev filter design by Octave
[N, Wc] = cheb1ord(Wp, Ws, rp, rs, 's');
[b, a] = cheby1(N, rp, Wc, 's');
freq_resp = freqs(b,a,w);

magRes = abs(freq_resp);
magRes_dB = 20*log10(magRes/max(magRes));
phaRes = angle(freq_resp);

figure(1),
subplot(2,1,1), hold on,
plot(f, magRes, 'linestyle', '-', 'linewidth', 2, 'color', 'r');
subplot(2,1,2), hold on,
plot(f, magRes_dB, 'linestyle', '-', 'linewidth', 2, 'color', 'r');

# Elliptic filter design by Octave
[N, Wc] = ellipord(Wp, Ws, rp, rs, 's');
[b, a] = ellip(4, rp, rs, Wc, 's');
freq_resp = freqs(b,a,w);

magRes = abs(freq_resp);
magRes_dB = 20*log10(magRes/max(magRes));
phaRes = angle(freq_resp);

figure(1),
subplot(2,1,1), hold on,
plot(f, magRes, 'linewidth', 2, 'color', 'm');
subplot(2,1,2), hold on,
plot(f, magRes_dB, 'linewidth', 2, 'color', 'm');
































