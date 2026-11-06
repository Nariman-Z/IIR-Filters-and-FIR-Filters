<!-- Gradient Divider -->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif">

<!-- Dynamic Header Banner (🎓 Emoji on Waving Header) -->
<img width="100%" height=350 alt="Repo Banner IIR & FIR Digital Filters" src="https://capsule-render.vercel.app/api?type=waving&color=0:0F172A,100:1E293B&height=300&section=header&text=🎓%20IIR%20and%20FIR%20Digital%20Filters&fontSize=38&fontColor=FFFFFF&fontAlign=50&fontAlignY=38&desc=Theoretical%20Design%20MATLAB%20Simulation%20and%20ESP32%20Real-Time%20DSP&descSize=16&descColor=94A3B8&descAlign=50&descAlignY=60" />

<p align="center">
  <b>IIR & FIR Digital Filter Design – Theoretical Analysis, Comparative Modeling & Embedded DSP</b><br>
  <small><i>- A comprehensive digital signal processing study examining Infinite Impulse Response (Butterworth, Chebyshev I/II, Elliptic) and Finite Impulse Response (Windowed-Sinc, Hamming) topologies, difference equations, linear phase group delay, and real-time execution across MATLAB and ESP32 microcontrollers -</i></small>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Status-Archived%20%2F%20Legacy-lightgrey.svg" alt="Status: Archived">
  <a href="https://en.wikipedia.org/wiki/Digital_filter"><img src="https://img.shields.io/badge/Discipline-Digital%20Signal%20Processing-00979D.svg" alt="Discipline: DSP"></a>
  <a href="https://www.mathworks.com/products/matlab.html"><img src="https://img.shields.io/badge/Modeling-MATLAB%20%2F%20Octave-orange.svg" alt="Modeling: MATLAB"></a>
  <a href="https://www.espressif.com/en/products/socs/esp32"><img src="https://img.shields.io/badge/Embedded%20DSP-ESP32%20%2F%20C%2B%2B-E7352C.svg" alt="Embedded DSP: ESP32"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>
</p>

---

## 📌 Project Status: Archived & Academic Origins

> [!NOTE]
> **Archived Repository & University Digital Signal Processing Coursework**  
> Originally researched, mathematically modeled, simulated, and deployed by **Nariman Ziaie** (June 2024 – November 2025) for his university **Digital Signal Processing (DSP)** and **Signals & Systems** coursework at **Islamic Azad University Central Tehran Branch**.  
> 
> **Academic Legacy:** This project served as an end-to-end investigation into discrete-time filter synthesis and implementation. It bridges theoretical continuous-to-discrete mappings (bilinear transformation, pole-zero placement), multi-family frequency-domain benchmarking, and bare-metal embedded execution on 32-bit microcontroller silicon.  
> 
> **Archive Notice:** This repository is preserved in a read-only archived state for historical, educational, and reference purposes. For my latest projects, active open-source software, and engineering portfolios, explore my personal website and GitHub repositories listed below.

### 📖 The Origin Story

> *"In digital signal processing, filtering is the quintessential mathematical operation: transforming continuous real-world phenomena into discrete sequences $x[n]$ and selectively reshaping their spectral energy to isolate information from noise.*  
> 
> *During my university coursework in **Digital Signal Processing** and **Signals & Systems**, I wanted to explore the fundamental dichotomy of discrete filter design: the trade-offs between recursive **Infinite Impulse Response (IIR)** filters and non-recursive **Finite Impulse Response (FIR)** filters.*  
> 
> *On paper, the contrast is stark. IIR filters inherit the elegance of classical analog prototypes—Butterworth with its maximally flat passband, Chebyshev Type I and II trading controlled ripple for steep roll-off, and Elliptic filters squeezing maximum transition sharpness out of minimal pole counts—delivering exceptional computational efficiency at the cost of non-linear phase. Conversely, FIR filters achieve unconditional Bounded-Input Bounded-Output (BIBO) stability and perfect linear phase (preserving waveform envelope geometry), but demand orders of magnitude more coefficients.*  
> 
> *What started in June 2024 as benchmark scripts in MATLAB (`Ex1.m`, `Ex2.m`) and an academic monograph gradually evolved into a complete multi-tool DSP suite. In November 2025, I expanded the research:*  
> 1. *Authored comprehensive MATLAB suites comparing all four classical IIR families against 101-tap windowed-sinc FIR filters across Low-pass, High-pass, Band-pass, and Band-stop topologies.*  
> 2. *Implemented exact **linear-phase group delay compensation** ($\tau_g = 50\,\text{samples}$) to time-align FIR responses with original inputs.*  
> 3. *Bridged the mathematics into physical silicon by writing real-time embedded DSP firmware on an **ESP32 microcontroller**, sampling an analog ADC channel at $500\,\text{Hz}$ and executing direct-form difference equations in real time.*  
> 
> *This repository stands as a preserved milestone of that educational and practical journey—a comprehensive reference suite demonstrating digital filter design from discrete mathematics to real-time embedded hardware."*  
> — **Nariman Ziaie**

