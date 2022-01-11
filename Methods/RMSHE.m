function optImage = RMSHE(imagePath)
    % Read your input image from some path
    Image = imread(imagePath);
    imageHist = imhist(Image);
    Image = uint16(Image);
    [rows, columns, ~] = size(Image);
    optImage = zeros(rows, columns);
    
    % Image info
    numPixels = rows*columns;
    grayMin = min(min(Image));
    grayMax = max(max(Image));
    
    % r settings
    r = 2; % Can change this value
    length = 2^r + 1;
    grayXM = zeros(1, length);
    grayXM(1) = grayMax + 1;
    grayXM(2) = grayMin + 1;
    
    for i=1:r
        % length
        for j=1:2^(i-1)
            grayXM(2^(i-1)+j+1) = avePixel(imageHist, grayXM(2^(i-1)-j+2), grayXM(2^(i-1)-j+1));
        end
        grayXM = sort(grayXM, 'descend');
    end
    
    % Sort the division level list 
    grayXM = sort(grayXM);
    for i=2:2^r
        [rowPos,colPos]=find((Image>=grayXM(i-1)-1)&(Image<=grayXM(i)-2)); 
        optImage=HE(Image,optImage,rowPos,colPos,imageHist,grayXM(i-1)-1,grayXM(i)-2);
    end
    [rowPos,colPos]=find((Image>=grayXM(2^r)-1)&(Image<=grayXM(2^r+1)-1));
    optImage=HE(Image,optImage,rowPos,colPos,imageHist,grayXM(2^r)-1,grayXM(2^r+1)-1);
    optImage = uint8(optImage);
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

function optImage=HE(Image,optImage,row,col,imageHist,min,max)

    numPixels=size(col,1);          
    PDF=zeros(1,max-min+1);
    
    % PDF calculation
    for i=min+1:max+1
        PDF(i-min)=imageHist(i)/numPixels;			
    end
    
    % CDF calculation
    CDF=zeros(1,max+1);
    CDF(min+1)=PDF(1);
    for i=min+2:max+1
        CDF(i)=PDF(i-min)+CDF(i-1);	
    end

    % Output histogram & image
    optHist=min+(max-min)*CDF;
    for k=1:numPixels
        optImage(row(k),col(k))=floor(optHist(Image(row(k),col(k))+1));
    end
end