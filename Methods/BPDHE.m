function optImage = BPDHE(imagePath)
    % Read image info
    Image = imread(imagePath);
    Image = uint16(Image);
    
    % Gray values
    inputImage = Image;
    grayMax = double(max(inputImage(:)));
    grayMin = double(min(inputImage(:)));
    bins = (grayMax-grayMin)+1;
    
    imageHist = hist(double(inputImage(:)),bins);
    
    % Filters
    % kernel size = 1*9
    % standard deviation = 1.0762
    gaussianFilter = fspecial('gaussian',[1 9],1.0762);
    blurHist = (imfilter(imageHist,gaussianFilter,'replicate'));
    
    % right - left => difference between two grayValue
    derivFilter = [-1 1];
    derivHist = imfilter(blurHist,derivFilter,'replicate');
    
    % Obtain a sign hist
    % From left to right => increase or decrease
    signHist = sign(derivHist);
    
    % Obtain a smoother sign hist
    meanFilter = [1/3 1/3 1/3];
    smoothSignHist = sign(imfilter(signHist,meanFilter,'replicate'));
    
    % Length of this filter is eight
    cmpFilter = [1 1 1 -1 -1 -1 -1 -1];
    
    localMax = zeros([1,3]);    
    
    % Start bound
    localMax(1) = 0;    
    indexMax = 2;
    % Filter length is 7
    for grayLevel = 1:bins-7
        isSame = smoothSignHist(grayLevel:grayLevel+7) == cmpFilter;
        % Same sign => same trend
        if sum(isSame) == 8
            % Trend => [1 1 1 -1 -1 -1 -1 -1]
            % grayLevel+3 is the local maximum => the 4th one
            localMax(indexMax) = grayLevel+3;
            indexMax = indexMax+1;
        end 
    end   
    % End bound
    localMax(indexMax) = bins;
    
    % How many local maximum bins we found
    factor = zeros([length(localMax)-1,1]);
    
    % Initialize essential params for each range
    span = factor;  % Range between max grayValue and min grayValue in a range
    M = factor;    % sum of num of pixels with all grayValue in a range
    range = factor;
    startValue = factor;
    endValue = factor;
    
    % Sub-hist for that specific range
    subHist = cell([length(localMax)-1,1]);
    
    % Calculate and store all these important params
    for m = 1:length(localMax)-1
        % Obtain the subHist
        subHist{m} = imageHist(localMax(m)+1:localMax(m+1));
        % num of pixels in this subHist
        M(m) = sum(subHist{m});        
        % low and high grayValue in this subHist
        low = grayMin + localMax(m);
        high = grayMin + localMax(m+1)-1; 
        % range
        span(m) = high-low+1;
        % factor calculation
        factor(m) = span(m)*log10(M(m));
    end    
    factorSum = sum(factor);
    
    % Calculate the "range" value for each sub-hist
    for m = 1:length(localMax)-1
        range(m) = round((256-grayMin)*factor(m)/factorSum);
    end
    
    % Calculate the range for sub-hists after mapping
    % Obtain the start and end value for each range
    startValue(1) = grayMin;
    endValue(1) = grayMin+range(1)-1;    
    for m = 2:length(localMax)-1
        startValue(m) = startValue(m-1)+range(m-1);
        endValue(m) = endValue(m-1)+range(m);
    end
    
    % Sub-hists after mapping => cumsum, frequency...
    subHistAfterMapping = cell([length(localMax)-1,1]);
    subRangeValue = zeros([1,grayMin]);
    for m = 1:length(localMax)-1
        histCum = cumsum(subHist{m});
        histCDF = histCum./M(m);
        subHistAfterMapping{m} = round(startValue(m)+(endValue(m)-startValue(m)).*histCDF);
        subRangeValue = [subRangeValue,subHistAfterMapping{m}];
    end
    
    % Output image calculation
    optGrayValue = zeros(size(inputImage));
    for grayLevel = grayMin:grayMax
        location = inputImage == grayLevel;
        optGrayValue(location) = double(subRangeValue(grayLevel+1))/255;
    end
    optImage = uint8(optGrayValue.*255);
end