---

## 💡 Executive Summary & Core Capabilities

This project delivers an end-to-end theoretical, algorithmic, and embedded treatment of digital filter design across MATLAB and C++ microcontroller firmware:

* **Comprehensive IIR Family Comparison:** Complete synthesis and frequency response evaluation of four classical analog-prototype approximations:
  * **Butterworth:** Maximally flat passband response with smooth monotonic roll-off.
  * **Chebyshev Type I:** Controlled passband equiripple ($R_p = 1\,\text{dB}$) yielding steeper transition skirts.
  * **Chebyshev Type II (Inverse):** Maximally flat passband with controlled stopband equiripple ($R_s = 40\,\text{dB}$).
  * **Elliptic (Cauer):** Equiripple in both passband and stopband, delivering the steepest possible roll-off for a given order ($N = 4$).
* **Linear-Phase Windowed-Sinc FIR Design:** 101-tap FIR filter synthesis using the Hamming window function across Low-pass ($20\,\text{Hz}$), High-pass ($20\,\text{Hz}$), Band-pass ($10 - 40\,\text{Hz}$), and Band-stop ($10 - 40\,\text{Hz}$) configurations.
* **Exact Group Delay Alignment:** Resolves the intrinsic $50$-sample constant group delay ($\tau_g = \frac{N-1}{2}$) of linear-phase FIR filters, producing time-aligned filtered waveforms without phase distortion.
* **Real-Time Embedded DSP on ESP32:** C++ firmware executing real-time digital filtering on an ESP32 microcontroller at a calibrated $500\,\text{Hz}$ sampling rate ($\Delta t = 2000\,\mu\text{s}$), streaming raw and filtered signals to the Arduino Serial Plotter:
  * **`IIR_Filter_ESP32.ino`:** 8th-order Butterworth band-stop filter ($10 - 40\,\text{Hz}$) using direct-form recursive history buffers.
  * **`FIR_Filter_ESP32.ino`:** 101-tap convolution filter using an array state-shift buffer.
* **Academic Monograph & Technical Report:** 15-page comprehensive PDF document (`MATLAB code & Analysis.pdf`) detailing mathematical difference equations, stability criteria, and pole-zero geometry.

---

## 📂 Repository & Project Structure

```text
IIR-Filters-and-FIR-Filters/
├── README.md                           # Comprehensive documentation & engineering runbook
├── LICENSE                             # MIT Open-Source License
├── .gitignore                          # Git ignore rules for MATLAB & Arduino/ESP32
├── Documentation/
│   └── MATLAB code & Analysis.pdf      # 15-page academic report on IIR & FIR design
├── MATLAB/
│   ├── Ex1.m                           # Basic dual-tone low-pass benchmark (Butterworth vs FIR)
│   ├── Ex2.m                           # Multi-band filtering benchmark with random noise
│   ├── IIR_filters.m                   # Comprehensive suite: 4 families x 4 types (16 filters)
│   ├── FIR_filters.m                   # 101-tap windowed-sinc suite with group-delay alignment
│   └── Assets/                         # Original simulation waveform captures (.jpg)
│       ├── Input Signal and Filter Outputs (Ex1).jpg
│       └── Input Signal and Filter Outputs (Ex2).jpg
└── ESP32/                              # Real-time embedded DSP firmware
    ├── IIR_Filter_ESP32/
    │   └── IIR_Filter_ESP32.ino        # Real-time recursive 8th-order IIR on ESP32 ADC
    └── FIR_Filter_ESP32/
        └── FIR_Filter_ESP32.ino        # Real-time 101-tap convolution FIR on ESP32 ADC
```

