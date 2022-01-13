function optImage = RSWHE(imagePath)
    % Read your input image from some path
    Image = imread(imagePath);
    imageHist = imhist(Image);
    Image = double(Image);
    [rows, columns, ~] = size(Image);
    optImage = zeros(rows, columns);
    
    % Image info
    numPixels = rows*columns;
    grayMean = floor(mean2(Image)); 
    grayMedian = (median(Image, "all"));
    disp(grayMean);
    disp(grayMedian);
    grayMin = min(min(Image));
    grayMax = max(max(Image));
   
    % Whole PDF calculation
    PDF=zeros(1, grayMax-grayMin+1);
    for i=grayMin+1:grayMax+1
        PDF(i)=imageHist(i)/numPixels;			
    end
    
    pMax = max(PDF);
    pMin = min(PDF);    
   
    % Default beta, we can change this value
    beta = pMax*abs(grayMean-grayMedian)/(grayMax-grayMin);
 
    % r settings
    r = 2; % Can change this value
    length = 2^r + 1;
    grayXM = zeros(1, length);
    grayXM(1) = grayMax + 1;
    grayXM(2) = grayMin + 1;
    
    for i=3:length
        divRange = ((i-2)*numPixels)/(2^r);
        grayXM(i) = CDFDivCal(imageHist, divRange);
    end
    
    % Sort the division level list 
    grayXM = sort(grayXM);
    for i=2:2^r
        [rowPos,colPos]=find((Image>=grayXM(i-1)-1)&(Image<=grayXM(i)-2)); 
        optImage=HE(Image,optImage,rowPos,colPos,imageHist,grayXM(i-1)-1,grayXM(i)-2,pMax, pMin, beta, numPixels);
    end
    [rowPos,colPos]=find((Image>=grayXM(2^r)-1)&(Image<=grayXM(2^r+1)-1));
    optImage=HE(Image,optImage,rowPos,colPos,imageHist,grayXM(2^r)-1,grayXM(2^r+1)-1,pMax, pMin, beta, numPixels);
    optImage = uint8(optImage);
end

function grayXM=CDFDivCal(imageHist,divRange)
    % find every division gray level value
    cum(1)=imageHist(1);    
    for i=2:256
        cum(i)=imageHist(i)+cum(i-1);
    end
    index=find(cum>=divRange);
    grayXM=index(1);
end

function optImage=HE(Image,optImage,row,col,imageHist,min,max, pMax, pMin, beta, numPixels)

    numPixelsPartial=size(col,1);          
    PDF=zeros(1,max-min+1);
    alphaSum = 0;
    for i=min+1:max+1
        alphaSum = alphaSum + sum(imageHist(i)/numPixels);
    end

    % PDF calculation
    for i=min+1:max+1
        PDF(i-min) = pMax*(((imageHist(i)/numPixelsPartial-pMin)/(pMax-pMin))^alphaSum) + beta;
    end
    
    % PDF normalization
    PDF = PDF / sum(PDF);
  
    % CDF calculation
    CDF=zeros(1,max+1);
    CDF(min+1)=PDF(1);
    for i=min+2:max+1
        CDF(i)=PDF(i-min)+CDF(i-1);	
    end

    % Output histogram & image
    optHist=min+(max-min)*CDF;
    for k=1:numPixelsPartial
        optImage(row(k),col(k))=floor(optHist(Image(row(k),col(k))+1));
    end
end