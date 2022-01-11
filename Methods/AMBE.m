function AMBEValue = AMBE(imageXPath, imageYPath)
    % Read images from some path
    imageX = imread(imageXPath);
    imageY = imread(imageYPath);
    
    AMBEValue = abs(mean(mean(imageX))-mean(mean(imageY)));
end