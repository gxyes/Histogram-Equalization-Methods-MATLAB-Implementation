function RUNPSNR(imageXPath)
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../07/AHE07.png");
    disp("AHE psnr:" + string(PSNRVal));
    disp("AHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../07/BBHE07.png");
    disp("BBHE psnr:" + string(PSNRVal));
    disp("BBHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../07/BPDHE07.png");
    disp("BPDHE psnr:" + string(PSNRVal));
    disp("BPDHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../07/CLAHE07.png");
    disp("CLAHE psnr:" + string(PSNRVal));
    disp("CLAHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../07/DSIHE07.png");
    disp("DSIHE psnr:" + string(PSNRVal));
    disp("DSIHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../07/ESIHE07.png");
    disp("ESIHE psnr:" + string(PSNRVal));
    disp("ESIHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../07/MMBEBHE07.png");
    disp("MMBEBHE psnr:" + string(PSNRVal));
    disp("MMBEBHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../07/POSHE07.png");
    disp("POSHE psnr:" + string(PSNRVal));
    disp("POSHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../07/RMSHE07.png");
    disp("RMSHE psnr:" + string(PSNRVal));
    disp("RMSHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../07/RSIHE07.png");
    disp("RSIHE psnr:" + string(PSNRVal));
    disp("RSIHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../07/WTHE07.png");
    disp("WTHE psnr:" + string(PSNRVal));
    disp("WTHE mse:"+  string(MSEVal));  
end