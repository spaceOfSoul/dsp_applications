clear all
close all
clc

% .mat 파일을 로드
data = load('aud24.mat');
COCHBA = data.COCHBA;

% 실수부와 허수부에 대한 기본 통계를 표시
realPart = real(COCHBA);
imagPart = imag(COCHBA);

realMean = mean(realPart(:));
realStd = std(realPart(:));
realMin = min(realPart(:));
realMax = max(realPart(:));

imagMean = mean(imagPart(:));
imagStd = std(imagPart(:));
imagMin = min(imagPart(:));
imagMax = max(imagPart(:));

fprintf('실수부 - 평균: %f, 표준편차: %f, 최소값: %f, 최대값: %f\n', realMean, realStd, realMin, realMax);
fprintf('허수부 - 평균: %f, 표준편차: %f, 최소값: %f, 최대값: %f\n', imagMean, imagStd, imagMin, imagMax);

% 실수부와 허수부에 대한 히스토그램
figure;
subplot(1, 2, 1);
hist(realPart(:), 50);
title('실수부의 히스토그램');
xlabel('값');
ylabel('빈도');

subplot(1, 2, 2);
hist(imagPart(:), 50);
title('허수부의 히스토그램');
xlabel('값');
ylabel('빈도');

% 평균 스펙트럼
meanSpectrum = mean(abs(COCHBA), 2);

figure;
plot(meanSpectrum, '-o');
title('mean spectrem');
xlabel('주파수 빈');
ylabel('크기');

% 스펙트로그램 시각화를 생성
figure;
imagesc(abs(COCHBA));
axis xy;
colorbar;
title('spectrogram');
xlabel('time');
ylabel('freq');

% 역 FFT를 수행하여 시간 도메인 신호를 재구성
timeDomainData = ifft(COCHBA, [], 2);
timeDomainDataReal = real(timeDomainData);

% 데이터의 범위를 int16에 맞추기 위해 정규화
timeDomainDataNormalized = timeDomainDataReal / max(abs(timeDomainDataReal(:)));

% 데이터를 WAV 파일에 쓰기 위해 1차원 배열로 변형
timeDomainData1D = timeDomainDataNormalized(:);

% 샘플 레이트를 정의
sampleRate = 44100;

% 데이터를 WAV 파일에 쓰기
% audiowrite('reconstructed_audio.wav', timeDomainData1D, sampleRate);

% 재생
% sound(timeDomainData1D, sampleRate);
