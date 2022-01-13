function RUN(imagePath)
%     Image = imread("../Set10/OptImages/10.png");
%     imwrite(Image, '../OptImages/10/oriOptImages/10.png');
%     
%     optImage1 = AHE([4, 4], imagePath);
%     imwrite(optImage1, '../OptImages/10/AHEOptImages/10.png');
%     
%     optImage2 = BBHE(imagePath);
%     imwrite(optImage2, '../OptImages/10/BBHEOptImages/10.png');
%     
%     optImage3 = BPDHE(imagePath);
%     imwrite(optImage3, '../OptImages/10/BPDHEOptImages/10.png');
%     
%     optImage4 = CLAHE(imagePath, 4, 4, 256, 5);
%     imwrite(optImage4, '../OptImages/10/CLAHEOptImages/10.png');
%     
%     optImage5 = DSIHE(imagePath);
%     imwrite(optImage5, '../OptImages/10/DSIHEOptImages/10.png');
%     
%     optImage6 = ESIHE(imagePath);
%     imwrite(optImage6, '../OptImages/10/ESIHEOptImages/10.png');
%     
%     [optImage7, ~] = MMBEBHE(imagePath);
%     imwrite(optImage7, '../OptImages/10/MMBEBHEOptImages/10.png');
%     
%     optImage8 = POSHE(imagePath, 4, 4);
%     imwrite(optImage8, '../OptImages/10/POSHEOptImages/10.png');
%     
%     optImage9 = RMSHE(imagePath);
%     imwrite(optImage9, '../OptImages/10/RMSHEOptImages/10.png');
%     
%     optImage10 = RSIHE(imagePath);
%     imwrite(optImage10, '../OptImages/10/RSIHEOptImages/10.png');
%     
%     optImage11 = WTHE(imagePath, 1.2);
%     imwrite(optImage11, '../OptImages/10/WTHEOptImages/10.png');
%     
%     optImage13 = QBHE(imagePath, 32);
%     imwrite(optImage13, '../OptImages/10/QBHE10.png');
%     
%     optImage14 = RSWHE(imagePath);
%     imwrite(optImage14, '../OptImages/10/RSWHE10.png');
%     
    optImage15 = BUBOHE(imagePath, 0.001, 0.98);
    imwrite(optImage15, '../OptImages/12/BUBOHE12.png');
%     
%     optImage16 = AMHE(imagePath);
%     imwrite(optImage16, '../OptImages/10/AMHE10.png');
end