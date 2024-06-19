clear all
close all
fclose all
clc
pkg load signal;

%% Distance estimation with Ultrasonic sensor
# Step1. Transmitter sound
T  = 0.032;
fs = 16000;
t  = 0:1/fs:T;
f1 = 5000;
f2 = 1000;
FM = chirp(t, f1, T, f2);

figure, plot(t,FM);

# Step2. observation
TT = 0.150;
tt = 0:1/fs:TT;
obs = zeros(length(tt),1);
alpha = 0.1;
t1 = 0.010;
tidx1 = t1*fs;
t2 = 0.100;
tidx2 = t2*fs;
obs(tidx1:tidx1+length(FM)-1) = FM;
obs(tidx2:tidx2+length(FM)-1) = alpha*FM;
figure, plot(tt, obs);

# Step3. Spectrogram
frame_length = 256;
slide_length = 64;
N = frame_length;
nFrames = floor((length(obs)-frame_length)/slide_length);
spec = zeros((N/2)+1,nFrames);
for frm = 1:nFrames
  stridx = (frm-1)*slide_length + 1;
  endidx = (frm-1)*slide_length + frame_length;
  frame = obs(stridx:endidx);

  temp = fft(frame,N);
  spec(:,frm) = abs(temp(1:(N/2)+1));
endfor
figure,
subplot(2,1,1), imagesc(spec);
set(gca, 'YDir', 'normal');

frame_energy = sum(spec,1);
subplot(2,1,2), plot(frame_energy)

# step4 adding noise
noise = randn(length(obs),1);
noisy = obs + 0.1*noise;

figure,
subplot(3,1,1), plot(tt,obs);
subplot(3,1,2), plot(tt,noise);
subplot(3,1,3), plot(tt,noisy);

obs_spec = zeros((N/2)+1,nFrames);
noisy_spec = zeros((N/2)+1,nFrames);
for frm = 1:nFrames
  stridx = (frm-1)*slide_length + 1;
  endidx = (frm-1)*slide_length + frame_length;
  frame = obs(stridx:endidx);
  temp = fft(frame,N);
  obs_spec(:,frm) = abs(temp(1:(N/2)+1));

  frame = noisy(stridx:endidx);
  temp = fft(frame,N);
  noisy_spec(:,frm) = abs(temp(1:(N/2)+1));
endfor
figure,
subplot(2,1,1), imagesc(obs_spec);
set(gca, 'YDir', 'normal');
subplot(2,1,2), imagesc(noisy_spec);
set(gca, 'YDir', 'normal');


# Step5 Matched filter
template = FM;
FML = length(FM);
sim1 = zeros(length(obs),1);
sim2 = zeros(length(obs),1);
for frm=1:length(obs)-FML
  comp = obs(frm:frm+FML-1);
  sim1(frm) = template*comp/(norm(template,2)*norm(comp,2));

  comp = noisy(frm:frm+FML-1);
  sim2(frm) = template*comp/(norm(template,2)*norm(comp,2));
endfor

figure,
subplot(2,1,1), plot(tt,obs);
subplot(2,1,2), plot(tt,sim1);

figure,
subplot(2,1,1), plot(tt,noisy);
subplot(2,1,2), plot(tt,sim2);





















