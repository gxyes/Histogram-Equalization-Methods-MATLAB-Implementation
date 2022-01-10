function optImage = DSIHE(imagePath)
    % Read the input image
    Image = imread(imagePath);
    Image = uint16(Image);
    [rows, columns, ~] = size(Image);
    
    % Median gray value
    % Min and Max gray value
    grayMedian = (median(Image, "all"));  
    grayMin = min(min(Image));
    grayMax = max(max(Image));
    
    grayLower = zeros(1, grayMedian + 1);
    grayUpper = zeros(1, 256);
    
    numLower = 0;
    numUpper = 0;
    
    for i = 1:rows
        for j = 1:columns
            if Image(i, j) < grayMedian || Image(i, j) == grayMedian
                grayLower(Image(i,j)+1) = grayLower(Image(i,j)+1) + 1; 
                numLower = numLower + 1;
            else
                grayUpper(Image(i,j)+1) = grayUpper(Image(i,j)+1) + 1;
                numUpper = numUpper + 1;
            end
        end
    end
    
    lowerSideGrayUpper = grayMedian + 1;
    while grayUpper(lowerSideGrayUpper)+1 == 0
        lowerSideGrayUpper = lowerSideGrayUpper + 1;
    end
    
    probLower = grayLower./numLower;
    probUpper = grayUpper./numUpper;    
    
    cumLower = grayLower;
    cumUpper = grayUpper;
    
    cumLower(1) = probLower(1);
    cumUpper(lowerSideGrayUpper) = probUpper(lowerSideGrayUpper);
    
    % CDF
    for i=2:grayMedian+1
        cumLower(i) = probLower(i) + cumLower(i-1);
    end
    
    for i=lowerSideGrayUpper+1:256
        cumUpper(i) = probUpper(i) + cumUpper(i-1);
    end
    
    histLower = cumLower;
    histUpper = cumUpper;
    
    % Graylevel
    for i=1:grayMedian
       histLower(i) = grayMin + cumLower(i)*(grayMedian - grayMin);
    end
    for i=lowerSideGrayUpper:256
       histUpper(i) = lowerSideGrayUpper + cumUpper(i)*(grayMax - lowerSideGrayUpper);
    end
    
    % Combine
    imageCombine = Image;
    for i=1:rows
        for j=1:columns
            if Image(i, j) < grayMedian || Image(i, j) == grayMedian
                imageCombine(i,j) = histLower(Image(i,j)+1); 
            else
                grayUpper(Image(i,j)+1) = grayUpper(Image(i,j)+1) + 1;
                imageCombine(i,j) = histUpper(Image(i,j)+1); 
            end
        end
    end
    optImage = uint8(imageCombine);
end