function optImage = AMHE(imagePath)
    % Read the input image
    Image=imread(imagePath);
    
    % Image info
    imageHist = imhist(Image);
    [rows, columns] = size(Image);
    
    optImage=zeros(rows,columns);
    numPixels  =rows*columns;
    numBins = 256;
    %a=0.7

    grayMean=avePixel(imageHist,1,256);
    grayMeanLower=avePixel(imageHist,1,grayMean);
    grayMeanUpper=avePixel(imageHist,grayMean+1,256);

    a=zeros(1,256);
    for i=1:grayMean+1
        a(i)=(grayMean-grayMeanLower)/(grayMeanUpper-grayMeanLower);
    end
    for i=grayMean+2:256
        a(i)=(grayMeanUpper-grayMean)/(grayMeanUpper-grayMeanLower);
    end

    % PDF and frequency calculation
    PDF=imageHist/numPixels;
    freMax=max(PDF);
    freMin=min(PDF);
    freMean=0.5*(freMin+freMax);

    % New PDF
    for i=1:256
        if PDF(i)>freMean
            freOpt(i)=freMean+a(i)*((PDF(i)-freMean)^2)/(freMax-freMean);
        else
            freOpt(i)=freMean-a(i)*((freMean-PDF(i))^2)/(freMean-freMin);
        end
    end

    % CDF calculation
    CDFOpt(1)=freOpt(1);
    for i=2:256
        CDFOpt(i)=freOpt(i)+CDFOpt(i-1);
    end
    
    CDF=zeros(1,256);
    CDF=CDFOpt/CDFOpt(numBins);
    Mapping=(numBins-1)*CDF;
    
    % Output image calculation
    for i=1:rows
        for j=1:columns
            optImage(i,j)=floor(Mapping(Image(i,j)+1))-1;
        end
    end
    optImage=uint8(optImage);
end

function grayXM=avePixel(imageHist,startPos,endPos)
    sumPixel=0;
    Sum=0;
    for i=startPos:endPos
        % Value
        sumPixel=(i-1)*imageHist(i)+sumPixel;
        % Num
        Sum=imageHist(i)+Sum;
    end
    grayXM=ceil(sumPixel/Sum);
end