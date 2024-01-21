# Homework 1: ADC Controller Register Map

This document describes the register map to be implemented by a custom controller component for the LTC2308 analog-to-digital converter.


## Design Requirements

The register map facilitates the following functionalities in a single configuration (i.e. without the need to write to the configuration register(s) in order to utilize all features):
- Single-ended sampling: measurement on any combination of the eight available channels, with respect to a common ground
- Differential sampling: measurement on any supported set of two channels, treated as a differential pair, with support for reversed polarity

All configuration occurs at runtime, rather than at elaboration/synthesis time.
This allows the component's host system to change measurement details at any time.

In addition, all configuration registers are read-write, so that the current configuration can be verified by the host system.
This was a major shortcoming of Intel's own IP core for this purpose.

While the LTC2308 supports a bipolar measurement mode, support for it is not implemented here, as the DE10-Nano system does not contain the appropriate power supply circuitry.
In addition, support for sleep mode is not implemented, since the ADC's power draw is insignificant compared to that of the DE10-Nano's on-board SoC FPGA.


## Register Map

The component's register layout is as follows:
| Offset | Register function   | Reset value |
|--------|---------------------|-------------|
| 0–7    | Single-ended data   | 0x000       |
| 8–15   | Differential data   | 0x000       |
| 16     | Single-ended config | 0x00        |
| 17     | Differential config | 0x00        |


### Data Registers

Measurements returned from the LTC2308 consist of twelve data bits.
These measurements are left-padded with zeros to fill the 32-bit register width, and presented in the corresponding data registers.

| Bits 31–12 | Bits 11–0   |
|:----------:|:-----------:|
| 0x00000    | Measurement |


### Single-Ended Configuration

Single-ended channel configuration simply consists of enabling or disabling a particular channel.
Each of the eight available channels has a corresponding enable bit in the single-ended sample configuration register.

| Bits 31–8  | Bit 7      | Bit 6      | Bit 5      | Bit 4      | Bit 3      | Bit 2      | Bit 1      | Bit 0      |
|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|
| Don't care | Ch7 enable | Ch6 enable | Ch5 enable | Ch4 enable | Ch3 enable | Ch2 enable | Ch1 enable | Ch0 enable |


### Differential Configuration

Differential channel configuration consists of enabling or disabling measurements on a particular channel pair and with a particular polarity.
Each of the four available pairs has two enable bits, one for each polarity, in the differential sample configuration register.

| Bits 31–8  | Bit 7      | Bit 6      | Bit 5      | Bit 4      | Bit 3      | Bit 2      | Bit 1      | Bit 0      |
|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|
| Don't care | Pr3, Ch7 + | Pr3, Ch6 + | Pr2, Ch5 + | Pr2, Ch4 + | Pr1, Ch3 + | Pr1, Ch2 + | Pr0, Ch1 + | Pr0, Ch0 + |

For example, setting bits 0 and 1 would cause two measurements to be taken across channel pair 0:
- one which uses channel 0 as the positive reference, and
- one which uses channel 1 as the positive reference.

Note that channels 0 and 1 form channel pair 0.
In general, the channel $Ch_n$ is a member of the channel pair $Pr_n = Ch_n \gg 1$.