---

## ⚡ Mathematical Foundations & Theoretical Formulations

```text
Continuous Signal x(t) ──► [ADC @ fs=500Hz] ──► Discrete Signal x[n]
                                                      │
             ┌────────────────────────────────────────┴────────────────────────────────────────┐
             ▼                                                                                 ▼
     IIR Filter (Recursive)                                                            FIR Filter (Non-Recursive)
 y[n] = Σ b_k x[n-k] - Σ a_k y[n-k]                                                    y[n] = Σ b_k x[n-k]
 * Feedback from past outputs                                                          * Feedforward convolution only
 * Lower order / High efficiency                                                       * Linear phase / Guaranteed stability
 * Potential non-linear phase distortion                                               * Constant group delay: τ = (N-1)/2
```

### 1. IIR Difference Equation & $z$-Domain Transfer Function
An Infinite Impulse Response (IIR) filter is governed by the recursive difference equation:

$$y[n] = \sum_{k=0}^{M} b_k x[n-k] - \sum_{k=1}^{N} a_k y[n-k]$$

Where:
* $x[n]$ is the current discrete input sample, and $x[n-k]$ are past input samples.
* $y[n]$ is the current discrete output sample, and $y[n-k]$ are past recursive output samples.
* $b_k$ ($k = 0, \dots, M$) are the feedforward (numerator) coefficients.
* $a_k$ ($k = 1, \dots, N$) are the feedback (denominator) coefficients (with $a_0 = 1$).

Applying the unilateral $z$-transform ($\mathcal{Z}\{x[n-k]\} = z^{-k} X(z)$):

$$Y(z) = \sum_{k=0}^{M} b_k z^{-k} X(z) - \sum_{k=1}^{N} a_k z^{-k} Y(z)$$

$$Y(z) \left[ 1 + \sum_{k=1}^{N} a_k z^{-k} \right] = X(z) \left[ \sum_{k=0}^{M} b_k z^{-k} \right]$$

The discrete transfer function $H(z)$ is:
$$H(z) = \frac{Y(z)}{X(z)} = \frac{\sum_{k=0}^{M} b_k z^{-k}}{1 + \sum_{k=1}^{N} a_k z^{-k}} = \frac{b_0 + b_1 z^{-1} + b_2 z^{-2} + \dots + b_M z^{-M}}{1 + a_1 z^{-1} + a_2 z^{-2} + \dots + a_N z^{-N}}$$

* **BIBO Stability Requirement:** For the IIR filter to be stable, all poles of $H(z)$ (roots of the denominator polynomial) must lie strictly inside the unit circle of the complex $z$-plane ($|z_p| < 1$).

---

### 2. FIR Difference Equation & Discrete Convolution
A Finite Impulse Response (FIR) filter is non-recursive, containing no feedback loop ($a_k = 0$ for $k \ge 1$):

$$y[n] = \sum_{k=0}^{M} b_k x[n-k] = b_0 x[n] + b_1 x[n-1] + \dots + b_M x[n-M]$$

Where $M$ is the filter order and $N_{\text{taps}} = M + 1$ is the number of filter taps.

In the $z$-domain:
$$H(z) = \sum_{k=0}^{M} b_k z^{-k} = b_0 + b_1 z^{-1} + b_2 z^{-2} + \dots + b_M z^{-M}$$

* **Inherent Stability:** Because all $M$ poles are located identically at the origin $z = 0$, an FIR filter is **unconditionally BIBO stable**.

---

### 3. Linear Phase & Group Delay
For an FIR filter to exhibit strict linear phase ($\theta(\omega) = -\alpha \omega$), its impulse response $h[n]$ must satisfy even or odd symmetry around its midpoint:

$$h[n] = h[M - n] \quad \text{or} \quad h[n] = -h[M - n]$$

