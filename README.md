<!--horizontal divider(gradiant)-->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif">

<!--Repo Banner-->
<img height=350 alt="Repo Banner - IIR-Filters-and-FIR-Filters" src="https://capsule-render.vercel.app/api?type=waving&color=c4a2bd&height=300&section=header&text=IIR%20Filters%20and%20FIR%20Filters%20Design&fontSize=50&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=MATLAB%20code%20and%20Analysis&descAlignY=60&descAlign=50"></img>

<!--Title-->
<p align="center">
  <b>IIR Filters and FIR Filters</b>
  <br> <small> <i>- Infinite Impulse Response (IIR) filters and Finite Impulse Response (FIR) filters -</i> </small> <br>
</p>  


<!--Body-->
## Definition and Basic Characteristics:

IIR Filters:  
- Infinite Impulse Response (IIR) filters have an impulse response that theoretically continues indefinitely.
- Characteristics:
  - Can achieve a desired frequency response with a lower order (fewer coefficients) compared to FIR filters.
  - Often implemented using recursive algorithms, meaning the output depends on previous outputs.
  - Commonly designed using analog filter design methods and then transformed into digital filters.
  - More efficient in terms of computational resources due to fewer coefficients.
  - May suffer from stability issues if not properly designed.

FIR Filters:
- Finite Impulse Response (FIR) filters have an impulse response that settles to zero in a finite number of steps.
- Characteristics:
  - Non-recursive: the output depends only on current and past input values.
  - Always stable, as they do not rely on feedback.
  - Easier to design with exact linear phase characteristics.
  - Require more coefficients to achieve a similar frequency response as IIR filters, making them potentially more computationally intensive.
<br>

## Mathematical Representation:

IIR Filters:  
- The output of an IIR filter is given by the following difference equation:
  - $y[n]=-\sum_{k = 1}^{M} aky[n-k]+\sum_{k = 0}^{N} bkx[n-k]$
- Where:
  - $y[n]$ is the output signal at time $n$.
  - $x[n]$ is the input signal at time $n$.
  - $ak$ and $bk$ are the filter coefficients.
  - $M$ is the order of the feedback part (denominator).
  - $N$ is the order of the feedforward part (numerator).

FIR Filters:
- The output of an FIR filter is given by:
  - $y[n]=\sum_{k = 0}^{N} bkx[n-k]$
- Where:
  - $y[n]$ is the output signal at time $n$.
  - $x[n]$ is the input signal at time $n$.
  - $bk$ is the filter coefficient.
  - $N$ is the order of the filter (number of taps minus one).
<br>

##  Design and Implementation

Design of IIR Filters:
- Typically designed using analog filter design techniques (e.g., Butterworth, Chebyshev, Elliptic filters) and then transformed into digital form using methods like bilinear transformation.
- Design involves determining the poles and zeros of the transfer function to meet specific criteria such as passband, stopband, ripple, and attenuation.

Design of FIR Filters:
- FIR filters can be designed using windowing techniques (e.g., Hamming, Hanning, Blackman windows) or by optimization methods like the Parks-McClellan algorithm.
- Design involves directly specifying the filter coefficients to achieve a desired frequency response.
<br>

## Applications

IIR Filters:
- Suitable for applications where computational efficiency is critical, such as real-time signal processing.
- Commonly used in audio processing, communications, and control systems.

FIR Filters:
- Ideal for applications requiring a linear phase response, such as data transmission and image processing.
- Often used in applications where filter stability is paramount.

## Comparison

- Efficiency: IIR filters are generally more efficient due to fewer coefficients.
- Stability: FIR filters are inherently stable, while IIR filters can be unstable if not designed carefully.
- Phase Response: FIR filters can be designed to have a linear phase, which is challenging for IIR filters.
- Design Complexity: IIR filters are usually more complex to design due to the need for stability considerations.

## Summary

Understanding the fundamental differences and appropriate applications of IIR and FIR filters is crucial for designing efficient and effective digital signal processing systems. Each filter type has its own strengths and trade-offs, making them suitable for different kinds of applications based on specific requirements related to stability, phase linearity, and computational efficiency.

## License:

This project is licensed under the MIT License - see the
[LICENSE.md](https://github.com/Nariman-Z/RLC-Circuit-Analysis/blob/main/LICENSE) file for
details.
<br>
<br>
<br>
<br>


<!--Footer-->
### Made with ♥️ by: [Nariman_Z](https://github.com/Nariman-Z) ###
See also: [My Website](https://nariman-z.github.io/)

<!--horizontal divider(gradiant)-->
<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif">

<div>
  <p> Last Edited on:  June 14, 2024 </p>
  <!--profile visit count-->
    <a href="https://visitcount.itsvg.in">
    <img src="https://visitcount.itsvg.in/api?id=Nariman-Z&label=Total%20Views&color=12&icon=8&pretty=true" />
  </a>
</div>