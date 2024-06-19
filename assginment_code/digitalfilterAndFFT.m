clear all;
close all;
clc;

% 20191057 Digital Filter
T = 0.032;
fs = 16000;
t = 0:1/fs:T;

% signal generation
f1 = 1000;
f2 = 4000;
s1 = cos(2*pi*f1*t);
s2 = cos(2*pi*f2*t);
s = s1+s2;

% signal display
figure,
subplot(3,1,1), plot(t,s1);
title('s1');
xlabel('time [sec]');
ylabel('amplitude');
axis([t(1)-5/fs, t(end)+5/fs, -2.1, 2.1]);

subplot(3,1,2), plot(t,s2);
title('s2');
xlabel('time [sec]');
ylabel('amplitude');
axis([t(1)-5/fs, t(end)+5/fs, -2.1, 2.1]);

subplot(3,1,3), plot(t,s);
title('s');
xlabel('time [sec]');
ylabel('amplitude');
axis([t(1)-5/fs, t(end)+5/fs, -2.1, 2.1]);

% FFT
nLeng = length(s);
N = 1024; % FFT 관점에서 N은 항상 2^m, 그리고 17보다 커야함. 최소 2^5승부터.

S1 = fft(s1, N);
S2 = fft(s2, N);
S = fft(s, N);
fbins = fs/N;

mag_S1 = abs(S1);
pha_S1 = angle(S1);
mag_S2 = abs(S2);
pha_S2 = angle(S2);
mag_S = abs(S);
pha_S = angle(S)

figure;
subplot(3,1,1), plot(mag_S1);
title('s1');
xlabel('frequency [kHz]');
ylabel('magnitude');
axis([0 1025 -0.1 max(mag_S1)*1.1]);
xticks([0:128:1025]);
xticklabels({'0','2','4','6','8','6','4','2','0'});

subplot(3,1,2);
plot(mag_S2);
title('s2');
xlabel('frequency [kHz]');
ylabel('magnitude');
axis([0 1025 -0.1 max(mag_S2)*1.1]);
xticks([0:128:1025]);
xticklabels({'0','2','4','6','8','6','4','2','0'});

subplot(3,1,3);
plot(mag_S);
title('s');
xlabel('frequency [kHz]');
ylabel('magnitude');
axis([0 1025 -0.1 max(mag_S)*1.1]);
xticks([0:128:1025]);
xticklabels({'0','2','4','6','8','6','4','2','0'});

figure,
subplot(3,1,1), plot(pha_S1);
title('s1 phase');
xlabel('frequency [Hz]');
ylabel('phase [rad]');
axis([0 1025 -pi-0.2 pi+0.2])
xticks([0:128:1025]);
xticklabels({'0','2','4','6','8','6','4','2','0'});
yticks([-pi:pi:pi])
yticklabels({'-pi','0','pi'});

subplot(3,1,2), plot(pha_S2);
xlabel('frequency [Hz]');
title('s2 phase');
ylabel('phase [rad]');
axis([0 1025 -pi-0.2 pi+0.2])
xticks([0:128:1025]);
xticklabels({'0','2','4','6','8','6','4','2','0'});
yticks([-pi:pi:pi])
yticklabels({'-pi','0','pi'});

subplot(3,1,3), plot(pha_S);
title('s phase');
xlabel('frequency [Hz]');
ylabel('phase [rad]');
axis([0 1025 -pi-0.2 pi+0.2])
xticks([0:128:1025]);
xticklabels({'0','2','4','6','8','6','4','2','0'});
yticks([-pi:pi:pi])
yticklabels({'-pi','0','pi'});

a = [1.0000, 2.4938, -2.1878, 0.6678];
b = [3.2719e-03, 9.8156e-03, 9.8156e-03, 3.2719e-03];
s_original = s;

