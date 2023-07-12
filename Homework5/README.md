# EE475: Digital Image Processing (Fall 2018) - Homework 5

This repository contains the homework assignment 5 for the course EE475 - Digital Image Processing, Fall 2018. The focus of this homework is to explore and compare various edge detection methods, edge linking, image segmentation techniques including region growing, and clustering.

## Overview

1. **Noisy Edge Detection**: The goal is to analyze the Circles image and compare the performance of Sobel, Laplacian of Gaussian (LoG), and Canny edge detectors. We will also consider the effect of adding Gaussian noise to the image.

2. **Edge Linking and Completion**: Using the Building image, this task involves filtering the image, finding the gradient field, and applying high and low thresholding to obtain strong edges and continue those edges.

3. **Segmentation by Region Growing**: We will apply the seeded region growing method on the Berkeley_Deer image, where region seeds will be planted appropriately and regions will grow according to the color predicate. The result will be compared with the ground truth map.

4. **Segmentation by Clustering**: The goal is to perform image segmentation on the Gauss_rgb1 image using two feature vectors. The result will be compared with the ground truth map.

Refer to the individual problem sections for more details and specific instructions.

## Repository Structure

- `Homework5_description.docx`: Original homework problem statement
- `main_homework5_q*.m`: My MATLAB code for the assignment tasks
- `Homework5_Report.pdf`: Detailed report of my findings and solutions
- `Homework5_documents/`: This directory hosts all the necessary files, such as images and data files, needed to complete the tasks.