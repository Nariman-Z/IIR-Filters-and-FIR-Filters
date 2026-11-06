/*
 * FIR_Filter_ESP32.ino
 *
 * Real-time embedded DSP implementation for the ESP32 microcontroller.
 * Samples an analog voltage input on GPIO34 (ADC1_CH6) at exactly 500 Hz
 * and executes a 101-tap linear-phase FIR band-stop filter in real time.
 *
 * Filter Specifications:
 *   - Topology : Windowed-Sinc (Hamming window)
 *   - Response : Band-Stop (Notch: 10 Hz – 40 Hz)
 *   - Sampling : fs = 500 Hz (dt = 2000 microseconds)
 *   - Taps     : 101 coefficients (Order M = 100)
 *   - Latency  : Group delay = (101 - 1) / 2 = 50 samples (100 ms)
 *
 * Coefficients generated via MATLAB fir1():
 *   fir1(100, [10 40]/(500/2), 'stop', hamming(101))
 *
 * Output Telemetry:
 *   Streams CSV format (raw_input, filtered_output) over Serial at 115200 baud
 *   for live waveform visualization in Arduino Serial Plotter.
 *
 * Author: Nariman Ziaie
 * Date  : 27-Nov-2025
 */

// ----- User configuration -----
const int   ADC_PIN     = 34;         // ADC input channel (GPIO34 = ADC1_CH6 on ESP32)
const float FS          = 500.0f;     // Sampling frequency [Hz]
const float SAMPLE_DT   = 1e6f / FS;  // Sampling period [microseconds]

// FIR filter coefficients (band-stop 10–40 Hz, Hamming window, 101 taps)
// Generated using Python/Matlab as described above
const float b_fir[] = {
  8.69478659e-19f,  1.86264353e-04f,  3.28444717e-04f,  3.73904240e-04f,
  2.74942071e-04f,  7.95699666e-19f, -4.51740732e-04f, -1.03738366e-03f,
 -1.66591911e-03f, -2.20857991e-03f, -2.52625197e-03f, -2.51012119e-03f,
 -2.12530413e-03f, -1.44291342e-03f, -6.45991695e-04f,  1.99973327e-17f,
  2.11646089e-04f, -2.25406323e-04f, -1.36963930e-03f, -3.06486534e-03f,
 -4.93426550e-03f, -6.44057779e-03f, -7.00782091e-03f, -6.18010909e-03f,
 -3.77720578e-03f,  8.28753631e-19f,  4.55445497e-03f,  8.98922104e-03f,
  1.23072021e-02f,  1.36754220e-02f,  1.26902601e-02f,  9.56959135e-03f,
  5.20644038e-03f,  1.04664145e-03f, -1.20509096e-03f,  9.22543330e-17f,
  5.60841059e-03f,  1.55961772e-02f,  2.87825627e-02f,  4.28965551e-02f,
  5.49129642e-02f,  6.16112315e-02f,  6.02519917e-02f,  4.92287630e-02f,
  2.85456217e-02f,  3.37205005e-17f, -3.29918708e-02f, -6.59131595e-02f,
 -9.39177369e-02f, -1.12704578e-01f,  8.74995638e-01f, -1.12704578e-01f,
 -9.39177369e-02f, -6.59131595e-02f, -3.29918708e-02f,  3.37205005e-17f,
  2.85456217e-02f,  4.92287630e-02f,  6.02519917e-02f,  6.16112315e-02f,
  5.49129642e-02f,  4.28965551e-02f,  2.87825627e-02f,  1.55961772e-02f,
  5.60841059e-03f,  9.22543330e-17f, -1.20509096e-03f,  1.04664145e-03f,
  5.20644038e-03f,  9.56959135e-03f,  1.26902601e-02f,  1.36754220e-02f,
  1.23072021e-02f,  8.98922104e-03f,  4.55445497e-03f,  8.28753631e-19f,
 -3.77720578e-03f, -6.18010909f, -7.00782091f, -6.44057779f,
 -4.93426550f, -3.06486534f, -1.36963930f, -2.25406323f,
  2.11646089f,  1.99973327e-17f, -6.45991695f, -1.44291342f,
 -2.12530413f, -2.51012119f, -2.52625197f, -2.20857991f,
 -1.66591911f, -1.03738366f, -4.51740732f,  7.95699666e-19f,
  2.74942071f,  3.73904240f,  3.28444717f,  1.86264353f,  8.69478659e-19f
};

const int FIR_TAPS = sizeof(b_fir) / sizeof(float);

// FIR state buffer (older samples shift toward the end)
float fir_state[FIR_TAPS];

// Timing variable
unsigned long lastSampleMicros = 0;

/*
 * Setup
 *
 * Initialize serial port, ADC settings, and state buffer.
 */
void setup() {
  Serial.begin(115200);
  analogReadResolution(12);
  analogSetAttenuation(ADC_11db);
  for (int i = 0; i < FIR_TAPS; i++) {
    fir_state[i] = 0.0f;
  }
  lastSampleMicros = micros();
}

/*
 * FIR filter processing function
 *
 * Implements y[n] = sum_{k=0}^{M} b_fir[k] * x[n-k].  The most
 * recent sample is at fir_state[0], the oldest at fir_state[FIR_TAPS-1].
 */
float fir_process(float x) {
  // Shift state buffer
  for (int i = FIR_TAPS-1; i > 0; i--) {
    fir_state[i] = fir_state[i-1];
  }
  fir_state[0] = x;
  // Convolution
  float y = 0.0f;
  for (int i = 0; i < FIR_TAPS; i++) {
    y += b_fir[i] * fir_state[i];
  }
  return y;
}

/*
 * Loop
 *
 * Sample the analog input at the desired rate, filter it using the FIR
 * band-stop filter, and print the original and filtered values separated
 * by a comma.  Use the Serial Plotter to visualize the results.
 */
void loop() {
  unsigned long now = micros();
  if (now - lastSampleMicros >= SAMPLE_DT) {
    lastSampleMicros += SAMPLE_DT;
    // Read ADC and normalize to 0..1
    int raw = analogRead(ADC_PIN);
    float x = (float)raw / 4095.0f;
    // Filter the sample
    float y = fir_process(x);
    // Print original and filtered values
    Serial.print(x, 6);
    Serial.print(',');
    Serial.println(y, 6);
  }
}
