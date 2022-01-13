function RUNSSIM(imageXPath)
% 	SSIMValue = SSIM(imageXPath, "../01/AHE01.png");
%     disp("AHE SSIM:" + string(SSIMValue));
%     
%     SSIMValue = SSIM(imageXPath, "../01/BBHE01.png");
%     disp("BBHE SSIM:" + string(SSIMValue));
%     
%     SSIMValue = SSIM(imageXPath, "../01/BPDHE01.png");
%     disp("BPDHE SSIM:" + string(SSIMValue));
%     
%     SSIMValue = SSIM(imageXPath, "../01/CLAHE01.png");
%     disp("CLAHE SSIM:" + string(SSIMValue));
%     
%     SSIMValue = SSIM(imageXPath, "../01/DSIHE01.png");
%     disp("DSIHE SSIM:" + string(SSIMValue));
%     
%     SSIMValue = SSIM(imageXPath, "../01/ESIHE01.png");
%     disp("ESIHE SSIM:" + string(SSIMValue));
%     
%     SSIMValue = SSIM(imageXPath, "../01/MMBEBHE01.png");
%     disp("MMBEBHE SSIM:" + string(SSIMValue));
%     
%     SSIMValue = SSIM(imageXPath, "../01/POSHE01.png");
%     disp("POSHE SSIM:" + string(SSIMValue));
%     
%     SSIMValue = SSIM(imageXPath, "../01/RMSHE01.png");
%     disp("RMSHE SSIM:" + string(SSIMValue));
%     
%     SSIMValue = SSIM(imageXPath, "../01/RSIHE01.png");
%     disp("RSIHE SSIM:" + string(SSIMValue));
%     
%     SSIMValue = SSIM(imageXPath, "../01/WTHE01.png");
%     disp("WTHE SSIM:" + string(SSIMValue));

    SSIMValue = SSIM(imageXPath, "../OptImages/01/QBHE01.png");
    disp("QBHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../OptImages/01/RSWHE01.png");
    disp("RSWHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../OptImages/01/BUBOHE01.png");
    disp("BUBOHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../OptImages/01/AMHE01.png");
    disp("AMHE SSIM:" + string(SSIMValue));
end