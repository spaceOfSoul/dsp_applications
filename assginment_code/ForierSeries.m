% Time resolution in descret time domain
% FS with Octave programing

% clear
clear all
close all
fclose all
clc;

%{
  1. signal generation
  s(t) = sin(2*pi*freq*t + pi/4); // 단위 원을 두바퀴 도는 신호
%}

T = 0.5;
freq = 5;
wfreq = 2*pi*freq;

% assume continous time
t = 0:0.0001:T;

% continous time signal
st = sin(wfreq*t + pi/4);

% signal plot
figure(1);
plot(t,st, "r");
text(0.05,1,"s(t)","fontsize",20,"color","r");


% Change to descrete time
dt = 0.025;
n = 0:dt:T;

% descrete time signal
sn = sin(wfreq*n + pi/4);

% descrete signal plot
hold on, bar(n, sn, 0.1);
text(0.26,0.7,"s[n]","fontsize",20);
axis([0 T -1.1 1.1]);
set(gca, 'FontSize', 20);

% descret signal with different timestamp (Dt Signal 2);
dt = 0.05;
n = 0:dt:T;
sn = sin(wfreq*n + pi/4);

% signal plot
figure(2);
plot(t,st, "r");
text(0.05,1,"s(t)","fontsize",20,"color","r");
hold on, bar(n, sn, 0.1);
text(0.26,0.7,"s[n]","fontsize",20);
axis([0 T -1.1 1.1]);
set(gca, 'FontSize', 20);

% descret signal with different timestamp (Dt Signal 3);
dt = 0.2;
n = 0:dt:T;
sn = sin(wfreq*n + pi/4);

% signal plot
figure(3);
plot(t,st, "r");
text(0.05,1,"s(t)","fontsize",20,"color","r");
hold on, bar(n, sn, 0.1);
text(0.22,0.7,"s[n]","fontsize",20);
axis([0 T -1.1 1.1]);
set(gca, 'FontSize', 20);


######### 이제 위의 plot은 모두 확인하였으므로 창을 닫고 계속함. #########
close all;

### restore dscrete time signal 1
dt = 0.025;
n = 0:dt:T;

% descrete time signal
sn = sin(wfreq*n + pi/4);

% descrete signal plot
figure;
plot(t,st, "r");
text(0.05,1,"s(t)","fontsize",20,"color","r");
hold on, bar(n, sn, 0.1);
text(0.26,0.7,"s[n]","fontsize",20);
axis([0 T -1.1 1.1]);
set(gca, 'FontSize', 20);
###

%{
2. Generate basis
%}
N = 8;
w0 = 2*pi/N;
n_len = length(n);

Q = zeros(N, n_len);
for k=1:N
  q = exp(-j*(k-1)*w0*[1:1:n_len]);
  Q(k,:) = q;
endfor

%{
figure(2);
plot(real(Q(2,:)))
figure(3);
plot(imag(Q(2,:)))
%}

%{
3. Get coefficient
%}
ak = zeros(N,1);
for k=1:N
  ak(k) = sn*Q(k,:)'/n_len;
endfor
disp(ak);

################## T, N을 변경 후 ak를 관찰. ##################

T = 5;

freq = 5;
wfreq = 2*pi*freq;

% continous time
t = 0:0.0001:T;
st = sin(wfreq*t + pi/4);


dt = 0.025;
n = 0:dt:T;

% descrete time signal
sn = sin(wfreq*n + pi/4);

% descrete signal plot
figure;
plot(t,st, "r");
text(0.05,1,"s(t)","fontsize",20,"color","r");
hold on, bar(n, sn, 0.1);
text(0.26,0.7,"s[n]","fontsize",20);
axis([0 T -1.1 1.1]);
set(gca, 'FontSize', 20);
###

%{
2. Generate basis
%}
N = 200;
w0 = 2*pi/N;
n_len = length(n);

Q = zeros(N, n_len);
for k=1:N
  q = exp(-j*(k-1)*w0*[1:1:n_len]);
  Q(k,:) = q;
endfor

%{
3. Get coefficient
%}
ak = zeros(N,1);
for k=1:N
  ak(k) = sn*Q(k,:)'/n_len;
endfor
%disp(ak);
figure(3);
plot(abs(ak));


