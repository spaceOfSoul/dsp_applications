clear all
close all
clc
pkg load signal # butter를 쓰기 위함.

# step 1. filter analysis
%{
N = 5
omega_c = 2076*pi

N = 4
ohmega_p = 1404*pi
%}

w = linspace(0,10000*pi, 1000);
f = w/(2*pi);

Wp = 1404*pi; # freq in passband
Ws = 8268*pi; # freq in stopband
rp = 1; # ripple in passband
rs = 60; # ripple in stopband

# butterwooth filter (수업시간에 디자인한거)
N = 5;
Wc = 2076*pi; # cut-off freq

# Hs를 주욱 전개해보면 b_0 / (a_0 + a1_s+ a2_s2 + a3_s3 + a4_s4 + a5_s5)

[b,a] = butter(N,Wc,'s'); # 맨 끝 인자는 domain, 's'일 경우 s-plane을 말함. => 아날로그 필터

# check freq response
freq_response = freqs(b,a,w);

magnitude_res = abs(freq_response);
# db scale로
magnitude_res_db = 20*log10(magnitude_res/max(magnitude_res));

phase_res = angle(freq_response);

# plot
figure;
subplot(2,1,1);
plot(f, magnitude_res,'linestyle', '--','color', 'b');
title("magnitide");

subplot(2,1,2);
plot(f, magnitude_res_db, 'linestyle', '--','color', 'b');
hold on;
title("db scale");


[N,Wc] = buttord(Wp, Ws, rp, rs, 's'); # 차원과 cut-off freq를 찾아줌.
[b,a] = butter(N,Wc,'s');

# check freq response
freq_response = freqs(b,a,w);

magnitude_res = abs(freq_response);
magnitude_res_db = 20*log10(magnitude_res/max(magnitude_res));
phase_res = angle(freq_response);

# plot
subplot(2,1,1);
hold on;
plot(f, magnitude_res,'b');
title("magnitide");

subplot(2,1,2);
hold on;
plot(f, magnitude_res_db,'b');
title("db scale");

# chav filter
[b,a] = cheby1(N,rp,Wc,'s');
freq_response = freqs(b,a,w);

magnitude_res = abs(freq_response);
magnitude_res_db = 20*log10(magnitude_res/max(magnitude_res));
phase_res = angle(freq_response);

# plot
subplot(2,1,1);
hold on;
plot(f, magnitude_res, 'linestyle', '--','color', 'r');
title("magnitide");

subplot(2,1,2);
hold on;
plot(f, magnitude_res_db, 'linestyle', '--','color', 'r');
hold on;
title("db scale");

# designed by octave
[n,Wp] = cheb1ord(Wp,Ws,rp,rs,'s');
[b,a] = cheby1(n,rp,Wp,'s');
freq_response = freqs(b,a,w);

magnitude_res = abs(freq_response);
magnitude_res_db = 20*log10(magnitude_res/max(magnitude_res));
phase_res = angle(freq_response);

# plot
subplot(2,1,1);
hold on;
plot(f, magnitude_res, 'color', 'r');
title("magnitide");

subplot(2,1,2);
hold on;
plot(f, magnitude_res_db,'color', 'r');
hold on;
title("db scale");


# Elliptic filter
# before kwarg
Wp = 1404*pi; # freq in passband
Ws = 8268*pi; # freq in stopband
rp = 1; # ripple in passband
rs = 60; # ripple in stopband

[n,Wp] = ellipord(Wp,Ws,rp,rs,'s');

[b,a] = ellip(n, rp, rs, Wp, 's');
freq_response = freqs(b,a,w);

magnitude_res = abs(freq_response);
magnitude_res_db = 20*log10(magnitude_res/max(magnitude_res));
phase_res = angle(freq_response);

# plot
subplot(2,1,1);
hold on;
plot(f, magnitude_res, 'm');
title("magnitide");

subplot(2,1,2);
hold on;
plot(f, magnitude_res_db, 'm');
hold on;
title("db scale");


