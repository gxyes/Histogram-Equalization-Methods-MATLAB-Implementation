function optImage = CLAHE(imagePath, numX, numY, numBins, clipLimit)
    % numX => number of regions in the X direction
    % numY => number of regions in the Y direction
    % clipLimit => the normalized clip limit
    
    % Read the image from some path
    Image = imread(imagePath);
    
    % Get basic info
    [rows, columns, minGrayValue, maxGrayValue] = imageInfo(Image);
    optImage = zeros(rows, columns);
    
    % clipLimit = 1 => clip all
    if clipLimit == 1
        return
    end
    
    % Get tile info
    numBins = max(numBins, 128);
    tileSizeX = round(rows/numX);
    tileSizeY = round(rows/numY);
    numTilePixels = tileSizeX * tileSizeY;
    
    % calculate the clip limit (for each tile (every bin))
    if clipLimit > 0 
        clipLimit = max(1,clipLimit*tileSizeX*tileSizeY/numBins);
    else
        clipLimit = 1E8;
    end
    
    % Change gray Value range
    grayValueLUT = makeLUT(minGrayValue, maxGrayValue, numBins);
    Bin = 1 + grayValueLUT(round(Image+1));

    % Create a 3D hist for the input image
    imageHist = makeHistogram(Bin,tileSizeX,tileSizeY,numX,numY,numBins);
    
    % Clipping 
    if clipLimit > 0
        clipHist = clipHistogram(imageHist,numBins,clipLimit,numX,numY);
    end    
    Mapping = mapHistogram(clipHist,minGrayValue,maxGrayValue,numBins,numTilePixels,numX,numY);
   
    % Interpolation
    optImage = imageInterpolate(Bin, numX, numY, tileSizeX, tileSizeY, Mapping, optImage);
    optImage = uint8(optImage);
end

function subOptImage = subImageInterpolate(subBin, upperLeft, upperRight, lowerLeft, lowerRight, subSizeX, subSizeY)
    subOptImage = zeros(size(subBin));
    numPixels = subSizeX * subSizeY;
    for i = 0:subSizeX-1
        inverseI = subSizeX - i;   
        for j = 0:subSizeY - 1
            inverseJ = subSizeY - j;  
            val = subBin(i+1, j+1);
            subOptImage(i+1, j+1) = fix((inverseI*(inverseJ*upperLeft(val) + j*upperRight(val)) ...
             + i*(inverseJ*lowerLeft(val) + j*lowerRight(val)))/numPixels);
        end
    end
end

function optImage = imageInterpolate(Bin, numX, numY, tileSizeX, tileSizeY, Mapping, optImage)
    x = 1;
    for i = 1:numX+1
        % top
        if i == 1
            subSizeX = tileSizeX/2;
            upperX = 1;
            lowerX = 1;
        else
            % bottom
            if i == numX + 1
                subSizeX = tileSizeX/2;
                upperX = numX;
                lowerX = numX;
            else
                subSizeX = tileSizeX;
                upperX = i - 1;
                lowerX = i;
            end
        end
        y = 1;
        for j = 1:numY + 1
            % left
            if j == 1
                subSizeY = tileSizeY/2;
                formerY = 1;
                laterY = 1;
            else
                % right
                if j == numY + 1
                    subSizeY = tileSizeY/2;
                    formerY = numY;
                    laterY = numY;
                else
                    subSizeY = tileSizeY;
                    formerY = j - 1;
                    laterY = j;
                end
            end
            upperLeft = Mapping(upperX, formerY, :);
            upperRight = Mapping(upperX, laterY, :);
            lowerLeft = Mapping(lowerX, formerY, :);
            lowerRight = Mapping(lowerX, laterY, :);
            subImage = Bin(x:x+subSizeX-1, y:y+subSizeY-1);
            subImage = subImageInterpolate(subImage, upperLeft, upperRight, lowerLeft, lowerRight, subSizeX, subSizeY);
            optImage(x:x+subSizeX-1, y:y+subSizeY-1) = subImage;
            y = y + subSizeY;
        end
        x = x + subSizeX;  
    end
end

function Mapping = mapHistogram(inputHist, minGrayValue, maxGrayValue, numBins, numTilePixels, numX, numY)
    Mapping = zeros(numX, numY, numBins);
    step = (maxGrayValue - minGrayValue) / numTilePixels;
    for i = 1:numX
        for j = 1:numY
            cum = 0;
            for bin = 1:numBins
                cum = cum + inputHist(i, j, bin);
                Mapping(i, j, bin) = fix(min(minGrayValue + cum*step, maxGrayValue));
            end
        end
    end                
end

function clipHist = clipHistogram(inputHist, numBins, clipLimit, numX, numY)
    % Calculate for each tile
    for i = 1:numX
        for j = 1:numY
            numExcess = 0;
            % Check if excess for each tile
            for bin = 1:numBins
                tileBinExcess = inputHist(i, j, bin) - clipLimit;
                if tileBinExcess > 0
                    numExcess = numExcess + tileBinExcess;                    
                end
            end
            
            % Clipping
            binIncrease = numExcess/numBins;
            upperLimit = clipLimit - binIncrease;
            for bin = 1:numBins
                if inputHist(i, j, bin) > clipLimit
                    inputHist(i, j, bin) = clipLimit;
                else
                    if inputHist(i, j, bin) >upperLimit
                        inputHist(i,j,bin) = clipLimit;
                        numExcess = numExcess + upperLimit - inputHist(i,j,bin);
                    else
                        inputHist(i,j,bin) = inputHist(i,j,bin) + binIncrease;
                        numExcess = numExcess - binIncrease;
                    end
                end
            end   
            
            if numExcess > 0
                stepSize = max(1,fix(1+numExcess/numBins));
                for bin = 1:numBins
                    numExcess = numExcess - stepSize;
                    inputHist(i,j,bin) = inputHist(i,j,bin) + stepSize;
                    if numExcess < 1
                        break;
                    end
                end
            end
        end
    end
    clipHist = inputHist;
end

function optHist = makeHistogram(Bin, tileSizeX, tileSizeY, numX, numY, numBins)
    optHist = zeros(numX, numY, numBins);
    for i = 1:numX
        for j = 1:numY
            bin = Bin(1+(i-1)*tileSizeX:i*tileSizeX, 1+(j-1)*tileSizeY:j*tileSizeY);
            for m = 1:tileSizeX
                for n = 1:tileSizeY
                    optHist(i, j, bin(m, n)) = optHist(i, j, bin(m, n)) + 1;
                end
            end
        end
    end
end

function grayValueLUT = makeLUT(minGrayValue, maxGrayValue, numBins)
    Max = maxGrayValue + max(1, minGrayValue) - minGrayValue;
    Min = max(1, minGrayValue);
    
    binSize = fix(1+(maxGrayValue - minGrayValue)/numBins);
    grayValueLUT = zeros(fix(maxGrayValue - minGrayValue),1);
    for i = Min:Max
        grayValueLUT(i) = fix((i - Min)/binSize);
    end
end

function [rows, columns, minGrayValue, maxGrayValue] = imageInfo(Image)
    % Image size
    [rows, columns, ~] = size(Image);
    
    % Get minGrayLevel, maxGrayLevel
    [~, x] = imhist(Image);
    minGrayValue = min(x);
    maxGrayValue = max(x);    
end