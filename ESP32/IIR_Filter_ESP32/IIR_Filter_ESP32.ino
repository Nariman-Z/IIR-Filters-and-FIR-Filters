/*
 * IIR_Filter_ESP32.ino
 *
 * Real-time embedded DSP implementation for the ESP32 microcontroller.
 * Samples an analog voltage input on GPIO34 (ADC1_CH6) at exactly 500 Hz
 * and executes an 8th-order recursive IIR Butterworth band-stop filter in real time.
 *
 * Filter Specifications:
 *   - Topology : Butterworth (Maximally Flat Passband)
 *   - Response : Band-Stop (Notch: 10 Hz – 40 Hz)
 *   - Sampling : fs = 500 Hz (dt = 2000 microseconds)
 *   - Prototype: Order 4 prototype -> Order 8 band-stop filter
 *   - Method   : Direct Form I recursive difference equation:
 *                y[n] = sum(b[k]*x[n-k]) - sum(a[k]*y[n-k])
 *
 * Coefficients generated via MATLAB butter():
 *   [b, a] = butter(4, [10 40]/(500/2), 'stop')
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

// IIR filter coefficients (Butterworth band-stop, order 4)
// Generated in MATLAB/Python using: butter(4, [10 40]/(500/2), 'stop')
// a[0] must be 1.0.  Note that the order of this filter is 8
// (because band-stop doubles the prototype order).
const float b_iir[] = {
  0.60894463f,  -4.71667130f,  16.13590843f, -31.83607986f,
  39.61580614f, -31.83607986f,  16.13590843f,  -4.71667130f,  0.60894463f
};

const float a_iir[] = {
  1.00000000f,  -6.79443985f,  20.41599562f, -35.44632440f,
  38.90195777f, -27.63982960f,  12.41674467f,  -3.22490847f,   0.37081422f
};

// Lengths of numerator (M+1) and denominator (N+1)
const int IIR_NB = sizeof(b_iir) / sizeof(float);
const int IIR_NA = sizeof(a_iir) / sizeof(float);

// History buffers for past inputs x[n-1], x[n-2], ... and outputs y[n-1], y[n-2], ...
// Maximum length needed is (max(IIR_NB, IIR_NA) - 1)
float x_hist[IIR_NB];
float y_hist[IIR_NA];

// Timing variable
unsigned long lastSampleMicros = 0;

/*
 * Setup
 *
 * Initialize serial port, ADC settings, and state buffers.
 */
void setup() {
  Serial.begin(115200);
  // Configure ADC: 12-bit resolution and maximum attenuation (0-3.3V range)
  analogReadResolution(12);
  analogSetAttenuation(ADC_11db);

  // Zero-initialize history buffers
  for (int i = 0; i < IIR_NB; i++) {
    x_hist[i] = 0.0f;
  }
  for (int i = 0; i < IIR_NA; i++) {
    y_hist[i] = 0.0f;
  }

  lastSampleMicros = micros();
}

/*
 * IIR filter processing function
 *
 * Processes one sample x and returns the filtered sample y.  Implements
 * the difference equation:
 *   y[n] = b0*x[n] + b1*x[n-1] + ... + bM*x[n-M]
 *          - a1*y[n-1] - ... - aN*y[n-N]
 * where a[0] is assumed to be 1.
 */
float iir_process(float x) {
  // Compute feedforward part
  float y = b_iir[0] * x;
  for (int i = 1; i < IIR_NB; i++) {
    y += b_iir[i] * x_hist[i-1];
  }
  // Compute feedback part
  for (int i = 1; i < IIR_NA; i++) {
    y -= a_iir[i] * y_hist[i-1];
  }
  // Update history buffers: shift values
  for (int i = IIR_NB-1; i > 0; i--) {
    x_hist[i] = x_hist[i-1];
  }
  x_hist[0] = x;
  for (int i = IIR_NA-1; i > 0; i--) {
    y_hist[i] = y_hist[i-1];
  }
  y_hist[0] = y;
  return y;
}

/*
 * Loop
 *
 * Sample the analog input at the desired rate, filter it, and print
 * the original and filtered values separated by a comma.  Open the
 * Serial Plotter (Tools > Serial Plotter) to view the waveforms.
 */
void loop() {
  unsigned long now = micros();
  if (now - lastSampleMicros >= SAMPLE_DT) {
    lastSampleMicros += SAMPLE_DT;

    // Read the ADC and normalize to 0..1
    int raw = analogRead(ADC_PIN);
    float x = (float)raw / 4095.0f;
    // Process through IIR filter
    float y = iir_process(x);
    // Print original and filtered values
    Serial.print(x, 6);
    Serial.print(',');
    Serial.println(y, 6);
  }
}