When symmetric (Type I, odd tap count $N_{\text{taps}} = 101$, $M = 100$):
* **Phase Delay:**
  $$\tau_p(\omega) = -\frac{\theta(\omega)}{\omega} = \frac{M}{2} = \frac{N_{\text{taps}} - 1}{2} = 50\,\text{samples}$$
* **Group Delay:**
  $$\tau_g(\omega) = -\frac{d\theta(\omega)}{d\omega} = \frac{M}{2} = 50\,\text{samples}$$

At sampling frequency $f_s = 500\,\text{Hz}$ ($\Delta t = 2\,\text{ms}$):
$$t_{\text{delay}} = \tau_g \times \frac{1}{f_s} = 50 \times 2\,\text{ms} = 100\,\text{ms}$$

In [`MATLAB/FIR_filters.m`](MATLAB/FIR_filters.m), this constant latency is compensated by trimming the first $50$ samples from the output vector, yielding phase-pure time alignment.

---

### 4. Classical Approximation Family Comparison

| Filter Family | Passband Behavior | Stopband Behavior | Transition Roll-off | Phase Linearity | Typical Application |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Butterworth** | Maximally flat (no ripple) | Monotonic attenuation | Moderate | Non-linear | Audio processing, anti-aliasing |
| **Chebyshev Type I** | Equiripple ($R_p = 1\,\text{dB}$) | Monotonic attenuation | Steep | Highly non-linear | RF communications, pre-filtering |
| **Chebyshev Type II** | Maximally flat | Equiripple ($R_s = 40\,\text{dB}$) | Steep | Moderately non-linear | Harmonic suppression |
| **Elliptic (Cauer)** | Equiripple ($R_p = 1\,\text{dB}$) | Equiripple ($R_s = 40\,\text{dB}$) | **Sharpest** | Highly non-linear | Narrowband channelizers |
| **FIR (Hamming)** | Ripples determined by window | Sidelobe floor ($-53\,\text{dB}$) | Linear with taps | **Strictly Linear** | Biomedical ECG/EEG, modems |

---

## 🔌 Real-Time Embedded DSP on ESP32

A central achievement of this project is proving that theoretical filter mathematics can run on low-cost physical silicon in real time. The two Arduino sketches (`FIR_Filter_ESP32.ino` and `IIR_Filter_ESP32.ino`) are **live, hardware-in-the-loop DSP engines**—not pre-computed or hardcoded simulations.

The firmware samples continuous analog voltages from the physical world, executes the discrete difference equations in real time, and streams filtered waveforms over UART.

```text
[Signal Generator / Sensor] ──► [GPIO34 (ADC1_CH6)] ──► [12-Bit SAR ADC (0-4095)]
                                                                │
                                                                ▼ Normalized x ∈ [0.0, 1.0]
                                                  ┌─────────────┴─────────────┐
                                                  ▼                           ▼
                                        IIR_Filter_ESP32.ino        FIR_Filter_ESP32.ino
                                        (8th-Order Butterworth)     (101-Tap Convolution)
                                        Recursive Difference Eq.    Feedforward FIR Buffer
                                        Compute Time: ~1.2 us       Compute Time: ~8.6 us
                                                  │                           │
                                                  └─────────────┬─────────────┘
                                                                ▼ Live Output y[n]
                                                     [UART Serial @ 115200]
                                                                │
                                                                ▼
                                                [Arduino Serial Plotter: x, y]
```

---

### 1. Architectural Walkthrough & Code Mechanics

#### A. FIR Engine (`FIR_Filter_ESP32.ino`)
The FIR sketch executes real-time discrete convolution of incoming analog samples against the 101-tap Hamming band-stop coefficient array `b_fir[]`:

1. **State Memory Shift:** At each time step $n$, previous samples shift one position back in RAM:
   ```cpp
   for (int i = FIR_TAPS - 1; i > 0; i--) {
     fir_state[i] = fir_state[i - 1];
   }
   fir_state[0] = x;  // Insert newest normalized ADC sample
   ```
2. **Discrete Convolution:** Calculates output $y[n] = \sum_{k=0}^{100} b[k] x[n-k]$:
   ```cpp
   float y = 0.0f;
   for (int i = 0; i < FIR_TAPS; i++) {
     y += b_fir[i] * fir_state[i];
   }
   return y;
   ```
