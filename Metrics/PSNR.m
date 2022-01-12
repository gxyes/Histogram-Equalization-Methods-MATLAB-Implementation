function [PSNR, MSE] = PSNR(imageXPath, imageYPath)
    % Read images from some path
    imageX = imread(imageXPath);
    imageY = imread(imageYPath);
    
    imageXDouble=double(imageX);
    imageYDouble=double(imageY);

    if nargin<2    
       D = imageXDouble;
    else
      if any(size(imageXDouble)~=size(imageYDouble))
        error('The input size is not equal to each other!');
      end
     D = imageXDouble - imageYDouble; 
    end
    MSE = sum(D(:).*D(:)) / numel(imageXDouble); 
    PSNR = 10*log10(255^2 / MSE);
end