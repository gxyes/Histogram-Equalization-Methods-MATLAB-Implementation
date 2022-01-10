function optPixelValue = PixelMapping(inHist, dimImage)
    frequency = inHist/(dimImage(1)*dimImage(2));
    accumulation = zeros(1, 256);
    accumulation(1, 1) = frequency(1, 1);
    for i = 2:256
        accumulation(1,i) = accumulation(1,i-1) + frequency(1,i);
    end
    optPixelValue = floor(accumulation * 255);
    