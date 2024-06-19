clear all
close all
fclose all
clc

pkg load signal


%% generate signal
T  = 0.032;
fs = 16000;
t  = 0:1/fs:T;

f1 = 5000;
f2 = 1000;

s1 = cos(2*pi*f1*t);
s2 = cos(2*pi*f2*t);

N = 1024;
figure,
subplot(1,2,1), plot(t,s1,'linewidth',2);

freq1 = fft(s1, N);
freq2 = fft(s2, N);

figure;
subplot(1,2,1), plot(abs(freq1), 'linewidth',2);
subplot(1,2,2), plot(abs(freq2), 'linewidth',2);
###################################################
sig1 = chirp(t, f1, T, f2);
sig2 = chirp(t, f2, T, f1);

figure,
subplot(2,2,1), plot(t,sig1,'linewidth',2);
freq1 = fft(sig1, N);
subplot(2,2,2), plot(abs(freq1), 'linewidth',2);

subplot(2,2,3), plot(t,sig2,'linewidth',2);
freq2 = fft(sig2, N);
subplot(2,2,4), plot(abs(freq2), 'linewidth',2);

###################################################
T  = 0.128;
t  = 0:1/fs:T;

sig1 = chirp(t, f1, T, f2);
sig2 = chirp(t, f2, T, f1);

frame_length = 128; # 8ms => 16ms
slide_length = 32;
Nframes = floor((length(sig1)-frame_length)/slide_length);
N = frame_length;
spec1 = zeros((N/2)+1, Nframes);
spec2 = zeros((N/2)+1, Nframes);

for frm = 1:Nframes
  stridx = (frm-1)*slide_length + 1;
  endidx = (frm-1)*slide_length + frame_length;
  frame = sig1(stridx:endidx);
  freq = fft(frame, N);
  spec1(:,frm) = abs(freq(1:(N/2)+1));

  frame = sig2(stridx:endidx);
  freq = fft(frame, N);
  spec2(:,frm) = abs(freq(1:(N/2)+1));
endfor

figure,
subplot(1,2,1), imagesc(spec1);
set(gca, 'Ydir', 'normal')
subplot(1,2,2), imagesc(spec2);
set(gca, 'Ydir', 'normal')


######################################################
[wavData, FS] = audioread('sample2.wav');
wavData = wavData(:,1);

frame_length = 1000;
slide_length =  250;
N = 1024;

Nframes = floor((length(wavData)-frame_length)/slide_length);
spec = zeros((N/2)+1, Nframes);
for frm = 1:Nframes
  stridx = (frm-1)*slide_length + 1;
  endidx = (frm-1)*slide_length + frame_length;
  frame = wavData(stridx:endidx);
  freq = fft(frame, N);
  spec(:,frm) = abs(freq(1:(N/2)+1));
endfor
figure,
subplot(2,1,1), plot(wavData)
subplot(2,1,2), imagesc(10*log10(spec+0.00001));
set(gca, 'Ydir', 'normal')