3. **Physical Effect:** Rejects all spectral energy between $10\,\text{Hz}$ and $40\,\text{Hz}$ while maintaining strict linear phase. The output exhibits a constant group delay of $\tau_g = 50\,\text{samples}$ ($100\,\text{ms}$).

---

#### B. IIR Engine (`IIR_Filter_ESP32.ino`)
The IIR sketch executes a recursive Direct-Form I difference equation corresponding to an 8th-order Butterworth band-stop filter ($10 - 40\,\text{Hz}$):

1. **Dual State Memory Buffers:** Maintains input history (`x_hist[8]`) and recursive feedback history (`y_hist[8]`).
2. **Direct-Form I Difference Equation:**
   ```cpp
   // 1. Feedforward convolution (zeros):
   float y = b_iir[0] * x;
   for (int i = 1; i < IIR_NB; i++) {
     y += b_iir[i] * x_hist[i - 1];
   }
   // 2. Recursive feedback subtraction (poles):
   for (int i = 1; i < IIR_NA; i++) {
     y -= a_iir[i] * y_hist[i - 1];
   }
   ```
3. **History Update:** Shifts both input and output history buffers ready for sample $n+1$.
4. **Physical Effect:** Sharp notch rejection between $10\,\text{Hz}$ and $40\,\text{Hz}$ with only 17 floating-point operations per sample—running $>7\times$ faster than the 101-tap FIR filter.

---

### 2. Deterministic Fixed-Rate Scheduling (`micros()`)

To preserve exact cutoff frequencies ($10\,\text{Hz}$ and $40\,\text{Hz}$), the sampling cadence must remain strictly deterministic at $f_s = 500.0\,\text{Hz}$ ($\Delta t = 2000\,\mu\text{s}$).

Instead of using blocking delays (`delay()` or `delayMicroseconds()`) which introduce jitter and drift, the firmware implements an accumulator delta scheduler:

```cpp
const float FS        = 500.0f;     // 500 Hz sample rate
const float SAMPLE_DT = 1e6f / FS;  // 2000.0 microseconds per sample

void loop() {
  unsigned long now = micros();
  if (now - lastSampleMicros >= SAMPLE_DT) {
    lastSampleMicros += SAMPLE_DT;  // Accumulator avoids cumulative timing drift
    
    int raw = analogRead(ADC_PIN);
    float x = (float)raw / 4095.0f;
    float y = iir_process(x);       // Or fir_process(x)

    Serial.print(x, 6);
    Serial.print(',');
    Serial.println(y, 6);
  }
}
```

---

### 3. Hardware Benchtop Wiring & Visualization Guide

To test the filters in the real world:

1. **Wiring Setup:**
   * **Signal Source:** Connect an analog function generator, sensor, or a $10\,\text{k}\Omega$ potentiometer wiper to **GPIO34** (`ADC1_CH6`).
   * **Ground:** Connect signal source GND to ESP32 GND.
   * **Voltage Range:** The ESP32 ADC is configured for $11\,\text{dB}$ attenuation ($0.0\,\text{V} - 3.3\,\text{V}$). For AC signals (e.g. from an audio jack), add a $1\,\mu\text{F}$ coupling capacitor with a $1.65\,\text{V}$ DC bias divider ($2 \times 100\,\text{k}\Omega$ resistors across $3.3\,\text{V}$ and GND).
2. **Flash & Monitor:**
   * Upload either `IIR_Filter_ESP32.ino` or `FIR_Filter_ESP32.ino` via Arduino IDE.
   * Open **Tools $\to$ Serial Plotter** at **115200 baud**.
3. **Observed Behavior:**
   * **Sweep Input:** Inject a sweep frequency from $1\,\text{Hz}$ to $60\,\text{Hz}$.
   * **Passband ($< 10\,\text{Hz}$ & $> 40\,\text{Hz}$):** The filtered trace ($y$) cleanly tracks the input ($x$).
   * **Stopband ($10 - 40\,\text{Hz}$):** The filtered trace ($y$) collapses to zero, completely extinguishing the notch band in real time!