% implement filtering
y1 = zeros(nLeng,1);
y1 = [0;0;0; y1]; % zero-padding
s = [0;0;0; s']; % zero-padding
for nter = 4:length(s)
    y1(nter) = a(2)*y1(nter-1) + a(3)*y1(nter-2) + a(4)*y1(nter-3)+ b(1)*s(nter) + b(2)*s(nter-1) + b(3)*s(nter-2) + b(4)*s(nter-3);
endfor

y1 = y1(4:end); % remove zero-padding
s = s(4:end); % remove zero-padding

figure, plot(t, y1);
plot(t,abs(y1));
title('y1');
xlabel('time [sec]');
ylabel('amplitude');
axis([t(1)-5/fs, t(end)+5/fs, -2.1, 2.1]);

Y1 = fft(y1);
mag_Y1 = abs(Y1);

figure;
plot(mag_Y1);
title('Y1_magnitude');
xlabel('frequency [kHz]');
ylabel('magnitude');
axis([0 1025 -0.1 max(mag_Y1)*1.1]);
xticks([0:128:1025]);
xticklabels({'0','2','4','6','8','6','4','2','0'});


s = s_original;

a = [1, 0.5014, -0.53742, -0.079724];
b = [0.24489, -0.73466, 0.73466, -0.24489];

y2 = zeros(nLeng,1);
y2 = [0;0;0; y2]; % zero-padding
s = [0;0;0; s']; % zero-padding

for nter = 4:length(s)
    y2(nter) = a(2)*y2(nter-1) + a(3)*y2(nter-2) + a(4)*y2(nter-3)+ b(1)*s(nter) + b(2)*s(nter-1) + b(3)*s(nter-2) + b(4)*s(nter-3);
endfor

y2 = y2(4:end); % remove zero-padding
s = s(4:end);

figure, plot(t, y2);
plot(t,abs(y2));
title('y2');
xlabel('time [sec]');
ylabel('amplitude');
axis([t(1)-5/fs, t(end)+5/fs, -2.1, 2.1]);

Y2 = fft(y2);
mag_Y2 = abs(Y2);

figure;
plot(mag_Y2);
title('Y2_magnitude');
xlabel('frequency [kHz]');
ylabel('magnitude');
axis([0 1025 -0.1 max(mag_Y2)*1.1]);
xticks([0:128:1025]);
xticklabels({'0','2','4','6','8','6','4','2','0'});

% example filter
s = s_original;

% 1) Allow passing a low-frequency component: Low-pass filter
a = [1.0000, 2.4938, -2.1878, 0.6678];
b = [3.2719e-03, 9.8156e-03, 9.8156e-03, 3.2719e-03];

y2 = zeros(nLeng,1);
y2 = [0;0;0; y2]; % zero-padding
s = [0;0;0; s']; % zero-padding

for nter = 4:length(s)
    y2(nter) = a(2)*y2(nter-1) + a(3)*y2(nter-2) + a(4)*y2(nter-3)+ b(1)*s(nter) + b(2)*s(nter-1) + b(3)*s(nter-2) + b(4)*s(nter-3);
endfor

y2 = y2(4:end); % remove zero-padding
s = s(4:end);

figure, plot(t, y2);
plot(t,abs(y2));
title('y3');
xlabel('time [sec]');
ylabel('amplitude');
axis([t(1)-5/fs, t(end)+5/fs, -2.1, 2.1]);

Y2 = fft(y2);
mag_Y2 = abs(Y2);

figure;
plot(mag_Y2);
title('Y3_magnitude');
xlabel('frequency [kHz]');
ylabel('magnitude');
axis([0 1025 -0.1 max(mag_Y2)*1.1]);
xticks([0:128:1025]);
xticklabels({'0','2','4','6','8','6','4','2','0'});

s = s_original;

%2) Allow passing a high-frequency component: High-pass filter
a = [1, 0.5014, -0.53742, -0.079724];
b = [0.24489, -0.73466, 0.73466, -0.24489];

y2 = zeros(nLeng,1);
y2 = [0;0;0; y2]; % zero-padding
s = [0;0;0; s']; % zero-padding

for nter = 4:length(s)
    y2(nter) = a(2)*y2(nter-1) + a(3)*y2(nter-2) + a(4)*y2(nter-3)+ b(1)*s(nter) + b(2)*s(nter-1) + b(3)*s(nter-2) + b(4)*s(nter-3);
endfor

y2 = y2(4:end); % remove zero-padding
s = s(4:end);

figure, plot(t, y2);
plot(t,abs(y2));
title('y4');
xlabel('time [sec]');
ylabel('amplitude');
axis([t(1)-5/fs, t(end)+5/fs, -2.1, 2.1]);

Y2 = fft(y2);
mag_Y2 = abs(Y2);

figure;
plot(mag_Y2);
title('Y4_magnitude');
xlabel('frequency [kHz]');
ylabel('magnitude');
axis([0 1025 -0.1 max(mag_Y2)*1.1]);
xticks([0:128:1025]);
xticklabels({'0','2','4','6','8','6','4','2','0'});


















