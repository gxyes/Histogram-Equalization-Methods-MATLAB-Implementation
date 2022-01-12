function optImage = BUBOHE(imagePath, underFlow, overFlow)
    % Read the image from some path
    Image = imread(imagePath);
    optImage = zeros(size(Image));
    
    % Image info
    Image = uint16(Image);
    [rows, columns, ~] = size(Image);
    numPixels = rows*columns;
    
    % Image histogram and PDF
    imageHist = GetImageHist(Image);
    PDF = imageHist / numPixels;
    PDFEdittedBins = zeros(size(PDF));
    
    % Bin underflow and overflow
    for i=1:256
       if PDF(i) > overFlow
           PDFEdittedBins(i) = overFlow;
       else
           if PDF(i) < underFlow
               PDFEdittedBins(i) = underFlow;
           else
               PDFEdittedBins(i) = PDF(i);
           end
       end
    end
    
    % CDF
    CDF = cumsum(PDFEdittedBins);
 
    for i=1:rows
        for j=1:columns
            optImage(i, j) = CDF(Image(i,j)+1)*(256-0);
        end
    end
    optImage = uint8(optImage);            
end

function optGrayHist = GetImageHist(inGrayImage)
    % Input => Gray image
    % Output => The histogram of the gray image
    [rows, columns] = size(inGrayImage);
    optGrayHist = zeros(1, 256);
    for i = 1:rows
        for j = 1:columns
            optGrayHist(inGrayImage(i,j)+1) = optGrayHist(inGrayImage(i,j)+1) + 1;
        end
    end
end