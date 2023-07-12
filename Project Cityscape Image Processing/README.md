# Cityscape Image Processing Project

This repository contains the code, model, and results of the Cityscape Image Processing project. Utilizing the Place Pulse II dataset, a binary classification task is created using the safety score label. 

## Dataset

The Place Pulse II dataset includes:

- 1.17 million comparisons
- 6 labels: safe, lively, boring, wealthy, depressing, beautiful
- Images from 56 cities
- Scoring method: TrueSkill

In the scope of this project, the focus is on the safety score. The dataset is split into a training set of 1000 images and a test set of 100 images.

## Preprocessing

The images undergo several preprocessing steps:

1. Cropping
2. Denoising with the Wiener Filter
3. Enhancement through Histogram Equalization
4. Sharpening

## Feature Extraction

Features are extracted from the preprocessed images using the following methods:

- **Color Histograms**: For each of the R, G, B color channels, 4 bins are calculated over 16 sub-blocks of the image. This results in a feature vector of length 192 (4x3x16).
- **Gist Descriptor**: Each image is divided into 16 subblocks, and 32 orientations/bins are computed for each subblock. This gives a feature vector of length 512 (16x32).
- **Discrete Wavelet Transform (DWT)**: The DWT yields a feature vector of size 128.

Different combinations of these feature vectors are used for classification, such as using only color histogram features, only Gist features, and various combinations of two or all three feature types. The feature vectors are concatenated before feeding them into the classifier.

## Models and Training

The Support Vector Machine (SVM) classifier from the fitcsvm function in MATLAB is used to train the models. Different models are trained with different feature sets to compare performance.

## Results

The performance of different models trained with various feature sets is compared. Accuracy scores for each model and feature set combination are provided in the Results directory.

This project aims to contribute to the ongoing research on urban perception and the automated understanding of urban environments. 

## Repository Structure

- `Feedback_paper.docx`: Our Literature Review on Cityscape Image Processing and Urban Life Quality
- `Final_Presentation.m`: Final Presentation
- `Initial_Presentation.pdf`: Intermediate Presentation
- `scripts_and_doc/`: This directory hosts all the necessary files, such as scripts and data files.