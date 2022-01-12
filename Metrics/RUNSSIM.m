function RUNSSIM(imageXPath)
	SSIMValue = SSIM(imageXPath, "../11/AHE11.png");
    disp("AHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../11/BBHE11.png");
    disp("BBHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../11/BPDHE11.png");
    disp("BPDHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../11/CLAHE11.png");
    disp("CLAHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../11/DSIHE11.png");
    disp("DSIHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../11/ESIHE11.png");
    disp("ESIHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../11/MMBEBHE11.png");
    disp("MMBEBHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../11/POSHE11.png");
    disp("POSHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../11/RMSHE11.png");
    disp("RMSHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../11/RSIHE11.png");
    disp("RSIHE SSIM:" + string(SSIMValue));
    
    SSIMValue = SSIM(imageXPath, "../11/WTHE11.png");
    disp("WTHE SSIM:" + string(SSIMValue));
end