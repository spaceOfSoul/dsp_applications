# 아날로그 필터 설계 (Analogue Filter Design)

## Butterworth 저역 통과 아날로그 필터 설계

### 주어진 사양
- 패스밴드 끝 주파수 (\(\Omega_p\)): \(1404\pi\)
- 스톱밴드 시작 주파수 (\(\Omega_s\)): \(8268\pi\)
- 패스밴드 리플: 0 dB에서 -1 dB 사이
- 스톱밴드 감쇠: -60 dB 이하

### 단계 1: 필터의 차수 \(N\) 결정
1. 스톱밴드 사양을 사용하여 필요한 필터의 차수 \(N\)을 계산합니다.
2. Butterworth 필터의 차수는 다음 식으로 결정됩니다:
   \[ \|H_B(j\Omega_s)\|_{dB} = -10\log_{10}\left(1 + \left(\frac{\Omega_s}{\Omega_c}\right)^{2N}\right) < -60 \]
3. 주어진 사양에서:
   \[ -10\log_{10}\left(1 + \left(\frac{8268\pi}{\Omega_c}\right)^{2N}\right) < -60 \]
4. 위 식을 풀면:
   \[ \left(\frac{8268\pi}{\Omega_c}\right)^{2N} > 10^6 - 1 \]
5. 따라서:
   \[ N > \frac{\log(10^6 - 1)}{2\log\left(\frac{8268\pi}{\Omega_c}\right)} \]
6. 예를 들어, 차단 주파수 (\(\Omega_c\))가 알려져 있지 않다면 패스밴드와 스톱밴드 주파수의 비를 사용하여 초기 추정을 할 수 있습니다:
   \[ \log_2\left(\frac{8268\pi}{1404\pi}\right) = \log_2(5.9) \approx 2.56 \, \text{octaves} \]
   Butterworth 필터의 감쇠율이 -6N dB/octave이므로:
   \[ 6N \times 2.56 \approx 60 \quad \Rightarrow \quad N \approx 4.0 \]

### 단계 2: 차단 주파수 \(\Omega_c\) 계산
1. 차수 \(N\)이 결정된 후, 차단 주파수 \(\Omega_c\)를 계산합니다.
2. 스톱밴드 사양에서 다음을 계산합니다:
   \[ \Omega_c < \frac{\Omega_s}{(10^{6/2N})} = \frac{8268\pi}{(10^{6/2 \times 4})} = 1470.3\pi \]
3. 초기 계산으로 차단 주파수 \(\Omega_c\)는 \(1470\pi\)로 설정할 수 있습니다.

### 단계 3: 패스밴드 사양 검증
1. 결정된 \(N\)과 \(\Omega_c\)로 패스밴드 사양을 만족하는지 검증합니다.
2. 패스밴드 끝 주파수에서 크기 응답을 확인합니다:
   \[ \|H_B(j\Omega_p)\|_{dB} = -10\log_{10}\left(1 + \left(\frac{\Omega_p}{\Omega_c}\right)^{2N}\right) \]
3. 위 식을 적용하여:
   \[ \|H_B(j1404\pi)\|_{dB} = -10\log_{10}\left(1 + \left(\frac{1404\pi}{1470\pi}\right)^{8}\right) \approx -2.2852 \, \text{dB} \]
4. 패스밴드 사양 (-1 dB)을 만족하지 않으므로 \(N\)을 증가시켜야 합니다.

### 단계 4: \(N\)을 증가시켜 재계산
1. 필요시 \(N\)을 증가시켜 다시 계산하고 검증합니다.
2. \(N = 5\)로 증가시킵니다.
3. 차단 주파수를 다시 계산합니다:
   \[ \Omega_c < \frac{\Omega_s}{(10^{6/2 \times 5})} = \frac{8268\pi}{(10^{6/10})} = 2076.8\pi \]
4. 차단 주파수 \(\Omega_c\)를 \(2076\pi\)로 설정합니다.
5. 패스밴드 사양을 다시 검증합니다:
   \[ \|H_B(j1404\pi)\|_{dB} = -10\log_{10}\left(1 + \left(\frac{1404\pi}{2076\pi}\right)^{10}\right) \approx -0.0861 \, \text{dB} \]

### 단계 5: 시스템 함수 완성
1. 최종적으로 \(N = 5\)와 \(\Omega_c = 2076\pi\)가 결정되면 시스템 함수를 완성합니다.
2. \(N = 5\)인 Butterworth 필터의 극을 구합니다:
   \[ s_k = \Omega_c e^{j\pi \frac{(2k+N-1)}{2N}}, \quad k = 1, 2, \ldots, N \]
