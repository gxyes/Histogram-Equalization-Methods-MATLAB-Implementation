function RUNHist(imagePath)
    Image = imread("../Set12/12.png");
    imhist(Image);
    saveas(gcf,sprintf('../OptImages/12/oriHist12.png'));
%     imwrite(imageHist, '../12/oriHist12.png');
    
%     optImage1 = AHE([4, 4], imagePath);
%     imhist(optImage1);
%     saveas(gcf,sprintf('../12/AHEHist12.png'));
%     
%     optImage2 = BBHE(imagePath);
%     imhist(optImage2);
%     saveas(gcf,sprintf('../12/BBHEHist12.png'));
%     
%     optImage3 = BPDHE(imagePath);
%     imhist(optImage3);
%     saveas(gcf,sprintf('../12/BPDHEHist12.png'));
%     
%     optImage4 = CLAHE(imagePath, 4, 4, 256, 5);
%     imhist(optImage4);
%     saveas(gcf,sprintf('../12/CLAHEHist12.png'));
%     
%     optImage5 = DSIHE(imagePath);
%     imhist(optImage5);
%     saveas(gcf,sprintf('../12/DSIHEHist12.png'));
%     
%     optImage6 = ESIHE(imagePath);
%     imhist(optImage6);
%     saveas(gcf,sprintf('../12/ESIHEHist12.png'));
%     
%     [optImage7, ~] = MMBEBHE(imagePath);
%     imhist(optImage7);
%     saveas(gcf,sprintf('../12/MMBEBHEHist12.png'));
%     
%     optImage8 = POSHE(imagePath, 4, 4);
%     imhist(optImage8);
%     saveas(gcf,sprintf('../12/POSHEHist12.png'));
%     
%     optImage9 = RMSHE(imagePath);
%     imhist(optImage9);
%     saveas(gcf,sprintf('../12/RMSHEHist12.png'));
%     
%     optImageHist12 = RSIHE(imagePath);
%     imhist(optImageHist12);
%     saveas(gcf,sprintf('../12/RSIHEHist12.png'));
%     
    optImageHist5 = WTHE(imagePath, 1.2);
    imhist(optImageHist5);
    saveas(gcf,sprintf('../OptImages/12/WTHEHist12.png'));
    
    optImageHist1 = QBHE(imagePath, 32);
    imhist(optImageHist1);
    saveas(gcf,sprintf('../OptImages/12/QBHEHist12.png'));
    
    optImageHist2 = RSWHE(imagePath);
    imhist(optImageHist2);
    saveas(gcf,sprintf('../OptImages/12/RSWHEHist12.png'));
    
    optImageHist3 = BUBOHE(imagePath, 0.001, 0.98);
    imhist(optImageHist3);
    saveas(gcf,sprintf('../OptImages/12/BUBOHEHist12.png'));
    
    optImageHist4 = AMHE(imagePath);
    imhist(optImageHist4);
    saveas(gcf,sprintf('../OptImages/12/AMHEHist12.png'));
end