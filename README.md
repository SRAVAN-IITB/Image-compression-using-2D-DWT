# Image Compression using 2D Discrete Wavelet Transform

## Overview

This GitHub repository contains the complete project files for implementing image compression using 2D discrete wavelet transform (DWT), a voluntary project taken up by us at the end of our Digital Lab course (`EE214`) at **IIT Bombay**. The project employs the _filter-bank implementation technique_ for efficient image processing.

## Team
* [Sravan K Suresh](https://github.com/SRAVAN-IITB)
* [Vavilala Sathvik Reddy](https://github.com/)
* [Swarup Dasharath Patil](https://github.com/)
* [Tanish Anant Raghute](https://github.com/)

## Project Description

The project focuses on compressing images through a two-step process: row-wise and column-wise processing using the Haar wavelet basis function. The implementation is done using both MATLAB and Python for preprocessing, HDL (Hardware Description Language) for hardware implementation, and postprocessing using MATLAB and Python.\
\
Click on the adjacent link to view our project report &rarr; [Project Report](/report.pdf) \
Click on the adjacent link to watch the video demonstration of our project &rarr; [Demo](https://youtube.com) 

## Implementation Techniques

Two distinct approaches are utilized for DWT implementation:
- **Matrix Based Implementation:** A more hardware-intensive and expensive approach.
- **Filter Bank Implementation:** A simpler and more cost-effective approach utilizing basic logic elements.

## Filter Bank Architecture

The filter bank implementation involves several key modules:
- Averaging Module (Low pass filter for smoothening coefficients)
- Subtraction Module (High pass filter for detailing coefficients)
- 1D Wavelet Module (Row-wise processing)
- 2D Wavelet Module (Column-wise processing)
- 2D DWT Module (Integration of all sub-modules to form the final filter bank architecture)

## Weekly Milestones

### 1st Week
1. Literature Survey
2. Image Preprocessing (MATLAB and Python)
3. HDL Implementation of Averaging and Subtraction Module

### 2nd Week
1. Implementation of 1D and 2D Wavelet Module
2. Implementation of DWT Module and Modelsim Simulation

### 3rd Week
1. Using Platform Designer and its Testing
2. Implementation on Xen10 FPGA Board and Docklight Terminal
3. Image Quality Analysis and Documentation

## Repository Structure

The repository is organized as follows:
- **/MATLAB:** Contains MATLAB scripts for image preprocessing and postprocessing.
- **/Python:** Contains Python scripts for additional image postprocessing.
- **/HDL:** Contains HDL files for hardware implementation.
- **/Documentation:** Project documentation, including design specifications and analysis reports.

## Getting Started

To replicate the project or understand the implementation, refer to the respective folders for detailed instructions.

## Results

The compressed image quality is assessed using Peak Signal-to-Noise Ratio (PSNR). If PSNR > 25dB, the compressed image is considered of good quality!

