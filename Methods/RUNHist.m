function RUNHist(imagePath)
    Image = imread("../Set12/12.png");
    imhist(Image);
    saveas(gcf,sprintf('../12/oriHist12.png'));
%     imwrite(imageHist, '../12/oriHist12.png');
    
    optImage1 = AHE([4, 4], imagePath);
    imhist(optImage1);
    saveas(gcf,sprintf('../12/AHEHist12.png'));
    
    optImage2 = BBHE(imagePath);
    imhist(optImage2);
    saveas(gcf,sprintf('../12/BBHEHist12.png'));
    
    optImage3 = BPDHE(imagePath);
    imhist(optImage3);
    saveas(gcf,sprintf('../12/BPDHEHist12.png'));
    
    optImage4 = CLAHE(imagePath, 4, 4, 256, 5);
    imhist(optImage4);
    saveas(gcf,sprintf('../12/CLAHEHist12.png'));
    
    optImage5 = DSIHE(imagePath);
    imhist(optImage5);
    saveas(gcf,sprintf('../12/DSIHEHist12.png'));
    
    optImage6 = ESIHE(imagePath);
    imhist(optImage6);
    saveas(gcf,sprintf('../12/ESIHEHist12.png'));
    
    [optImage7, ~] = MMBEBHE(imagePath);
    imhist(optImage7);
    saveas(gcf,sprintf('../12/MMBEBHEHist12.png'));
    
    optImage8 = POSHE(imagePath, 4, 4);
    imhist(optImage8);
    saveas(gcf,sprintf('../12/POSHEHist12.png'));
    
    optImage9 = RMSHE(imagePath);
    imhist(optImage9);
    saveas(gcf,sprintf('../12/RMSHEHist12.png'));
    
    optImageHist12 = RSIHE(imagePath);
    imhist(optImageHist12);
    saveas(gcf,sprintf('../12/RSIHEHist12.png'));
    
    optImageHist12 = WTHE(imagePath, 1.2);
    imhist(optImageHist12);
    saveas(gcf,sprintf('../12/WTHEHist12.png'));
end