---

### 4. Educational vs. Production Trade-Offs

While functionally complete and mathematically sound, these sketches are optimized for **readability and pedagogical clarity**. In an industrial production setting, embedded DSP engineers apply two key optimizations:

1. **Memory Shifting vs. Circular Ring Buffer:**
   * *Current Code:* Shifts all elements in memory (`for (int i = N-1; i > 0; i--)`). On the ESP32 ($240\,\text{MHz}$), 101 float moves take $< 2\,\mu\text{s}$, well within the $2000\,\mu\text{s}$ time budget.
   * *Production Practice:* Use a **circular ring buffer** with an index pointer (`head = (head + 1) % N_TAPS`), reducing memory movement overhead to $O(1)$.
2. **Direct Form IIR vs. Cascaded Biquads (Second-Order Sections):**
   * *Current Code:* Implements an 8th-order Direct-Form I polynomial. Notice the wide spread of coefficient values (`b[4] = 39.61`, `a[3] = -35.44`).
   * *Production Practice:* High-order direct-form filters can be sensitive to 32-bit float truncation. Production DSP systems decompose high-order polynomials into cascaded **Second-Order Sections (Biquads)** to guarantee numerical robustness.
3. **Serial Stream Bandwidth:**
   * Streaming two 6-decimal floats at $500\,\text{Hz}$ generates $\approx 100\,\text{kbps}$ of ASCII data, approaching the 115200 baud saturation limit. In production, telemetry is transmitted via compact binary frames or processed internally.

---

### Hardware Configuration & Pinout Summary

| Signal | ESP32 Pin | Peripheral / Role | Configuration Parameters |
| :--- | :--- | :--- | :--- |
| **Analog Input ($x[n]$)** | `GPIO34` (`ADC1_CH6`) | Successive approximation ADC | 12-bit resolution ($0 - 4095$), $11\,\text{dB}$ attenuation ($0 - 3.3\,\text{V}$) |
| **Telemetry Stream** | `GPIO1` (`TX0`) | Hardware UART0 @ 115200 baud | Transmits CSV string `raw,filtered\n` every $2000\,\mu\text{s}$ |
| **Timer Basis** | Internal Timer | Hardware microsecond counter | `micros()` accumulator guaranteeing exact $500.0\,\text{Hz}$ rate |

### Embedded Memory & Computational Benchmarks
* **Sampling Rate:** $f_s = 500\,\text{Hz} \implies T_{\text{sample}} = 2000\,\mu\text{s}$.
* **IIR Computational Load:** 9 multiply-accumulate (MAC) operations for numerator + 8 MACs for denominator $\approx 17\,\text{FLOPs}$ per sample ($\approx 1.2\,\mu\text{s}$ on hardware FPU, consuming $< 0.1\%$ CPU).
* **FIR Computational Load:** 101 MAC operations + 101 buffer shift cycles $\approx 202\,\text{FLOPs}$ per sample ($\approx 8.6\,\mu\text{s}$ execution time, well within the $2000\,\mu\text{s}$ time budget).

---

## 🧪 Software Suite & Execution Runbook

### 1. MATLAB Multi-Family Suite (`MATLAB/`)
Open MATLAB, navigate to `MATLAB/`, and run any of the provided scripts:
* **[`Ex1.m`](MATLAB/Ex1.m):** Basic dual-tone input ($5\,\text{Hz} + 50\,\text{Hz}$) processed through a 4th-order Butterworth low-pass and a 101-tap Hamming low-pass filter.
* **[`Ex2.m`](MATLAB/Ex2.m):** Evaluates High-Pass, Band-Pass, and Band-Stop filtering on a sinusoidal signal corrupted by Gaussian white noise.
* **[`IIR_filters.m`](MATLAB/IIR_filters.m):** Generates a complete $4 \times 4$ magnitude frequency response matrix across all families (Butterworth, Chebyshev I, Chebyshev II, Elliptic) and filter types (LP, HP, BP, BS).
* **[`FIR_filters.m`](MATLAB/FIR_filters.m):** Synthesizes 101-tap FIR filters, evaluates group delay, and plots time-domain aligned filtered signals.

