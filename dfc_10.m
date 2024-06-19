% Define the coefficients for the transfer functions
num1 = [1/3 1/3 1/3]; % Numerator coefficients for H1(z)
den1 = [1 1 0]; % Denominator coefficients for H1(z)

num2 = [1/3 1/3 1/3]; % Numerator coefficients for H2(z)
den2 = [1 0 0 0]; % Denominator coefficients for H2(z)

% Define the transfer functions
H1 = tf(num1, den1, -1);
H2 = tf(num2, den2, -1);

% Find poles and zeros for H1
poles_H1 = pole(H1);
zeros_H1 = zero(H1);

% Find poles and zeros for H2
poles_H2 = pole(H2);
zeros_H2 = zero(H2);

% Display results for H1
disp('Poles of H1:');
disp(poles_H1);
disp('Zeros of H1:');
disp(zeros_H1);

% Display results for H2
disp('Poles of H2:');
disp(poles_H2);
disp('Zeros of H2:');
disp(zeros_H2);

% Check for multiplicities for H1
[unique_poles_H1, ~, ic_poles_H1] = unique(poles_H1);
multiplicity_poles_H1 = accumarray(ic_poles_H1, 1);

disp('Unique Poles of H1 and their Multiplicities:');
for i = 1:length(unique_poles_H1)
    fprintf('Pole: %f, Multiplicity: %d\n', unique_poles_H1(i), multiplicity_poles_H1(i));
end

% Check for multiplicities for H2
[unique_poles_H2, ~, ic_poles_H2] = unique(poles_H2);
multiplicity_poles_H2 = accumarray(ic_poles_H2, 1);

disp('Unique Poles of H2 and their Multiplicities:');
for i = 1:length(unique_poles_H2)
    fprintf('Pole: %f, Multiplicity: %d\n', unique_poles_H2(i), multiplicity_poles_H2(i));
end

% Check for poles at 0 or infinity for H1
if any(poles_H1 == 0)
    disp('H1 has a pole at 0.');
end

if length(num1) < length(den1) % Numerator order < Denominator order
    disp('H1 has a pole at infinity.');
end

% Check for poles at 0 or infinity for H2
if any(poles_H2 == 0)
    disp('H2 has a pole at 0.');
end

if length(num2) < length(den2) % Numerator order < Denominator order
    disp('H2 has a pole at infinity.');
end
