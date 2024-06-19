clc;
clear all;
close all;

T = 0.128; % 원래 0.032

fs = 16e3;
t = 0:1/fs:T;

f1 = 5e3;
f2 = 1e3;

s1 = cos(2*pi*f1*t);
s2 = cos(2*pi*f2*t);

figure,
subplot(1,2,1);
plot(t,s1);
subplot(1,2,2);
plot(t,s2);

N = 1024; % samples
freq1 = fft(s1, N);
freq2 = fft(s2, N);

figure;
subplot(1,2,1);
bar(abs(freq1));
subplot(1,2,2);
bar(abs(freq2));
% 만약 시간이 네배로 늘었다면 magnmitude는 time aliasing효과로 인해 값이 두배 늘어남

pkg load signal

T = 0.032;

chirp_sig1 = chirp(t,f1,T,f2);
chirp_sig2 = chirp(t,f2,T,f1);

figure;
subplot(2,1,1);
plot(t,chirp_sig1);
subplot(2,1,2);
plot(t,chirp_sig2);

N = 1024; % samples
freq_sig1 = fft(chirp_sig1, N);
freq_sig2 = fft(chirp_sig2, N);

figure;
subplot(2,1,1);
plot(abs(freq_sig1));
subplot(2,1,2);
plot(abs(freq_sig2));

% 주파수 분석으로만 하면 위와 같이 두 주파수의 비중이 같은 경우를 표현하지 못함. 때문에 시간까지 고려하여 신호를 표현하고자 하여야함.
% short-time Fourier Transform을 쓰면, 각 간격마다 변환하므로 시간도 고려할 수 있음. 모든 간격마다 반복하면 그걸 spectrogram이라고 함.
% 근데 왜 위에 mag response가 다르지?

T = 0.128;
dt = 1/fs;
t = 0:dt:T;

sig1 = chirp(t,f1,T,f2);
sig2 = chirp(t,f2,T,f1);

frame_length_time = 0.008;
frame_length = fs*frame_length_time;
slide_length = 64;
Nframes = floor((length(sig1) - frame_length) / slide_length);
N = frame_length;
%{
 N = 128일 때, delta freq : 128Hz
 N = 256일 때, delta freq : 64Hz
 delta frequency가 작을수록 해삳오가 높음.
%}

for frm = 1:Nframes
  start_idx = (frm - 1)*slide_length +1;
  end_idx = (frm - 1)*slide_length +frame_length;
  frame = sig1(start_idx : end_idx);
  freq = fft(frame, N);
  spec1(:,frm) = abs(freq(1:(N/2)+1));

  frame = sig2(start_idx : end_idx);
  freq = fft(frame, N);
  spec2(:,frm) = abs(freq(1:(N/2)+1));

endfor


figure;
subplot(1,2,1);
imagesc(spec1);
set(gca, 'Ydir', 'normal')

subplot(1,2,2);
imagesc(spec2);
set(gca, 'Ydir', 'normal');

###############
[wavData,FS] = audioread('sample_1.wav');

sig3 = wavData(:,1);

frame_length_time = 0.025;
frame_length = fs*frame_length_time;
slide_length = 250;
Nframes = floor((length(sig3) - frame_length) / slide_length);
N = 1024;
%{
 N = 128일 때, delta freq : 128Hz
 N = 256일 때, delta freq : 64Hz
 delta frequency가 작을수록 해삳오가 높음.
%}

for frm = 1:Nframes
  start_idx = (frm - 1)*slide_length +1;
  end_idx = (frm - 1)*slide_length +frame_length;
  frame = sig3(start_idx : end_idx);
  freq = fft(frame, N);
  spec3(:,frm) = abs(freq(1:(N/2)+1));
endfor


figure;
subplot(2,1,1);
plot(sig3);
subplot(2,1,2);
imagesc(10*log10(spec3));
set(gca, 'Ydir', 'normal')
