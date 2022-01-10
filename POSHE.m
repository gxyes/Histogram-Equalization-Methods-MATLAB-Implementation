function optImage = POSHE(imagePath, numTails, numSteps)
    % Read image from some path
    Image = imread(imagePath);
    
    % Image info
    [rows, columns, ~] = size(Image);
    
    % Padding
    newRows = ceil(rows/numTails/numSteps) * numTails * numSteps;
    newColumns = ceil(columns/numTails/numSteps) * numTails * numSteps;
    
    % Current image
    newImage = padarray(Image, [newRows-rows newColumns-columns], 'replicate', 'post');
    optImage = zeros(newRows, newColumns, 'uint16');
    
    % Size of tails
    tailRows = newRows/numTails;
    tailColumns = newColumns/numTails;
    
    % Step num in row and column directions
    stepRow = tailRows/numSteps;
    stepColumn = tailColumns/numSteps;
    
    % HE for current tails
    optFrequency = zeros(newRows, newColumns, 'uint16');
    for tailX = 1:stepRow:(newRows-tailRows+1)
        for tailY = 1:stepColumn:(newColumns-tailColumns+1)
            tail = newImage(tailX:tailX+tailRows-1, tailY:tailY+tailColumns-1);
            tailHE = histeq(tail);
            tailHEX = 1;
            for i = tailX:(tailX+tailRows-1)
                tailHEY = 1;
                for j = tailY:(tailY+tailColumns-1)
                    optImage(i, j) = optImage(i, j) + uint16(tailHE(tailHEX, tailHEY));
                    optFrequency(i, j) = optFrequency(i, j) + 1;
                    tailHEY = tailHEY + 1;
                end
                tailHEX = tailHEX + 1;
            end
        end
    end
    optImage = optImage./optFrequency;
    optImage = uint8(optImage);  
    
    %BERF
    stepLevels = 2; 
    largeDis = 15;
    optImage = BERF(newImage, optImage, stepRow, stepColumn, stepLevels, largeDis);
    optImage = imcrop(optImage,[1,1,columns-1,rows-1]);
end