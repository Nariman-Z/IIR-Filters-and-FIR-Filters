%% FIR_filters
% Design and analysis of FIR filters using the windowed-sinc method
% with a Hamming window.
%   Types: Low-pass (LP), High-pass (HP), Band-pass (BP), Band-stop (BS)
%
% Author: Nariman Ziaie
% Date  : 27-Nov-2025

clc;
clear;
close all;

%% 1. Sampling frequency and time vector
fs = 500;                           % Sampling frequency [Hz]
t  = 0:1/fs:1-1/fs;                 % Time vector (1 s)

%% 2. Input signal: 5 Hz + 30 Hz + 80 Hz + white noise
x = sin(2*pi*5*t) ...               % 5 Hz
  + 0.7*sin(2*pi*30*t) ...          % 30 Hz
  + 0.5*sin(2*pi*80*t) ...          % 80 Hz
  + 0.3*randn(size(t));             % Noise

%% 3. Frequency specifications (Hz)
fc_lp   = 20;                       % Low-pass cutoff
fc_hp   = 20;                       % High-pass cutoff
bp_edge = [10 40];                  % Band edges for BP / BS

% Normalized digital frequencies (0..1 -> 0..fs/2)
W_lp = fc_lp   / (fs/2);
W_hp = fc_hp   / (fs/2);
W_bp = bp_edge / (fs/2);            % Band-pass
W_bs = bp_edge / (fs/2);            % Band-stop

%% 4. FIR design parameters
numTaps       = 101;                % Number of taps (odd -> linear phase)
hammingWindow = hamming(numTaps);   % Hamming window

%% 5. Design FIR filters (windowed-sinc via fir1)
% fir1(order, Wn, 'type', window)
b_fir_lp = fir1(numTaps-1, W_lp, 'low',      hammingWindow);   % Low-pass
b_fir_hp = fir1(numTaps-1, W_hp, 'high',     hammingWindow);   % High-pass
b_fir_bp = fir1(numTaps-1, W_bp, 'bandpass', hammingWindow);   % Band-pass
b_fir_bs = fir1(numTaps-1, W_bs, 'stop',     hammingWindow);   % Band-stop

%% 6. Group delay (for alignment)
delay = (numTaps - 1) / 2;          % Samples (constant for linear-phase FIR)

%% 7. Frequency responses (4 subplots)
figure('Name','FIR filter frequency responses');

filterTypes = {'Low-pass','High-pass','Band-pass','Band-stop'};
bCoeffs     = {b_fir_lp, b_fir_hp, b_fir_bp, b_fir_bs};

for i = 1:numel(bCoeffs)
    subplot(2,2,i);
    [H,freq] = freqz(bCoeffs{i}, 1, 1024, fs);
    plot(freq, abs(H), 'b', 'LineWidth', 1);
    title(['FIR ' filterTypes{i} ' (Hamming)']);
    xlabel('Frequency (Hz)');
    ylabel('|H(f)|');
    xlim([0 fs/2]);
    ylim([0 1.1]);
    grid on;
end

%% 8. Apply FIR filters to the input signal
y_fir_lp = filter(b_fir_lp, 1, x);
y_fir_hp = filter(b_fir_hp, 1, x);
y_fir_bp = filter(b_fir_bp, 1, x);
y_fir_bs = filter(b_fir_bs, 1, x);

%% 9. Compensate for group delay (for plotting)
t_aligned        = t(1:end-delay);
y_fir_lp_aligned = y_fir_lp(delay+1:end);
y_fir_hp_aligned = y_fir_hp(delay+1:end);
y_fir_bp_aligned = y_fir_bp(delay+1:end);
y_fir_bs_aligned = y_fir_bs(delay+1:end);

%% 10. Time-domain responses for all FIR filters
figure('Name','FIR filters - time domain');

subplot(4,1,1);
plot(t, x, 'k', t_aligned, y_fir_lp_aligned, 'g');
title('FIR Low-pass (Hamming)');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original','Filtered');
grid on;

subplot(4,1,2);
plot(t, x, 'k', t_aligned, y_fir_hp_aligned, 'g');
title('FIR High-pass (Hamming)');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original','Filtered');
grid on;

subplot(4,1,3);
plot(t, x, 'k', t_aligned, y_fir_bp_aligned, 'g');
title('FIR Band-pass (Hamming)');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original','Filtered');
grid on;

subplot(4,1,4);
plot(t, x, 'k', t_aligned, y_fir_bs_aligned, 'g');
title('FIR Band-stop (Hamming)');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original','Filtered');
grid on;

% End of FIR_filters.m
