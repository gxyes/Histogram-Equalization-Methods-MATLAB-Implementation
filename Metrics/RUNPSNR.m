function RUNPSNR(imageXPath)
%     [PSNRVal, MSEVal] = PSNR(imageXPath, "../12/AHE12.png");
%     disp("AHE psnr:" + string(PSNRVal));
%     disp("AHE mse:"+  string(MSEVal));  
%     
%     [PSNRVal, MSEVal] = PSNR(imageXPath, "../12/BBHE12.png");
%     disp("BBHE psnr:" + string(PSNRVal));
%     disp("BBHE mse:"+  string(MSEVal));  
%     
%     [PSNRVal, MSEVal] = PSNR(imageXPath, "../12/BPDHE12.png");
%     disp("BPDHE psnr:" + string(PSNRVal));
%     disp("BPDHE mse:"+  string(MSEVal));  
%     
%     [PSNRVal, MSEVal] = PSNR(imageXPath, "../12/CLAHE12.png");
%     disp("CLAHE psnr:" + string(PSNRVal));
%     disp("CLAHE mse:"+  string(MSEVal));  
%     
%     [PSNRVal, MSEVal] = PSNR(imageXPath, "../12/DSIHE12.png");
%     disp("DSIHE psnr:" + string(PSNRVal));
%     disp("DSIHE mse:"+  string(MSEVal));  
%     
%     [PSNRVal, MSEVal] = PSNR(imageXPath, "../12/ESIHE12.png");
%     disp("ESIHE psnr:" + string(PSNRVal));
%     disp("ESIHE mse:"+  string(MSEVal));  
%     
%     [PSNRVal, MSEVal] = PSNR(imageXPath, "../12/MMBEBHE12.png");
%     disp("MMBEBHE psnr:" + string(PSNRVal));
%     disp("MMBEBHE mse:"+  string(MSEVal));  
%     
%     [PSNRVal, MSEVal] = PSNR(imageXPath, "../12/POSHE12.png");
%     disp("POSHE psnr:" + string(PSNRVal));
%     disp("POSHE mse:"+  string(MSEVal));  
%     
%     [PSNRVal, MSEVal] = PSNR(imageXPath, "../12/RMSHE12.png");
%     disp("RMSHE psnr:" + string(PSNRVal));
%     disp("RMSHE mse:"+  string(MSEVal));  
%     
%     [PSNRVal, MSEVal] = PSNR(imageXPath, "../12/RSIHE12.png");
%     disp("RSIHE psnr:" + string(PSNRVal));
%     disp("RSIHE mse:"+  string(MSEVal));  
%     
%     [PSNRVal, MSEVal] = PSNR(imageXPath, "../12/WTHE12.png");
%     disp("WTHE psnr:" + string(PSNRVal));
%     disp("WTHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../OptImages/12/QBHE12.png");
    disp("QBHE psnr:" + string(PSNRVal));
    disp("QBHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../OptImages/12/RSWHE12.png");
    disp("RSWHE psnr:" + string(PSNRVal));
    disp("RSWHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../OptImages/12/BUBOHE12.png");
    disp("BUBOHE psnr:" + string(PSNRVal));
    disp("BUBOHE mse:"+  string(MSEVal));  
    
    [PSNRVal, MSEVal] = PSNR(imageXPath, "../OptImages/12/AMHE12.png");
    disp("AMHE psnr:" + string(PSNRVal));
    disp("AMHE mse:"+  string(MSEVal));  
end