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

### Reference Links

> **Mean Brightness Preserving Histogram Equalization**
>
> - BBHE: https://ieeexplore.ieee.org/abstract/document/580378
> - QBHE: https://ieeexplore.ieee.org/abstract/document/595370
> - DSIHE: https://ieeexplore.ieee.org/abstract/document/754419
> - MMBEBHE: https://ieeexplore.ieee.org/abstract/document/1261234
> - RMSHE: https://ieeexplore.ieee.org/abstract/document/1261233
> - RSIHE: https://www.sciencedirect.com/science/article/pii/S0167865507000578?casa_token=7TmXPEj-l6sAAAAA:mcGaEP_1ZJtVDNKsGZ6uQWjtEg-6Dyh58pjs2wyENTQhwGPcZ6zge0SC8lltS_2fps44WyxMbp8
> - RSWHE: https://ieeexplore.ieee.org/abstract/document/4637632
>
> **Local Histogram Equalization** 
>
> - CLAHE: https://link.springer.com/article/10.1007%2FBF03178082
> - POSHE: https://ieeexplore.ieee.org/abstract/document/915354
> - AHE: https://www.sciencedirect.com/science/article/abs/pii/S0734189X8780186X
> - BPDHE: https://ieeexplore.ieee.org/abstract/document/4266947
>
> **Clipping-Based Histogram Equalization**
>
> - WTHE: https://ieeexplore.ieee.org/abstract/document/4429280
> - BUBOHE: https://ieeexplore.ieee.org/abstract/document/1247104
> - AMHE: https://link.springer.com/chapter/10.1007/11949534_116
> - ESIHE: https://www.sciencedirect.com/science/article/pii/S0030402614006111?casa_token=FfZntslCMfsAAAAA:3M8PQm2aM0vMwZP9nu5s4VyJuC_3m2Atj0ThpjgEmMJbsRttsO6saNxpXjn-ujqfc8IDGiK2lq0
>
> **Others**
>
> - https://www.sciencedirect.com/science/article/pii/S135044951730155X?casa_token=eJUkMwf3--0AAAAA:3965n7vmwv26y1HQV1xohdwZ9nGvjTTVRdGaSiv_WBvrBYld0szxz7fAVmOqw-ha0mHbVdgbrpQ
> - https://ieeexplore.ieee.org/abstract/document/1706495
> - https://ieeexplore.ieee.org/abstract/document/4429280
> - https://ieeexplore.ieee.org/abstract/document/5722541
> - https://www.sciencedirect.com/science/article/pii/S0167865513003280?casa_token=97Vgv4Q2HQAAAAAA:WvcPyKWYeOleFK1fBISNUJ4R-NvAhvZpHHCGjtTHt0kBoJqxMazUdnv0PnoSeag-wXOrukMBXL4



