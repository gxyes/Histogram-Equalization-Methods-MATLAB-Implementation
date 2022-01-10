function optImage=BERF(Image,optImage,stepRow, stepColumn, stepLevels, maxDis)
    [rows,columns]=size(optImage);

    % Tail row
    for i=1:stepRow:rows
        for j=1:columns
            if (i>1 && i<rows ) % Edge detection (except for the first & last row)
               % Blocking Artifact detection
               
               % grayValue difference between edge pixels and adjacent pixels for Image
               oriD=abs(Image(i,j)-Image(i+1,j)) + abs(Image(i,j)-Image(i-1,j)); 
               % grayValue difference between edge pixels and adjacent pixels for optImage
               optD=abs(optImage(i,j)-optImage(i+1,j)) + abs(optImage(i,j)-optImage(i-1,j)); 

               % Blocking Artifact exist
               if (abs(optD - oriD) > stepLevels)
                   % BERF
                   b = 0;
                   aveBound = uint8((uint16(optImage(i - 1, j)) + uint16(optImage(i + 1, j))) / 2 ); 
                   optImage(i,j)=aveBound;
                   % Increasing rule
                   if (optImage(i-1,j)> optImage(i+1,j)) 
                       if (i - 2 - b >= 1)  % next pixel ...
                           pixelPresentAdd = optImage(i - 1 - b, j);
                           pixelNextAdd = optImage(i - 2 - b, j);
                           pixelPresentAdd = aveBound + stepLevels;
                           while(i - 2 - b >= 1 && pixelNextAdd - pixelPresentAdd >= stepLevels && pixelNextAdd - pixelPresentAdd <= maxDis)
                               pixelNextAdd = pixelPresentAdd + stepLevels;
                               optImage(i - 1 - b, j)=pixelPresentAdd;
                               optImage(i - 2 - b, j)=pixelNextAdd;
                               b =b+1;
                               if(i - 2 - b >= 1)
                                   pixelPresentAdd = optImage(i - 1 - b, j);
                                   pixelNextAdd = optImage(i - 2 - b, j);
                               end
                           end
                       end

                       % Decreasing rule
                       b=0;
                       if (i + 2 + b <=rows)
                           pixelPresentDec = optImage(i + 1 + b, j);
                           pixelNextDec = optImage(i + 2 + b, j);
                           pixelPresentDec = aveBound - stepLevels;
                           while (i + 2 + b <=rows && pixelPresentDec - pixelNextDec >= stepLevels && pixelPresentDec - pixelNextDec <= maxDis)
                               pixelNextDec = pixelPresentDec - stepLevels;
                               optImage(i + 1 + b, j)=pixelPresentDec;
                               optImage(i + 2 + b, j)=pixelNextDec;
                               b = b+1;
                               if (i + 2 + b <=rows) 
                                   pixelPresentDec = optImage(i + 1 + b, j);
                                   pixelNextDec = optImage(i + 2 + b, j);
                               end
                           end
                       end
                   end

                   % Increasing rule
                   b=0;
                    if (optImage(i - 1, j) < optImage(i + 1, j)) 
                         if (i + 2 + b <= rows) 
                             pixelPresentAdd = optImage(i + 1 + b, j);
                             pixelNextAdd = optImage(i + 2 + b, j);
                             pixelPresentAdd = aveBound + stepLevels;
                             while (i + 2 + b  <= rows && pixelNextAdd - pixelPresentAdd >= stepLevels && pixelNextAdd - pixelPresentAdd <= maxDis)
                                 pixelNextAdd = pixelPresentAdd + stepLevels;
                                 optImage(i + 1 + b, j)=pixelPresentAdd;
                                 optImage(i + 2 + b, j)=pixelNextAdd;
                                 b =b + 1;
                                 if (i + 2 + b  <= rows) 
                                     pixelPresentAdd = optImage(i + 1 + b, j);
                                     pixelNextAdd = optImage(i + 2 + b, j);
                                 end
                             end
                         end

                         % Decreasing rule
                         b=0;
                         if (i - 2 - b >= 1)
                             pixelPresentDec = optImage(i - 1 - b, j);
                             pixelNextDec = optImage(i - 2 - b, j);
                             pixelPresentDec = aveBound - stepLevels;
                             while (i - 2 - b >= 1 && pixelPresentDec - pixelNextDec >= stepLevels && pixelPresentDec - pixelNextDec <= maxDis)
                                 pixelNextDec = pixelPresentDec - stepLevels;
                                 optImage(i - 1 - b, j)=pixelPresentDec;
                                 optImage(i - 2 - b, j)=pixelNextDec;
                                 b =b + 1;
                                 if (i - 2 - b >= 1)
                                     pixelPresentDec = optImage(i - 1 - b, j);
                                     pixelNextDec = optImage(i - 2 - b, j);
                                 end
                             end
                         end
                    end

               end
            end
        end
    end


    % Tail column
    for j=1:stepColumn:columns
        for i=1:rows
            if (j>1 && j<columns ) 
               oriD=abs(Image(i,j)-Image(i,j+1)) + abs(Image(i,j)-Image(i,j-1));
               optD=abs(optImage(i,j)-optImage(i,j+1)) + abs(optImage(i,j)-optImage(i,j-1));  
               if (abs(optD - oriD) > stepLevels)
                   % BERF
                   b = 0;
                   aveBound=uint8( (uint16(optImage(i, j-1)) + uint16(optImage(i, j+1))) / 2 ); 
                   optImage(i,j)=aveBound;

                   % Increasing rule
                   if (optImage(i,j-1)> optImage(i,j+1)) 
                       if (j - 2 - b >= 1) 
                           pixelPresentAdd = optImage(i,j - 1 - b);
                           pixelNextAdd = optImage(i,j - 2 - b);
                           pixelPresentAdd = aveBound + stepLevels;
                           while(j - 2 - b >= 1 && pixelNextAdd - pixelPresentAdd >= stepLevels && pixelNextAdd - pixelPresentAdd <= maxDis)
                               pixelNextAdd = pixelPresentAdd + stepLevels;
                               optImage(i,j - 1 - b)=pixelPresentAdd;
                               optImage(i,j - 2 - b)=pixelNextAdd;
                               b =b+1;
                               if(j - 2 - b >= 1) 
                                   pixelPresentAdd = optImage(i,j - 1 - b);
                                   pixelNextAdd = optImage(i,j - 2 - b);
                               end
                           end
                       end

                       % Decreasing rule
                       b=0;
                       if (j + 2 + b <columns)
                           pixelPresentDec = optImage(i,j + 1 + b);
                           pixelNextDec = optImage(i,j + 2 + b);
                           pixelPresentDec = aveBound - stepLevels;
                           while (i + 2 + b < columns && pixelPresentDec - pixelNextDec >= stepLevels && pixelPresentDec - pixelNextDec <= maxDis)
                               pixelNextDec = pixelPresentDec - stepLevels;
                               optImage(i,j + 1 + b)=pixelPresentDec;
                               optImage(i,j + 2 + b)=pixelNextDec;
                               b = b+1;
                               if (j + 2 + b <= columns)
                                   pixelPresentDec = optImage(i, j + 1 + b);
                                   pixelNextDec = optImage(i, j + 2 + b);
                               end
                           end
                       end
                   end

                   % Increasing rule
                   b=0;
                    if(optImage(i , j-1) < optImage(i , j+1))  
                         if (j + 2 + b < columns) 
                             pixelPresentAdd = optImage(i, j + 1 + b);
                             pixelNextAdd = optImage(i, j + 2 + b);
                             pixelPresentAdd = aveBound + stepLevels;
                             while (j + 2 + b < columns && pixelNextAdd - pixelPresentAdd >= stepLevels && pixelNextAdd - pixelPresentAdd <= maxDis)
                                 pixelNextAdd = pixelPresentAdd + stepLevels;
                                 optImage(i,j + 1 + b)=pixelPresentAdd;
                                 optImage(i,j + 2 + b)=pixelNextAdd;
                                 b =b + 1;
                                 if (j + 2 + b  < columns) 
                                     pixelPresentAdd = optImage(i, j + 1 + b);
                                     pixelNextAdd = optImage(i, j + 2 + b);
                                 end
                             end
                         end

                         % Decreasing rule
                         b=0;
                         if (j - 2 - b >= 1)
                             pixelPresentDec = optImage(i, j - 1 - b);
                             pixelNextDec = optImage(i, j - 2 - b);
                             pixelPresentDec = aveBound - stepLevels;
                             while (j - 2 - b >= 1 && pixelPresentDec - pixelNextDec >= stepLevels && pixelPresentDec - pixelNextDec <= maxDis)
                                 pixelNextDec = pixelPresentDec - stepLevels;
                                 optImage(i,j - 1 - b)=pixelPresentDec;
                                 optImage(i,j - 2 - b)=pixelNextDec;
                                 b =b + 1;
                                 if (j - 2 - b >= 1) 
                                     pixelPresentDec = optImage(i, j - 1 - b);
                                     pixelNextDec = optImage(i, j - 2 - b);
                                 end
                             end
                         end
                    end
               end
            end
        end
    end
end