### Histogram Equalization Methods

```matlab
% AHE => Adaptive Histogram Equalization
% optImage = AHE(numTiles, imagePath)
optImage = AHE([4, 4], imagePath);
```

```matlab
% BBHE => Brightness-preserving Bi-Histogram Equalization
% optImage = BBHE(imagePath)
optImage = BBHE(imagePath);
```

```matlab
% BDPHE => Brightness Preserving Dynamic Histogram Equalization
% optImage = BPDHE(imagePath)
optImage = BPDHE(imagePath);
```

```matlab
% CLAHE => Contrast Limited Adaptive Histogram Equalization
% optImage = CLAHE(imagePath, numX, numY, numBins, clipLimit)
optImage = CLAHE(imagePath, 4, 4, 256, 5);
```

```matlab
% DSIHE => Dualistic Sub-Image Histogram Equalization
% optImage = DSIHE(imagePath)
optImage = DSIHE(imagePath);
```

```matlab
% ESIHE => Exposure Based Sub Image Histogram Equalization
% optImage = ESIHE(imagePath)
optImage = ESIHE(imagePath);
```

```matlab
% MMBEBHE => Minimum Mean Brightness Error Histogram Equalization
% [optImage, AMBE] = MMBEBHE(imagePath)
[optImage, ~] = MMBEBHE(imagePath);
```

```matlab
% POSHE => Partially Overlapped Sub-block Histogram Equalization
% optImage = POSHE(imagePath, numTails, numSteps)
optImage = POSHE(imagePath, 4, 4);
```

```matlab
% RMSHE => Recursive Mean-Separate Histogram Equalization
% optImage = RMSHE(imagePath)
optImage = RMSHE(imagePath);
```

```matlab
% RSIHE => Recursive Sub-Image Histogram Equalization 
% optImage = RSIHE(imagePath)
optImage = RSIHE(imagePath);
```

```matlab
% WTHE => Weighted Thresholded Histogram Equalization
% optImage = WTHE(imagePath, gamma)
optImage = WTHE(imagePath, 1.2);
```

```matlab
% QBHE => Quantized Bi-Histogram Equalization
% optImage = QBHE(imagePath, numGray)
optImage = QBHE(imagePath, 32);
```

```matlab
% RSWHE => Recursive Separated and Weighted Histogram Equalization
% optImage = RSWHE(imagePath)
optImage = RSWHE(imagePath);
```

```matlab
% BUBOHE => Bin Underflow and Bin Overflow Histogram Equalization
% optImage = BUBOHE(imagePath, underFlow, overFlow)
optImage = BUBOHE(imagePath, 0.001, 0.999);
```

```matlab
% AMHE => Adaptively Modified Histogram Equalization
% optImage = AMHE(imagePath)
optImage = AMHE(imagePath);
```

### Quantitation Metrics

```matlab
% AMBE => Absolute Mean Brightness Error
% AMBE Larger => Better quality the output image has
AMBEValue = AMBE(imageXPath, imageYPath);
```

```matlab
% PSNR => Peak Signal to Noise Ratio
% PSNR Larger => Less distorted the output image

% MSE => Mean Square Error
% Lower MSE is generally preferred
[PSNRVal, MSEVal] = PSNR(imageXPath, imageYPath);
```

```matlab
% SSIM => Structral Similarity
% SSIM Larger => Less distorted the output image
SSIMValue = SSIM(imageXPath, imageYPath);
```

### Dataset Intro

> **Set12** is a collection of **12** grayscale images of different scenes that are widely used for evaluation of image processing methods. The size of each image from image01 to image05 is **256×256**, and the size of each image from image06 to image12 is **512×512**.

