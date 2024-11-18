# ADHD-EEG-Detection-Info
This repository contains info MATLAB code for analyzing EEG data to classify ADHD and healthy control children. The project utilizes EEGLAB for preprocessing and artifact removal, and deep learning models like ResNet50 and GoogleNet for classification. The dataset contains EEG signals recorded from children performing visual attention tasks.


---

## Dataset

The dataset is available on IEEE DataPort: [EEG data for ADHD/Control children](https://doi.org/10.21227/rzfh-zn36). 

### Key Details:
- **Participants**:
  - 61 children with ADHD and 60 healthy controls.
  - Ages: 7-12 years.
- **EEG Recording**:
  - Recorded using the 10-20 standard with 19 channels (Fz, Cz, Pz, etc.).
  - Sampling rate: 128 Hz.
  - Tasks: Visual attention with cognitive tasks involving cartoon character counting.
- **License**: Creative Commons Attribution.

---

## Project Features

1. **Preprocessing**:
   - Downsampling EEG data from 128 Hz.
   - Artifact removal using EEGLAB's `clean_artifacts` function.
   - Data buffering for time-series segmentation.

2. **Feature Extraction**:
   - Power spectral decomposition into Alpha, Beta, and Gamma bands using wavelet transforms.
   - Wavelet coherence visualization for ADHD and healthy controls.

3. **Deep Learning**:
   - **ResNet50** and **GoogleNet** fine-tuned for classifying ADHD and healthy controls.
   - Data split into training, validation, and testing sets.
   - Model evaluation using accuracy, sensitivity, specificity, F1 score, and AUC.

4. **Visualization**:
   - ROC curve for model performance.
   - Wavelet coherence images saved for visual analysis.

---

## Dependencies

- MATLAB with the following toolboxes:
  - Deep Learning Toolbox
  - Signal Processing Toolbox
  - Statistics and Machine Learning Toolbox
- **EEGLAB** (version 2023.1):
  - [Download EEGLAB](https://sccn.ucsd.edu/eeglab/index.php)

---

## Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/ADHD-EEG-Detection.git



## Results

### Confusion Matrix
The classification performance on the test dataset is summarized in the confusion matrix below:

### Metrics
- **Accuracy**: `99.1%`


### Description
The confusion matrix shows:
- **Normal Class**:
  - Correctly classified: `994`
  - Misclassified as ADHD: `9`
- **ADHD Class**:
  - Correctly classified: `1009`
  - Misclassified as Normal: `9`

This demonstrates high classification performance with balanced sensitivity and specificity.
