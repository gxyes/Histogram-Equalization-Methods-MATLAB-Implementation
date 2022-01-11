function [optImage, AMBE] = MMBEBHE(imagePath)
    % Read the input image
    Image = imread(imagePath);
    
    % Get image histogram
    imgHist = imhist(Image);
    
    % Get possible threshhold
    possibleThreshold = find(imgHist);
    possibleThreshold = possibleThreshold';
    
    % Get the output image with the best ABME performance
    AMBEList = [];
    for i=1:length(possibleThreshold)
        threshold=possibleThreshold(1,i);
        [~, AMBE] = genAMBEAndImage(Image,threshold);
        AMBEList = [AMBEList AMBE];
    end
    
    % Sort the AMBE list and get the best threshold
    [~, rankPosition] = sort(AMBEList);
    
    bestThreshold = possibleThreshold(1, rankPosition(1, 1));
    
    % Generate the output image and AMBE value
    [optImage, AMBE] = genAMBEAndImage(Image, bestThreshold);
end

function [optImage, AMBE] = genAMBEAndImage(Image, threshold)
    Image = uint16(Image);
    [rows, columns, ~] = size(Image);
    
    % Average gray value
    % Min and Max gray value
    grayThreshold = threshold; 
    grayMin = min(min(Image));
    grayMax = max(max(Image));
    
    grayLower = zeros(1, grayThreshold+1);
    grayUpper = zeros(1, 256);
    
    numLower = 0;
    numUpper = 0;
    
    for i = 1:rows
        for j = 1:columns
            if Image(i, j) < grayThreshold || Image(i, j) == grayThreshold
                grayLower(Image(i,j)+1) = grayLower(Image(i,j)+1) + 1; 
                numLower = numLower + 1;
            else
                grayUpper(Image(i,j)+1) = grayUpper(Image(i,j)+1) + 1;
                numUpper = numUpper + 1;
            end
        end
    end
    
    lowerSideGrayUpper = min(256, grayThreshold + 1);
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
    for i=2:grayThreshold+1
        cumLower(i) = probLower(i) + cumLower(i-1);
    end
    for i=lowerSideGrayUpper+1:256
        cumUpper(i) = probUpper(i) + cumUpper(i-1);
    end
    
    histLower = cumLower;
    histUpper = cumUpper;
    
    % Graylevel
    for i=1:grayThreshold
       histLower(i) = grayMin + cumLower(i)*(grayThreshold - grayMin);
    end
    for i=lowerSideGrayUpper:256
       histUpper(i) = lowerSideGrayUpper + cumUpper(i)*(grayMax - lowerSideGrayUpper);
    end
    
    % Combine
    imageCombine = Image;
    for i=1:rows
        for j=1:columns
            if Image(i, j) < grayThreshold || Image(i, j) == grayThreshold
                imageCombine(i,j) = histLower(Image(i,j)+1); 
            else
                grayUpper(Image(i,j)+1) = grayUpper(Image(i,j)+1) + 1;
                imageCombine(i,j) = histUpper(Image(i,j)+1); 
            end
        end
    end
    optImage = uint8(imageCombine);
    AMBE = abs(mean(mean(Image))-mean(mean(imageCombine)));
end