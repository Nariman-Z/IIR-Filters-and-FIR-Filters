% Define the sampling frequency and time vector
fs = 500; % Sampling frequency in Hz
t = 0:1/fs:1-1/fs; % Time vector from 0 to 1 second with a step of 1/fs.

% Create a sample input signal
% Combination of two sine waves with frequencies 5 Hz and 50 Hz.
input_signal = sin(2*pi*5*t) + 0.5*sin(2*pi*50*t);

% Design an IIR Butterworth filter
order = 4; % A 4th-order Butterworth low-pass filter
cutoff = 20; % Cutoff frequency of 20 Hz
[b_iir, a_iir] = butter(order, cutoff/(fs/2), 'low');

% Apply the IIR filter to the input signal
iir_output = filter(b_iir, a_iir, input_signal);

% Design an FIR filter using the Hamming window method
numtaps = 101; % Number of taps in FIR filter
b_fir = fir1(numtaps-1, cutoff/(fs/2), 'low', hamming(numtaps));

% Apply the FIR filter to the input signal
fir_output = filter(b_fir, 1, input_signal);

% Plot the input and output signals in separate subplots
figure;

% Input signal
subplot(3, 1, 1);
plot(t, input_signal, 'k', 'DisplayName', 'Input Signal'); % Input signal in black
title('Input Signal');
xlabel('Time [s]');
ylabel('Amplitude');
grid on;

% IIR filter output
subplot(3, 1, 2);
plot(t, iir_output, 'r', 'DisplayName', 'IIR Filter Output'); % IIR output in red
title('IIR Filter Output');
xlabel('Time [s]');
ylabel('Amplitude');
grid on;

% FIR filter output
subplot(3, 1, 3);
plot(t, fir_output, 'g', 'DisplayName', 'FIR Filter Output'); % FIR output in green
title('FIR Filter Output');
xlabel('Time [s]');
ylabel('Amplitude');
grid on;

% Adjust layout
sgtitle('Input Signal and Filter Outputs');
