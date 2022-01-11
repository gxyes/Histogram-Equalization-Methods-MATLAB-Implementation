function RUN(imagePath)
    Image = imread("../Set12/11.png");
    imwrite(Image, '../11/ori11.png');
    
    optImage1 = AHE([4, 4], imagePath);
    imwrite(optImage1, '../11/AHE11.png');
    
    optImage2 = BBHE(imagePath);
    imwrite(optImage2, '../11/BBHE11.png');
    
    optImage3 = BPDHE(imagePath);
    imwrite(optImage3, '../11/BPDHE11.png');
    
    optImage4 = CLAHE(imagePath, 4, 4, 256, 5);
    imwrite(optImage4, '../11/CLAHE11.png');
    
    optImage5 = DSIHE(imagePath);
    imwrite(optImage5, '../11/DSIHE11.png');
    
    optImage6 = ESIHE(imagePath);
    imwrite(optImage6, '../11/ESIHE11.png');
    
    [optImage7, ~] = MMBEBHE(imagePath);
    imwrite(optImage7, '../11/MMBEBHE11.png');
    
    optImage8 = POSHE(imagePath, 4, 4);
    imwrite(optImage8, '../11/POSHE11.png');
    
    optImage9 = RMSHE(imagePath);
    imwrite(optImage9, '../11/RMSHE11.png');
    
    optImage11 = RSIHE(imagePath);
    imwrite(optImage11, '../11/RSIHE11.png');
    
    optImage11 = WTHE(imagePath, 1.2);
    imwrite(optImage11, '../11/WTHE11.png');
end