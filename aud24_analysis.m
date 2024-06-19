clear all
close all
clc

% .mat ������ �ε�
data = load('aud24.mat');
COCHBA = data.COCHBA;

% �Ǽ��ο� ����ο� ���� �⺻ ��踦 ǥ��
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

fprintf('�Ǽ��� - ���: %f, ǥ������: %f, �ּҰ�: %f, �ִ밪: %f\n', realMean, realStd, realMin, realMax);
fprintf('����� - ���: %f, ǥ������: %f, �ּҰ�: %f, �ִ밪: %f\n', imagMean, imagStd, imagMin, imagMax);

% �Ǽ��ο� ����ο� ���� ������׷�
figure;
subplot(1, 2, 1);
hist(realPart(:), 50);
title('�Ǽ����� ������׷�');
xlabel('��');
ylabel('��');

subplot(1, 2, 2);
hist(imagPart(:), 50);
title('������� ������׷�');
xlabel('��');
ylabel('��');

% ��� ����Ʈ��
meanSpectrum = mean(abs(COCHBA), 2);

figure;
plot(meanSpectrum, '-o');
title('mean spectrem');
xlabel('���ļ� ��');
ylabel('ũ��');

% ����Ʈ�α׷� �ð�ȭ�� ����
figure;
imagesc(abs(COCHBA));
axis xy;
colorbar;
title('spectrogram');
xlabel('time');
ylabel('freq');

% �� FFT�� �����Ͽ� �ð� ������ ��ȣ�� �籸��
timeDomainData = ifft(COCHBA, [], 2);
timeDomainDataReal = real(timeDomainData);

% �������� ������ int16�� ���߱� ���� ����ȭ
timeDomainDataNormalized = timeDomainDataReal / max(abs(timeDomainDataReal(:)));

% �����͸� WAV ���Ͽ� ���� ���� 1���� �迭�� ����
timeDomainData1D = timeDomainDataNormalized(:);

% ���� ����Ʈ�� ����
sampleRate = 44100;

% �����͸� WAV ���Ͽ� ����
% audiowrite('reconstructed_audio.wav', timeDomainData1D, sampleRate);

% ���
% sound(timeDomainData1D, sampleRate);
