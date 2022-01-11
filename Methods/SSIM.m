function [mssim, ssimMap] = SSIM(imageXPath, imageYPath, K, window, L)
    % Read images from some path
    imageX = imread(imageXPath);
    imageY = imread(imageYPath);
    
    if (size(imageX) ~= size(imageY))
       ssimIndex = -Inf;
       ssimMap = -Inf;
       return;
    end
    
    [rows, columns, ~] = size(imageX);

    % Two inputs
    if (nargin == 2)
       % Image is too small
       if ((rows < 11) || (columns < 11))   
           ssimIndex = -Inf;
           ssimMap = -Inf;
           return
       end
       
       % Gaussian filter
       % => Kernel size = 11*11
       % => Standard deviation = 1.5
       window = fspecial('gaussian', 11, 1.5);        % 参数一个标准偏差1.5，11*11的高斯低通滤波。
       
       % Default setting
       K(1) = 0.01;                                   % default settings
       K(2) = 0.03;                                    
       L = 255;                                  
    end
    
    % Three inputs (similar...)
    if (nargin == 3)
       if ((rows < 11) || (columns < 11))
           ssimIndex = -Inf;
           ssimMap = -Inf;
           return
       end
       window = fspecial('gaussian', 11, 1.5);
       L = 255;
       if (length(K) == 2)
          if (K(1) < 0 || K(2) < 0)
               ssimIndex = -Inf;
               ssimMap = -Inf;
               return;
          end
       else
               ssimIndex = -Inf;
               ssimMap = -Inf;
               return;
       end
    end
    
    % Four inputs
    if (nargin == 4)
       [winH winW] = size(window);
       if ((winH*winW) < 4 || (winH > rows) || (winW > columns))
           ssimIndex = -Inf;
           ssimMap = -Inf;
           return
       end
       L = 255;
       if (length(K) == 2)
          if (K(1) < 0 | K(2) < 0)
               ssimIndex = -Inf;
               ssimMap = -Inf;
               return;
          end
       else
               ssimIndex = -Inf;
               ssimMap = -Inf;
               return;
       end
    end
    
    % Five inputs
    if (nargin == 5)
       [winH winW] = size(window);
       if ((winH*winW) < 4 | (winH > rows) | (winW > columns))
           ssimIndex = -Inf;
           ssimMap = -Inf;
           return
       end
       if (length(K) == 2)
          if (K(1) < 0 | K(2) < 0)
           ssimIndex = -Inf;
           ssimMap = -Inf;
           return;
          end
       else
           ssimIndex = -Inf;
           ssimMap = -Inf;
           return;
       end
    end
    
    if size(imageX,3)~=1  
       org=rgb2ycbcr(imageX);
       test=rgb2ycbcr(imageY);
       y1=org(:,:,1);
       y2=test(:,:,1);
       y1=double(y1);
       y2=double(y2);
     else 
         y1=double(imageX);
         y2=double(imageY);
     end
    imageX = double(y1); 
    imageY = double(y2);

    C1 = (K(1)*L)^2;    % C1
    C2 = (K(2)*L)^2;    % C2
    window = window/sum(sum(window)); 


    mu1   = filter2(window, imageX, 'valid');  
    mu2   = filter2(window, imageY, 'valid');  

    mu1_sq = mu1.*mu1;     % Ux square
    mu2_sq = mu2.*mu2;     % Uy square
    mu1_mu2 = mu1.*mu2;    % Ux*Uy

    sigma1_sq = filter2(window, imageX.*imageX, 'valid') - mu1_sq;  % sigmax SD
    sigma2_sq = filter2(window, imageY.*imageY, 'valid') - mu2_sq;  % sigmay SD
    sigma12 = filter2(window, imageX.*imageY, 'valid') - mu1_mu2;   % sigmaxy SD

    if (C1 > 0 && C2 > 0)
       ssimMap = ((2*mu1_mu2 + C1).*(2*sigma12 + C2))./((mu1_sq + mu2_sq + C1).*(sigma1_sq + sigma2_sq + C2));
    else
       numerator1 = 2*mu1_mu2 + C1;
       numerator2 = 2*sigma12 + C2;
       denominator1 = mu1_sq + mu2_sq + C1;
       denominator2 = sigma1_sq + sigma2_sq + C2;
       ssimMap = ones(size(mu1));
       index = (denominator1.*denominator2 > 0);
       ssimMap(index) = (numerator1(index).*numerator2(index))./(denominator1(index).*denominator2(index));
       index = (denominator1 ~= 0) & (denominator2 == 0);
       ssimMap(index) = numerator1(index)./denominator1(index);
    end
    mssim = mean2(ssimMap);
end