### 2. ESP32 Arduino Deployment (`ESP32/`)
1. Open [`ESP32/IIR_Filter_ESP32/IIR_Filter_ESP32.ino`](ESP32/IIR_Filter_ESP32/IIR_Filter_ESP32.ino) or [`ESP32/FIR_Filter_ESP32/FIR_Filter_ESP32.ino`](ESP32/FIR_Filter_ESP32/FIR_Filter_ESP32.ino) in the **Arduino IDE**.
2. Select your board (**ESP32 Dev Module**) and COM port.
3. Click **Upload**.
4. Open **Tools $\to$ Serial Plotter** at **115200 baud**.
5. Connect an analog function generator or sensor to `GPIO34` to observe real-time filtering waveforms.

---

## 🔬 Technical Report & Documentation Summary

The repository includes a comprehensive 15-page academic monograph ([`Documentation/MATLAB code & Analysis.pdf`](Documentation/MATLAB%20code%20%26%20Analysis.pdf)):

* **Section 1 (Introduction & Digital Filter Taxonomies):** Fundamental differences between recursive and non-recursive discrete-time processing.
* **Section 2 (Infinite Impulse Response Topologies):** Detailed pole-zero mathematical models for Butterworth, Chebyshev, Bessel, Elliptic, Comb, Notch, All-Pass, and State-Variable architectures.
* **Section 3 (Finite Impulse Response Topologies):** Synthesis methods including Windowed-Sinc, Parks-McClellan (Remez exchange), Least-Squares, and Frequency Sampling.
* **Section 4 (MATLAB Code Implementations):** Line-by-line annotations of design routines, normalized digital frequency calculations, and graphic visualization.

---

## 🔍 Diagnostics, Edge-Case Insights & Architectural Analysis

### 1. Finite Word-Length & Coefficient Quantization
* On 32-bit floating-point processors (like the ESP32), single-precision IEEE 754 floats provide $24\,\text{bits}$ of mantissa precision. For high-order IIR filters ($N > 6$), high sensitivity to coefficient quantization can displace poles outside the unit circle, resulting in instability.
* **Design Remedy:** Higher-order IIR filters should be factored into cascaded Second-Order Sections (SOS / biquads) rather than single high-order direct-form polynomials.

### 2. Real-Time Latency vs. Group Delay
* When deploying FIR filters in real-time embedded feedback loops, the 50-sample group delay ($100\,\text{ms}$) cannot be compensated via negative index shifting (as is done offline in MATLAB).
* For latency-critical real-time closed-loop control, minimum-phase IIR filters or lower-order FIR designs are strictly preferred.

---

## 🏛️ Project Archive & Further Projects

> [!IMPORTANT]
> **This repository is officially archived.**  
> `IIR-Filters-and-FIR-Filters` reflects foundational coursework and comparative experimentation in digital filter theory. Active development has concluded, and this repository is preserved for historical and educational reference.
>
> To explore my latest active engineering projects, research, and open-source software:

### 🌐 [Personal Website & Portfolio](https://nariman-z.pages.dev/)
* **Official URL:** [**nariman-z.pages.dev**](https://nariman-z.pages.dev/)
* **Overview:** Comprehensive showcase of embedded engineering projects, hardware systems, full-stack software development, technical articles, and interactive demos.

### 💻 [GitHub Repositories](https://github.com/Nariman-Z?tab=repositories)
* **GitHub Profile:** [**github.com/Nariman-Z**](https://github.com/Nariman-Z)
* **Repository Catalog:** [**github.com/Nariman-Z?tab=repositories**](https://github.com/Nariman-Z?tab=repositories)
* **Overview:** Complete collection of open-source repositories spanning microcontroller firmware, IoT architectures, circuit simulations, web platforms, and mobile applications.

---

## 📄 License & Developer Attribution

Licensed under the terms of the **MIT License**. See the full [`LICENSE`](LICENSE) file for complete details.

---

<div align="center">

### Made with ❤️ by [Nariman_Z](https://github.com/Nariman-Z)  
🌐 [Personal Website & Portfolio](https://nariman-z.pages.dev/)

</div>

<!-- Gradient Divider -->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif">

_Last Update: November 2026_
