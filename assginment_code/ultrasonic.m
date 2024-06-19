clear all
close all
fclose all
clc

pkg load signal

T = 0.032;
fs = 16e3;
f1 = 5e3;
f2 = 1e3;

t = 0:1/fs:T;

FM = chirp(t, f1, T, f2);
figure;
plot(t, FM);

% t1 = 10ms라 가정, t2 = 100ms라 가정
TT = 0.150; % 전체 timedomain
tt = 0:1/fs:TT;
obs = zeros(length(tt), 1);
alpha = 0.1;

t1 = 0.010;
time_idx1 = t1*fs;
t2 = 0.1;
time_idx2 = t2*fs;

obs(time_idx1:time_idx1+length(FM)-1) = FM; % 쏜거
obs(time_idx2:time_idx2+length(FM)-1) = FM*alpha; % 받은거, alpha는 거리에 따른 감쇠

figure;
plot(tt,obs);
% spectrogram
frame_length = 256;
slide_length = 64;
Nframes = floor((length(obs) - frame_length) / slide_length);
N = frame_length;

for frm = 1:Nframes
  start_idx = (frm - 1)*slide_length +1;
  end_idx = (frm - 1)*slide_length +frame_length;
  frame = obs(start_idx : end_idx);
  freq = fft(frame, N);
  obs_spec(:,frm) = abs(freq(1:(N/2)+1));
endfor

figure;
subplot(2,1,1);
imagesc(obs_spec);
set(gca, 'Ydir', 'normal');

frame_energy = sum(obs_spec,1);
subplot(2,1,2);
plot(frame_energy);

% noise add
noise = randn(length(obs),1);
noisy = obs + 0.1 * noise; % 노이즈에 곱한 값은 SNR이라는 걸 곱한다고 함.

figure;
subplot(3,1,1);
plot(obs);
title('observe signal');
subplot(3,1,2);
plot(noise);
title('noise');
subplot(3,1,3);
plot(noisy);
title('noisy signal');

% spectrogram for noisy
for frm = 1:Nframes
  start_idx = (frm - 1)*slide_length +1;
  end_idx = (frm - 1)*slide_length +frame_length;
  frame = noisy(start_idx : end_idx);
  freq = fft(frame, N);
  noisy_spec(:,frm) = abs(freq(1:(N/2)+1));
endfor

figure;
subplot(2,1,1);
imagesc(obs_spec);
title('desired');
set(gca, 'Ydir', 'normal');

subplot(2,1,2);
imagesc(noisy_spec);
title('noisy spec');
set(gca, 'Ydir', 'normal');

% matched filter를 이용하여 원본 desired 신호와 잡음이 섞인 신호간에 유사도를 비교. 각 구간마다 윈도우를 밀어가면서 내적하여 유사도를 판별
% 내적값을 두 벡터 크기의 곱으로 나눠주면 유사도를 알 수 있음.
template = FM;
FML = length(FM);

sim1 = zeros(length(tt), 1);
sim2 = zeros(length(tt), 1);

for frm = 1:length(obs)-FML
  comp = obs(frm:frm+FML-1);
  sim1(frm) = template*comp /(norm(template, 2)*norm(comp,2)); % 이상적인 케이스에서의 유사도

  comp = noisy(frm:frm+FML-1);
  sim2(frm) = template*comp /(norm(template, 2)*norm(comp,2));
endfor

figure;
subplot(2,1,1);
plot(tt, obs);

subplot(2,1,2);
plot(tt, sim1);

figure;
subplot(2,1,1);
plot(tt, noisy);

subplot(2,1,2);
plot(tt, sim2);

