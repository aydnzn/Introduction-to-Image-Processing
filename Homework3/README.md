# EE 475: Digital Image Processing (Fall 2018) - Homework 3

This repository contains the homework assignment 3 for the course EE 475 - Digital Image Processing, conducted in Fall 2018. The goal of this homework is to explore and apply various image processing techniques like smoothing, noise estimation, filtering, and others on different types of noise and images. Additionally, this homework provides an understanding of image quality metrics and the concept of heat maps in data visualization.

## Overview

1. **Mean vs Median**: Comparing the effect of smoothing an 8x8 image using an averaging mask and a median filter.

2. **Connectivity and Path Length**: Calculating the lengths of the shortest path 4-, 8- and m-paths in an image segment for two cases of gray-level connectivity.

3. **Estimation of Noise Parameters**: Estimating the parameters of the Rayleigh pdf from the moments for a given contaminated image.

4. **Gaussian Noise**: Adding Gaussian noise to an image, applying various filters to denoise it, and comparing the results.

5. **Salt & Pepper Noise**: Investigating the effects of applying the median filter and alpha-trimmed mean filter on an image contaminated with salt-and-pepper noise.

6. **Image Quality Metrics**: Discussing the metrics used to evaluate the quality of images and the performance of image processing algorithms.

7. **Heat Maps**: Utilizing heat maps as an effective tool for data visualization.


## Repository Structure

- `Homework3_description.docx`: Original homework problem statement
- `main_homework3.m`: My MATLAB code for the assignment tasks
- `Homework3_Report.pdf`: Detailed report of my findings and solutions
- `Homework3_documents/`: This directory hosts all the necessary files, such as images and data files, needed to complete the tasks.
- `alphatrim.m`: This function, alphatrim, performs alpha-trimmed filtering on an input image to denoise it.