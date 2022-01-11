% Weighted and Thresholded HE
function optImage = WTHE(imagePath, gamma)
    % Read the image from some path
    Image = imread(imagePath);
    
    % Image info
    [rows, columns, ~] = size(Image);
    numPixels = rows*columns;
    aveNumPixels = numPixels/256;
    
    % PDF calculation
    PDF = imhist(uint8(Image));

    % Calculate max pdf value & threshold
    maxPDF = max(PDF);
    thresholdPDF = 0.5;

    % Division
    upperBound = thresholdPDF * maxPDF;
    lowerBound = aveNumPixels * 0.01;

    % Output PDF & Gamma settings
    optPDF = zeros(1,256);
    gammaVal = gamma;

    % Calculate the output PDF
    for i=1:256
        if PDF(i) > upperBound
            optPDF(i) = upperBound;
        elseif PDF(i) < lowerBound
            optPDF(i) = 0;
        else
            optPDF(i) = (((PDF(i) - lowerBound) / (upperBound - lowerBound))^gammaVal) * upperBound;
        end
    end

    optSumGrayValue = 0;
    for i=1:256
        optSumGrayValue = optSumGrayValue + optPDF(i);
    end

    % Output CDF
    optCDF = cumsum(optPDF)/optSumGrayValue;
    mapping = optCDF;
    optMax = 255;
   
    % Output image calculation
    optImage = zeros(rows,columns);
    for i=1:rows
        for j=1:columns
            optImage(i,j) = optMax * mapping(Image(i,j)+1);
        end
    end

    % apply Madj (inputMean - optMean) 
    inputMean = mean2(Image);
    optMean = mean2(optImage);
    diffMean = inputMean - optMean;

    for i=1:rows
        for j=1:columns
            optImage(i,j) = optImage(i,j) + diffMean;
            if optImage(i,j) > 255
                optImage(i,j) = 255;
            elseif optImage(i,j) < 0
                optImage(i,j) = 0;
            end
        end
    end
    optImage = uint8(optImage);
end