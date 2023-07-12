# EE 475: Digital Image Processing (Fall 2018) - Homework 4

This repository contains the homework assignment 4 for the course EE 475 - Digital Image Processing, conducted in Fall 2018. The goal of this homework is to delve deeper into the frequency domain operations, unsharp masking, high-boost filtering, noise removal, deblurring, and exploring the importance of the phase spectrum in image reconstruction.

## Overview

1. **Unsharp Masking and High-Boost Filtering**: Enhance an X-ray chest image using Gaussian high-pass filtering. This involves constructing an unsharp mask, high-boost filtering, and histogram equalization.

2. **Moiré Noise Removal**: Remove Moiré noise from a newspaper image. This involves the identification of spectral peaks, designing a notch filter, and extraction of the Moiré pattern.

3. **Deblurring**: Recover the original form of a degraded image by modeling the degradation and applying an inverse filter. Includes dealing with atmospheric turbulence, Gaussian noise, and camera motion distortion. 

4. **Importance of the Phase**: Reconstruct images from phase-only spectrum, magnitude-only spectrum, and mixtures of phase and magnitude spectra of different images.

In problems 1-3, operations are performed without zero padding directly in the frequency domain. The distortion ensuing from circular convolution is less important than the extra effort to interpolate spectra to the desired size. Spectra should be shifted by 180 degrees so that DC is in the center. Similarly, filters should be shifted to (M/2, N/2) where M and N are the image dimensions as stated in the problems.

Please refer to the individual problem sections for more details and specific instructions.

## Repository Structure

- `Homework4_description.docx`: Original homework problem statement
- `main_homework4_q*.m`: My MATLAB code for the assignment tasks
- `Homework4_Report.pdf`: Detailed report of my findings and solutions
- `Homework4_documents/`: This directory hosts all the necessary files, such as images and data files, needed to complete the tasks.