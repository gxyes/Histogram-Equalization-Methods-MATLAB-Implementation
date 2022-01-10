function optImage = RMSHE(imagePath)
    % Read the input image
    Image = imread(imagePath);
    [rows, columns, ~] = size(Image);
    Image = uint16(Image);
    
    % Average gray value
    % Min and Max gray value
    grayMean = floor(mean2(Image));
    grayMin = min(min(Image));
    grayMax = max(max(Image));
    
    % Get image hist
    [grayValueCount, grayValue] = imhist(Image);
    pixelValue = sum(grayValueCount.*grayValue) / (numel(grayValueCount) * numel(grayValueCount));
    
    % Num of interations
    n = 2;
    
    % Output mean after n interations (formular in the paper)
    grayE = round(grayMean + (pixelValue - grayMean)/2^n);
    
    % BBHE part
    grayLower = zeros(1, grayE + 1);
    grayUpper = zeros(1, 256);
    
    numLower = 0;
    numUpper = 0;
    
    for i = 1:rows
        for j = 1:columns
            if Image(i, j) < grayE || Image(i, j) == grayE
                grayLower(Image(i,j)+1) = grayLower(Image(i,j)+1) + 1; 
                numLower = numLower + 1;
            else
                grayUpper(Image(i,j)+1) = grayUpper(Image(i,j)+1) + 1;
                numUpper = numUpper + 1;
            end
        end
    end
    
    lowerSideGrayUpper = grayE + 1;
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
    for i=2:grayE+1
        cumLower(i) = probLower(i) + cumLower(i-1);
    end
    for i=lowerSideGrayUpper+1:256
        cumUpper(i) = probUpper(i) + cumUpper(i-1);
    end
    
    histLower = cumLower;
    histUpper = cumUpper;
    
    % Graylevel
    for i=1:grayE
       histLower(i) = grayMin + cumLower(i)*(grayE - grayMin);
    end
    for i=lowerSideGrayUpper:256
       histUpper(i) = lowerSideGrayUpper + cumUpper(i)*(grayMax - lowerSideGrayUpper);
    end
    
    % Combine
    imageCombine = Image;
    for i=1:rows
        for j=1:columns
            if Image(i, j) < grayE || Image(i, j) == grayE
                imageCombine(i,j) = histLower(Image(i,j)+1); 
            else
                grayUpper(Image(i,j)+1) = grayUpper(Image(i,j)+1) + 1;
                imageCombine(i,j) = histUpper(Image(i,j)+1); 
            end
        end
    end
    optImage = uint8(imageCombine);   
end