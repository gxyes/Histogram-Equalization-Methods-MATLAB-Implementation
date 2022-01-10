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