3. 각 극은 좌반평면에 균등하게 배치됩니다:
   - \(s_1 = -2076\pi\)
   - \(s_{2,3} = 2076\pi \cos \left(\frac{4\pi}{5}\right) \pm j2076\pi \sin \left(\frac{4\pi}{5}\right)\)
   - \(s_{4,5} = 2076\pi \cos \left(\frac{3\pi}{5}\right) \pm j2076\pi \sin \left(\frac{3\pi}{5}\right)\)
4. 시스템 함수 \(H_B(s)\)는 다음과 같이 표현됩니다:
   \[ H_B(s) = \frac{(2076\pi)^5}{(s + 2076\pi) \left(s^2 + 2 \cdot 2076\pi \cos \left(\frac{4\pi}{5}\right) s + (2076\pi)^2\right) \left(s^2 + 2 \cdot 2076\pi \cos \left(\frac{3\pi}{5}\right) s + (2076\pi)^2\right)} \]

## Chebyshev 저역 통과 아날로그 필터 설계

### 주어진 사양
- 패스밴드 끝 주파수 (\(\Omega_p\)): \(1404\pi\)
- 스톱밴드 시작 주파수 (\(\Omega_s\)): \(8268\pi\)
- 패스밴드 리플: 0 dB에서 -1 dB 사이
- 스톱밴드 감쇠: -60 dB 이하

### 단계 1: \(\mu\) 값 결정
1. 패스밴드 사양을 만족하기 위해 \(\mu\) 값을 결정합니다.
2. 패스밴드 사양에서:
   \[ 10\log_{10}(1 + \mu^2)^{-1} > -1 \, \text{dB} \]
3. 따라서:
   \[ \mu < (10^{0.1} - 1)^{1/2} \approx 0.5088 \]
4. \(\mu\) 값을 \(0.508\)으로 설정합니다.

### 단계 2: 차수 \(N\) 결정
1. 주어진 스톱밴드 사양을 만족하기 위해 \(N\)을 계산합니다.
2. 스톱밴드 사양에서:
   \[ |H_C(j\Omega_s)|^2 = \frac{1}{1 + \mu^2 C_N^2(\Omega_s/\Omega_p)} \]
3. 위 식을 dB 스케일로 변환하면:
   \[ 10\log_{10} \left(\frac{1}{1 + \mu^2 C_N^2(\Omega_s/\Omega_p)}\right) < -60 \, \text{dB} \]
4. 따라서:
   \[ C_N \left(\frac{\Omega_s}{\Omega_p}\right) > \left(\frac{10^6 - 1}{\mu^2}\right)^{1/2} \approx 1969 \]
5. Chebyshev 다항식을 사용하여 \(N\)을 결정합니다:
   - 예를 들어, \(C_3(5.9) \approx 804\), \(C_4(5.9) \approx 9416\)
   - 따라서 \(N = 4\)로 결정됩니다.

### 단계 3: 타원의 축 계산
1. \(N\)과 \(\mu\) 값으로 타원의 축을 계산합니다.
2. 타원의 축 \(\rho\), \(r\), \(R\)는 다음과 같이 계산됩니다:
   \[ \rho = \mu^{-1} + \sqrt{1 + \mu^{-2}} \approx 4.17 \]
   \[ r = \frac{\Omega_p (\rho^{1/N} - \rho^{-1/N})}{2} = \frac{1404\pi (4.17^{1/4} - 4.17^{-1/4})}{2} \approx 533\pi \]
   \[ R = \frac{\Omega_p (\rho^{1/N} + \rho^{-1/N})}{2} = \frac{1404\pi (4.17^{1/4} + 4.17^{-1/4})}{2} \approx 1473\pi \]

### 단계 4: 극의 위치 결정
1. 타원의 축을 기준으로 극의 위치를 계산합니다.
2. Chebyshev 필터의 극은 다음과 같이 결정됩니다:
   \[ s_p = r \cos(\theta) + jR \sin(\theta) \]
   - \(s_{1,2} = 533\pi \cos \left(\frac{7\pi}{8}\right) \pm j1473\pi \sin \left(\frac{7\pi}{8}\right)\)
   - \(s_{3,4} = 533\pi \cos \left(\frac{5\pi}{8}\right) \pm j1473\pi \sin \left(\frac{5\pi}{8}\right)\)

### 단계 5: 시스템 함수 완성
1. 최종적으로 극의 위치를 바탕으로 시스템 함수를 완성합니다.
2. 예를 들어, Chebyshev 필터의 시스템 함수 \(H_C(s)\)는 다음과 같이 표현됩니다:
   \[ H_C(s) = \frac{1.06\pi^4 \times 10^{12}}{(s^2 + 981\pi s + 748\pi^2)(s^2 + 407\pi s + (1376\pi)^2)} \]
