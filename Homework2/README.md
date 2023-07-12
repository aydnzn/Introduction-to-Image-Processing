# EE475 Fall'18 - Homework 2

This directory contains my solutions to the second homework assignment for Introduction to Image Processing (Fall 2018-2019). This homework covers various aspects of image histogram interpretation, quantization, enhancement, filtering, and comparison.

## Assignment Overview

1. **Interpretation of Histograms:** Given certain images and their histograms, match each histogram to its corresponding image and provide explanations.

2. **Image Quantization:** Analyze the effects of different quantization parameters on image histograms and discuss what the spikes on histogram edges indicate.

3. **Histogram Equalization:** Implement a histogram equalization function in MATLAB and test it on given images. Compare the results with MATLAB's built-in `histeq.m` function and adaptive histogram equalization using `adapthisteq.m`.

4. **Color Image Enhancement:** Apply contrast stretching to RGB and HSV images and comment on the results. 

5. **Effects of Filtering on Histograms:** Sketch intuitive histograms for provided images, blur the images using different filters, and comment on the resulting histograms.

6. **Histogram Distance:** Apply histogram matching to improve poorly illuminated images, then use chi-square histogram distance and Kullback-Leibler distance to measure the improvement. Compare the distances before and after histogram matching.

## Repository Structure

- `Homework2_description.docx`: Original homework problem statement
- `main_homework2.m`: My MATLAB code for the assignment tasks
- `Homework2_Report.pdf`: Detailed report of my findings and solutions
- `Homework2_documents/`: This directory hosts all the necessary files, such as images and data files, needed to complete the tasks.
- `myhisteq.m`: My histogram equalization function
