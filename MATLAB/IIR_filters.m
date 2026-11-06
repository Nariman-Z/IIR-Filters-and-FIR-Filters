%% IIR_filters
% Design and analysis of IIR filters:
%   Families: Butterworth, Chebyshev I, Chebyshev II, Elliptic
%   Types   : Low-pass (LP), High-pass (HP), Band-pass (BP), Band-stop (BS)
%
% Author: Nariman Ziaie
% Date  : 27-Nov-2025

clc;
clear;
close all;

%% 1. Sampling frequency and time vector
fs = 500;                          % Sampling frequency [Hz]
t  = 0:1/fs:1-1/fs;                % Time vector (1 s)

%% 2. Input signal: 5 Hz + 30 Hz + 80 Hz + white noise
x = sin(2*pi*5*t) ...              % 5 Hz
  + 0.7*sin(2*pi*30*t) ...         % 30 Hz
  + 0.5*sin(2*pi*80*t) ...         % 80 Hz
  + 0.3*randn(size(t));            % Noise

%% 3. Filter frequency specifications (Hz)
fc_lp   = 20;                      % Low-pass cutoff
fc_hp   = 20;                      % High-pass cutoff
bp_edge = [10 40];                 % Band edges for BP / BS

% Normalized digital frequencies (0..1 -> 0..fs/2)
W_lp = fc_lp   / (fs/2);
W_hp = fc_hp   / (fs/2);
W_bp = bp_edge / (fs/2);           % Band-pass
W_bs = bp_edge / (fs/2);           % Band-stop

%% 4. Common IIR design parameters
N  = 4;                            % Prototype order
Rp = 1;                            % Passband ripple [dB] (Cheb I / Elliptic)
Rs = 40;                           % Stopband attenuation [dB] (Cheb II / Elliptic)

%% 5. Design Butterworth filters
[b_bw_lp, a_bw_lp] = butter(N,   W_lp, 'low');      % Low-pass
[b_bw_hp, a_bw_hp] = butter(N,   W_hp, 'high');     % High-pass
[b_bw_bp, a_bw_bp] = butter(N,   W_bp, 'bandpass'); % Band-pass
[b_bw_bs, a_bw_bs] = butter(N,   W_bs, 'stop');     % Band-stop

%% 6. Design Chebyshev I filters
[b_ch1_lp, a_ch1_lp] = cheby1(N, Rp,  W_lp, 'low');
[b_ch1_hp, a_ch1_hp] = cheby1(N, Rp,  W_hp, 'high');
[b_ch1_bp, a_ch1_bp] = cheby1(N, Rp,  W_bp, 'bandpass');
[b_ch1_bs, a_ch1_bs] = cheby1(N, Rp,  W_bs, 'stop');

%% 7. Design Chebyshev II filters
[b_ch2_lp, a_ch2_lp] = cheby2(N, Rs,  W_lp, 'low');
[b_ch2_hp, a_ch2_hp] = cheby2(N, Rs,  W_hp, 'high');
[b_ch2_bp, a_ch2_bp] = cheby2(N, Rs,  W_bp, 'bandpass');
[b_ch2_bs, a_ch2_bs] = cheby2(N, Rs,  W_bs, 'stop');

%% 8. Design Elliptic filters
[b_el_lp, a_el_lp] = ellip(N, Rp, Rs, W_lp, 'low');
[b_el_hp, a_el_hp] = ellip(N, Rp, Rs, W_hp, 'high');
[b_el_bp, a_el_bp] = ellip(N, Rp, Rs, W_bp, 'bandpass');
[b_el_bs, a_el_bs] = ellip(N, Rp, Rs, W_bs, 'stop');

%% 9. Collect filter coefficients for easy iteration
% Order of types: {LP, HP, BP, BS}
filterFamilies = {'Butterworth','Chebyshev I','Chebyshev II','Elliptic'};
filterTypes    = {'Low-pass','High-pass','Band-pass','Band-stop'};

bAll = {...
    {b_bw_lp,  b_bw_hp,  b_bw_bp,  b_bw_bs}, ...
    {b_ch1_lp, b_ch1_hp, b_ch1_bp, b_ch1_bs}, ...
    {b_ch2_lp, b_ch2_hp, b_ch2_bp, b_ch2_bs}, ...
    {b_el_lp,  b_el_hp,  b_el_bp,  b_el_bs}};

aAll = {...
    {a_bw_lp,  a_bw_hp,  a_bw_bp,  a_bw_bs}, ...
    {a_ch1_lp, a_ch1_hp, a_ch1_bp, a_ch1_bs}, ...
    {a_ch2_lp, a_ch2_hp, a_ch2_bp, a_ch2_bs}, ...
    {a_el_lp,  a_el_hp,  a_el_bp,  a_el_bs}};

%% 10. Plot frequency responses for all filters (16 subplots)
figure('Name','IIR filter frequency responses');

for fam = 1:numel(filterFamilies)
    for typ = 1:numel(filterTypes)
        [H, w] = freqz(bAll{fam}{typ}, aAll{fam}{typ}, 1024, fs);
        subplot(numel(filterFamilies), numel(filterTypes), ...
               (fam-1)*numel(filterTypes) + typ);
        plot(w, abs(H), 'LineWidth', 1);
        title([filterFamilies{fam} ' ' filterTypes{typ}]);
        xlabel('Frequency (Hz)');
        ylabel('|H(f)|');
        xlim([0 fs/2]);
        ylim([0 1.1]);
        grid on;
    end
end

%% 11. Time-domain responses for all filters
% For each family, create one figure with 4 subplots (LP, HP, BP, BS)
for fam = 1:numel(filterFamilies)
    figure('Name',[filterFamilies{fam} ' - time domain']);
    for typ = 1:numel(filterTypes)
        y = filter(bAll{fam}{typ}, aAll{fam}{typ}, x);   % Filtered signal

        subplot(numel(filterTypes), 1, typ);
        plot(t, x, 'k', 'DisplayName','Original'); hold on;
        plot(t, y, 'r', 'DisplayName','Filtered');
        hold off;
        title([filterFamilies{fam} ' ' filterTypes{typ}]);
        xlabel('Time (s)');
        ylabel('Amplitude');
        grid on;
        legend('show');
    end
end

% End of IIR_filters.m
