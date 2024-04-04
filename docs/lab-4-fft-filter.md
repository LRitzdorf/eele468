# Lab 4: Implementing an FFT Analysis/Synthesis System

## Filter Characteristics

As part of this project, I was assigned a lower boundary frequency ($f_1$) of 5 kHz and an upper boundary frequency ($f_2$) of 11 kHz.
After configuring the provided Simulink model with these parameters, it was found (in simulation) to produce the following frequency response in bandpass mode:
![FFT filter system, frequency response magnitude (bandpass mode)](/images/fft-bandpass-freq-resp.png)

## Project Completion

Thanks to the experience gained with the comb filter system, the process of implementing this FFT filter was relatively smooth.
However, it appears that Simulink exhibits some rather interesting behavior with regard to the **Oversampling factor** hardware parameter.
Specifically, upon performing HDL code generation, this parameter is reset to 2048, despite being manually set to 1 immediately before generating HDL code.

As with the previous comb filter system, the core content for this project was relatively straightforward.
Creating a custom hardware module, placing it on the lightweight Avalon bus, and implementing a corresponding driver is relatively common practice at this point.
