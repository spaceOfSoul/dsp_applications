
# task1 continous

# continous time signal
dt = 1e-3;

T = 6;
t = -6:dt:T;

xt = zeros(1, length(t));
start_idx = find(t == 0);
end_idx = find(t == 2);
xt(start_idx:end_idx) = 1;

figure(1);
plot(t,xt);
title("continous time signal");
axis ([-6 6 -0.1 1.1]);

# discrete time signal

n = -6:1:6;
xn = zeros(1, length(n));
start_idx = find(n == 0);
end_idx = find(n == 2);
xn(start_idx:end_idx) = 1;

figure(2);

bar(n,xn, 0.1);
title("discrete time signal");
axis ([-6 6 -0.1 1.1]);


# task 2 forier transform

# continous time Forier Transform
dw = 1e-3; # rad/s
w = -4*pi:dw:4*pi;

len_w = length(w);

Xw = 2 * exp(-j*w) .* sin(w) ./ w;

figure(3);
plot(w, abs(Xw));
title("continous time Forier transform (magnitude)");

figure(4);
plot(w, angle(Xw));
title("continous time Forier transform (phase)");

# discrete time Forier Transform
Xejw = exp(-j*w) .* (1+2*cos(w));

figure(5);
plot(w, abs(Xejw));
title("discrete time Forier transform (magnitude)");

figure(6);
plot(w, angle(Xejw));
title("discrete time Forier transform (phase)");

# task 3 Investigation for time-shift

# 신호를 다시 만드는게 아니라, 아까 transform 한거에 time shifting factor만 곱해주기.

# continous time shifting
Xw2 = exp(-j*w*-3) .* Xw;
Xw3 = exp(-j*w*7) .* Xw;

###################################################
# plot
###################################################
figure(7);
subplot(2,1,1);
plot(w, abs(Xw2));
title("continous time Forier transform (magnitude)");

subplot(2,1,2);
plot(w, angle(Xw2));
title("continous time Forier transform (phase)");

figure(8);
subplot(2,1,1);
plot(w, abs(Xw3));
title("continous time Forier transform (magnitude)");

subplot(2,1,2);
plot(w, angle(Xw3));
title("continous time Forier transform (phase)");
###################################################

# discrete time shifting
Xejw2 = exp(-j*w*-2).*Xejw;
Xejw3 = exp(-j*w*5).*Xejw;

###################################################
# plot
###################################################
figure(9);
subplot(2,1,1);
plot(w, abs(Xejw2));
title("discrete time Forier transform (magnitude)");

subplot(2,1,2);
plot(w, angle(Xejw2));
title("discrete time Forier transform (phase)");

figure(10);
subplot(2,1,1);
plot(w, abs(Xejw3));
title("discrete time Forier transform (magnitude)");

subplot(2,1,2);
plot(w, angle(Xejw3));
title("discrete time Forier transform (phase)");
###################################################

# task 4
n = -12:1:12; # -6초부터 6초까지 => 인덱스로 접근하며 6초 사이의 간격을 더 촘촘히 하기 위해 두배로 잡음.
xn2 = zeros(length(n), 1);
start_idx = find(n == 0);
end_idx = find(n == 4);
xn2(start_idx:end_idx) = 1;

# plot discrete signal with double sampling rate
figure(11);
bar(n,xn2, 0.1);
title("discrete time signal");
axis ([-6 6 -0.1 1.1]);

# Forier Analysis
Xnew = exp(-j*2*w).*(1+2*cos(w) + 2*cos(2*w));
# Xw = 2 * exp(-j*w) .* sin(w) ./ w;


figure(12);
plot(w, abs(Xnew));
title("discrete time Forier transform (magnitude) (increase smaplingrate)");

figure(13);
plot(w, angle(Xnew));
title("discrete time Forier transform (phase)(increase smaplingrate)");



