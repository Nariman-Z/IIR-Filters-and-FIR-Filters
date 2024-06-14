% Define the sampling frequency and time vector
fs = 500; % Sampling frequency in Hz
t = 0:1/fs:1-1/fs; % Time vector

% Create a sample input signal: a sine wave + random noise
input_signal = sin(2*pi*5*t) + 0.5*randn(size(t));

%-------------------- Filters Variables --------------------%
order = 4; % 4th-order Butterworth IIR filter
numtaps = 101; % Number of taps in FIR filter

%-------------------- High-Pass --------------------%
% Design an IIR Butterworth high-pass filter
cutoff = 20; % Cutoff frequency in Hz
[b_iir_hp, a_iir_hp] = butter(order, cutoff/(fs/2), 'high');

% Apply the IIR high-pass filter to the input signal
iir_hp_output = filter(b_iir_hp, a_iir_hp, input_signal);

% Design an FIR low-pass filter using the Hamming window method
b_fir_hp = fir1(numtaps-1, cutoff/(fs/2), 'high', hamming(numtaps));

% Apply the FIR low-pass filter to the input signal
fir_hp_output = filter(b_fir_hp, 1, input_signal);

%-------------------- Band-Pass --------------------%
% Design an IIR Butterworth band-pass filter
low_cutoff = 10; % Lower cutoff frequency in Hz
high_cutoff = 40; % Upper cutoff frequency in Hz
[b_iir_bp, a_iir_bp] = butter(order, [low_cutoff high_cutoff]/(fs/2), 'bandpass');

% Apply the IIR band-pass filter to the input signal
iir_bp_output = filter(b_iir_bp, a_iir_bp, input_signal);

% Design an FIR band-pass filter using the Hamming window method
b_fir_bp = fir1(numtaps-1, [low_cutoff high_cutoff]/(fs/2), 'bandpass', hamming(numtaps));

% Apply the FIR band-pass filter to the input signal
fir_bp_output = filter(b_fir_bp, 1, input_signal);

%-------------------- Band-Stop --------------------%
% Design an IIR Butterworth band-stop filter
[b_iir_bs, a_iir_bs] = butter(order, [low_cutoff high_cutoff]/(fs/2), 'stop');

% Apply the IIR band-stop filter to the input signal
iir_bs_output = filter(b_iir_bs, a_iir_bs, input_signal);

% Design an FIR band-stop filter using the Hamming window method
b_fir_bs = fir1(numtaps-1, [low_cutoff high_cutoff]/(fs/2), 'stop', hamming(numtaps));

% Apply the FIR band-stop filter to the input signal
fir_bs_output = filter(b_fir_bs, 1, input_signal);

%-------------------- Ploting --------------------%
% Plot the input and output signals in separate subplots
figure;

% High-Pass Filter
subplot(3, 1, 1);
hold on;
plot(t, input_signal, 'k', 'DisplayName', 'Input Signal'); % Input signal in black
plot(t, iir_hp_output, 'r', 'DisplayName', 'IIR High-Pass Filter Output'); % IIR output in red
plot(t, fir_hp_output, 'g', 'DisplayName', 'FIR High-Pass Filter Output'); % FIR output in green
hold off;
title('High-Pass Filter');
xlabel('Time [s]');
ylabel('Amplitude');
grid on;
legend show;

% Band-Pass Filter
subplot(3, 1, 2);
hold on;
plot(t, input_signal, 'k', 'DisplayName', 'Input Signal'); % Input signal in black
plot(t, iir_bp_output, 'r', 'DisplayName', 'IIR Band-Pass Filter Output'); % IIR output in red
plot(t, fir_bp_output, 'g', 'DisplayName', 'FIR Band-Pass Filter Output'); % FIR output in green
hold off;
title('Band-Pass Filter');
xlabel('Time [s]');
ylabel('Amplitude');
grid on;
legend show;

% Band-Stop Filter
subplot(3, 1, 3);
hold on;
plot(t, input_signal, 'k', 'DisplayName', 'Input Signal'); % Input signal in black
plot(t, iir_bs_output, 'r', 'DisplayName', 'IIR Band-Stop Filter Output'); % IIR output in red
plot(t, fir_bs_output, 'g', 'DisplayName', 'FIR Band-Stop Filter Output'); % FIR output in green
hold off;
title('Band-Stop Filter');
xlabel('Time [s]');
ylabel('Amplitude');
grid on;
legend show;

% Adjust layout
sgtitle('Filters Outputs');
