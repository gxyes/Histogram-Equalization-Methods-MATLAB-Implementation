function optImage = BBHE(imagePath)
    % Read the input image
    Image = imread(imagePath);
    Image = uint16(Image);
    [rows, columns, ~] = size(Image);
    
    % Average gray value
    % Min and Max gray value
    grayMean = floor(mean2(Image)); 
    grayMin = min(min(Image));
    grayMax = max(max(Image));
    
    grayLower = zeros(1, grayMean + 1);
    grayUpper = zeros(1, 256);
    
    numLower = 0;
    numUpper = 0;
    
    for i = 1:rows
        for j = 1:columns
            if Image(i, j) < grayMean || Image(i, j) == grayMean
                grayLower(Image(i,j)+1) = grayLower(Image(i,j)+1) + 1; 
                numLower = numLower + 1;
            else
                grayUpper(Image(i,j)+1) = grayUpper(Image(i,j)+1) + 1;
                numUpper = numUpper + 1;
            end
        end
    end
    
    lowerSideGrayUpper = grayMean + 1;
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
    for i=2:grayMean+1
        cumLower(i) = probLower(i) + cumLower(i-1);
    end
    for i=lowerSideGrayUpper+1:256
        cumUpper(i) = probUpper(i) + cumUpper(i-1);
    end
    
    histLower = cumLower;
    histUpper = cumUpper;
    
    % Graylevel
    for i=1:grayMean
       histLower(i) = grayMin + cumLower(i)*(grayMean - grayMin);
    end
    for i=lowerSideGrayUpper:256
       histUpper(i) = lowerSideGrayUpper + cumUpper(i)*(grayMax - lowerSideGrayUpper);
    end
    
    % Combine
    imageCombine = Image;
    for i=1:rows
        for j=1:columns
            if Image(i, j) < grayMean || Image(i, j) == grayMean
                imageCombine(i,j) = histLower(Image(i,j)+1); 
            else
                grayUpper(Image(i,j)+1) = grayUpper(Image(i,j)+1) + 1;
                imageCombine(i,j) = histUpper(Image(i,j)+1); 
            end
        end
    end
    optImage = uint8(imageCombine);
end