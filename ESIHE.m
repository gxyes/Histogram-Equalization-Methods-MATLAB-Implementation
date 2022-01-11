function optImage = ESIHE(imagePath)
    % Read the image from some path
    Image = imread(imagePath);
    Image = uint16(Image);
    [rows, columns, ~] = size(Image);
    
    % Gray values & input histogram
    grayMax = double(max(Image(:)));
    grayMin = double(min(Image(:)));
    bins = (grayMax-grayMin)+1;    
    imageHist = hist(double(Image(:)),bins);   
    
    % Clipping: larger than threshold => threshold
    pixelNumMean = round(mean(imageHist));
    clippedHist = zeros(size(imageHist));
    for i=1:bins
        if imageHist(i) > pixelNumMean
            clippedHist(i) = pixelNumMean;
        elseif imageHist(i) == 0
            clippedHist(i) = imageHist(i);
        else
            clippedHist(i) = imageHist(i);
        end
    end
    
    % Exposure threshold calculation
    exposureValue = sum(imageHist.*[0:1:bins-1]) / sum(imageHist) / (bins);
    aNorm=(1-exposureValue);
    grayXM=round(bins*aNorm);
    
    % ESIHE procedure    
    optImage=zeros(size(Image)); 
    
    % Lower and upper cum, num, and frenquency
    cumLower=zeros(1,grayXM+1);
    cumUpper=zeros(1,(256-(grayXM+1)));
    
    numLower=sum(clippedHist(1:grayXM+1));
    numUpper=sum(clippedHist(grayXM+2:bins));
    
    freLower=clippedHist(1:grayXM+1)/numLower;
    freUpper=clippedHist(grayXM+2:bins)/numUpper;
    
    % Obtain cum function
    cumLower(1)=freLower(1);
    for i=2:length(freLower)
        cumLower(i)=freLower(i)+cumLower(i-1);
    end    
    cumUpper(1)=freUpper(1);
    for i=2:(length(freUpper))
        cumUpper(i)=freUpper(i)+cumUpper(i-1);
    end    
    
    % Obtain the output image
    for i=1:rows                       
        for j=1:columns
            if Image(i,j)<(grayXM+1)
                value = grayXM*cumLower(Image(i,j)+1);
                optImage(i,j)=round(value);
            else
                value = (grayXM+1)+(bins-1-grayXM)*cumUpper((Image(i,j)-(grayXM+1))+1);
                optImage(i,j)=round(value);
            end
        end
    end   
    optImage = uint8(optImage);          
end