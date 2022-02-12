%110207011 SERCAN SATICI
clear all;close all;clc;
%% Hexagonal Pattern Search(HS)
sequenceName='foreman';%dizin ismi
numberOfImages=300;%cerceve sayisi[foreman=300,fb=125,tennis=150,BigBuckBunny=300]
imageName=sprintf(['C:\\MATLAB\\HexagonWork\\test\\frames\\' , sequenceName , '%3.3d.bmp'],1);%goruntu ismi
%%t. frame
I1=imread(imageName);%t. goruntu okundu
imgI=I1;%gecici degiskende saklandi
blockSize=16;
p=(blockSize/2)-1;%-x ve -y ekseni -7...0....7 
[row col] = size(imgI);%yukseklik ve genislik bilgisi alindi
vectors = zeros(2,(row*col)/(blockSize^2));%her blogun hareket vektorunu tutmak icin degisken yaratildi
costs = ones(1, 7) * 255;%7 farklý nokta icin,MAD ile elde edilen cost'lar saklanacak
%Buyuk Hexagon deseni indeksleri
LHSP(1,:) = [-1 -2];
LHSP(2,:) = [1  -2];
LHSP(3,:) = [-2  0];
LHSP(4,:) = [0   0];%Large Hexagon Search Pattern 'center'
LHSP(5,:) = [2   0];
LHSP(6,:) = [-1  2];
LHSP(7,:) = [1   2];
%Kücük Hexagon deseni indeksleri
SHSP(1,:) = [0  -1];
SHSP(2,:) = [-1  0];
SHSP(3,:) = [0   0];%Small Hexagon Search Pattern 'center'
SHSP(4,:) = [1   0];
SHSP(5,:) = [0   1];

for imageNumber=1:1
    imageName=sprintf(['C:\\MATLAB\\HexagonWork\\test\\frames\\' , sequenceName , '%3.3d.bmp'],imageNumber+1);%goruntu ismi
    I2 = imread(imageName);%bir sonraki cerceve okundu
    imgP=I2;%gecici degiskende saklandi
    I2Predicted=zeros(row,col);%kestirim matrisi olusturuldu
%     computations = 0;
    blockCount = 1;
    for i = 1 : blockSize : row-blockSize+1
        for j = 1 : blockSize : col-blockSize+1
        x = j;
        y = i;
        costs(4)=costFuncMAD(imgP(i:i+blockSize-1,j:j+blockSize-1), imgI(i:i+blockSize-1,j:j+blockSize-1),blockSize);%Merkez cost hesaplandi
%         computations = computations + 1;

            for k = 1:7
                refBlkVer = y + LHSP(k,2); % row/Vert co-ordinate for ref block
                refBlkHor = x + LHSP(k,1); % col/Horizontal co-ordinate
                if ( refBlkVer < 1 || refBlkVer+blockSize-1 > row || refBlkHor < 1 || refBlkHor+blockSize-1 > col)
                    continue;
                end
                if (k == 4)
                    continue
                end
                costs(k) = costFuncMAD(imgP(i:i+blockSize-1,j:j+blockSize-1),imgI(refBlkVer:refBlkVer+blockSize-1, refBlkHor:refBlkHor+blockSize-1), blockSize);
%                 computations = computations + 1;
            end
            [cost, point] = min(costs);

            if (point == 4)
                SHSPFlag = 1;%flag 1 ise, minumum merkezdedir
            else
                SHSPFlag = 0;
            if ( LHSP(point,1) * LHSP(point,2) ~=  0 )%kose olmayan noktalar(1/2/6/7)
                cornerFlag = 0;
            else
                cornerFlag = 1; %kose noktalarý(3/5)
            end
            xLast = x;
            yLast = y;
            x = x + LHSP(point, 1);
            y = y + LHSP(point, 2);
            costs = ones(1,7) * 255;
            costs(4) = cost;
            end
            while (SHSPFlag == 0)
                if (cornerFlag == 1)%eger 3/5 noktalarinda ise
                    for k = 1:7
                        refBlkVer = y + LHSP(k,2); % row/Vert co-ordinate for ref block
                        refBlkHor = x + LHSP(k,1); % col/Horizontal co-ordinate
                        if ( refBlkVer < 1 || refBlkVer+blockSize-1 > row || refBlkHor < 1 || refBlkHor+blockSize-1 > col)
                            continue;
                        end
                        if (k == 4)
                            continue
                        end
                        if ( refBlkHor >= xLast - 1 && refBlkHor <= xLast + 1 && refBlkVer >= yLast - 1 && refBlkVer <= yLast + 1 )
                            continue;
                        elseif (refBlkHor < j-p || refBlkHor > j+p || refBlkVer < i-p || refBlkVer > i+p)
                            continue;
                        else
                        costs(k) = costFuncMAD(imgP(i:i+blockSize-1,j:j+blockSize-1),imgI(refBlkVer:refBlkVer+blockSize-1,refBlkHor:refBlkHor+blockSize-1), blockSize);
%                         computations = computations + 1;
                        end
                    end

                else
                    switch point
                        case 1
                        refBlkVer = y + LHSP(1,2); % row/Vert co-ordinate for ref block
                        refBlkHor = x + LHSP(1,1); % col/Horizontal co-ordinate
                        if ( refBlkVer < 1 || refBlkVer+blockSize-1 > row || refBlkHor < 1 || refBlkHor+blockSize-1 > col)
                            % do nothing, outside image boundary
                        elseif (refBlkHor < j-p || refBlkHor > j+p || refBlkVer < i-p || refBlkVer > i+p)
                            % do nothing, outside search window
                        else
                        costs(1) = costFuncMAD(imgP(i:i+blockSize-1,j:j+blockSize-1), imgI(refBlkVer:refBlkVer+blockSize-1,refBlkHor:refBlkHor+blockSize-1), blockSize);
%                         computations = computations + 1;
                        end
                        refBlkVer = y + LHSP(3,2); % row/Vert co-ordinate for ref block
                        refBlkHor = x + LHSP(3,1); % col/Horizontal co-ordinate
                        if ( refBlkVer < 1 || refBlkVer+blockSize-1 > row || refBlkHor < 1 || refBlkHor+blockSize-1 > col)
                            % do nothing, outside image boundary
                        elseif (refBlkHor < j-p || refBlkHor > j+p || refBlkVer < i-p || refBlkVer > i+p)
                            % do nothing, outside search window
                        else
                        costs(3) = costFuncMAD(imgP(i:i+blockSize-1,j:j+blockSize-1),imgI(refBlkVer:refBlkVer+blockSize-1,refBlkHor:refBlkHor+blockSize-1), blockSize);
%                         computations = computations + 1;
                        end
                        case 2
                        refBlkVer = y + LHSP(2,2); % row/Vert co-ordinate for ref block
                        refBlkHor = x + LHSP(2,1); % col/Horizontal co-ordinate
                        if ( refBlkVer < 1 || refBlkVer+blockSize-1 > row || refBlkHor < 1 || refBlkHor+blockSize-1 > col)
                            % do nothing, outside image boundary
                        elseif (refBlkHor < j-p || refBlkHor > j+p || refBlkVer < i-p || refBlkVer > i+p)
                            % do nothing, outside search window
                        else
                        costs(2) = costFuncMAD(imgP(i:i+blockSize-1,j:j+blockSize-1),imgI(refBlkVer:refBlkVer+blockSize-1,refBlkHor:refBlkHor+blockSize-1), blockSize);
%                         computations = computations + 1;
                        end
                        refBlkVer = y + LHSP(5,2); % row/Vert co-ordinate for ref block
                        refBlkHor = x + LHSP(5,1); % col/Horizontal co-ordinate
                        if ( refBlkVer < 1 || refBlkVer+blockSize-1 > row || refBlkHor < 1 || refBlkHor+blockSize-1 > col)
                            % do nothing, outside image boundary
                        elseif (refBlkHor < j-p || refBlkHor > j+p || refBlkVer < i-p || refBlkVer > i+p)
                            % do nothing, outside search window
                        else
                        costs(5) = costFuncMAD(imgP(i:i+blockSize-1,j:j+blockSize-1),imgI(refBlkVer:refBlkVer+blockSize-1,refBlkHor:refBlkHor+blockSize-1), blockSize);
%                         computations = computations + 1;
                        end
                        case 6
                        refBlkVer = y + LHSP(3,2); % row/Vert co-ordinate for ref block
                        refBlkHor = x + LHSP(3,1); % col/Horizontal co-ordinate
                        if ( refBlkVer < 2 || refBlkVer+blockSize-1 > row || refBlkHor < 1 || refBlkHor+blockSize-1 > col)
                            % do nothing, outside image boundary
                        elseif (refBlkHor < j-p || refBlkHor > j+p || refBlkVer < i-p || refBlkVer > i+p)
                            % do nothing, outside search window
                        else
                        costs(3) = costFuncMAD(imgP(i:i+blockSize-1,j:j+blockSize-1),imgI(refBlkVer:refBlkVer+blockSize-1,refBlkHor:refBlkHor+blockSize-1), blockSize);
%                         computations = computations + 1;
                        end
                        refBlkVer = y + LHSP(6,2); % row/Vert co-ordinate for ref block
                        refBlkHor = x + LHSP(6,1); % col/Horizontal co-ordinate
                        if ( refBlkVer < 1 || refBlkVer+blockSize-1 > row || refBlkHor < 1 || refBlkHor+blockSize-1 > col)
                            % do nothing, outside image boundary
                        elseif (refBlkHor < j-p || refBlkHor > j+p || refBlkVer < i-p || refBlkVer > i+p)
                            % do nothing, outside search window
                        else
                        costs(6) = costFuncMAD(imgP(i:i+blockSize-1,j:j+blockSize-1),imgI(refBlkVer:refBlkVer+blockSize-1,refBlkHor:refBlkHor+blockSize-1), blockSize);
%                         computations = computations + 1;
                        end
                        case 7
                        refBlkVer = y + LHSP(5,2); % row/Vert co-ordinate for ref block
                        refBlkHor = x + LHSP(5,1); % col/Horizontal co-ordinate
                        if ( refBlkVer < 2 || refBlkVer+blockSize-1 > row || refBlkHor < 1 || refBlkHor+blockSize-1 > col)
                            % do nothing, outside image boundary
                        elseif (refBlkHor < j-p || refBlkHor > j+p || refBlkVer < i-p || refBlkVer > i+p)
                            % do nothing, outside search window
                        else
                        costs(5) = costFuncMAD(imgP(i:i+blockSize-1,j:j+blockSize-1),imgI(refBlkVer:refBlkVer+blockSize-1,refBlkHor:refBlkHor+blockSize-1), blockSize);
%                         computations = computations + 1;
                        end
                        refBlkVer = y + LHSP(7,2); % row/Vert co-ordinate for ref block
                        refBlkHor = x + LHSP(7,1); % col/Horizontal co-ordinate
                        if ( refBlkVer < 1 || refBlkVer+blockSize-1 > row || refBlkHor < 1 || refBlkHor+blockSize-1 > col)
                            % do nothing, outside image boundary
                        elseif (refBlkHor < j-p || refBlkHor > j+p || refBlkVer < i-p || refBlkVer > i+p)
                            % do nothing, outside search window
                        else
                        costs(7) = costFuncMAD(imgP(i:i+blockSize-1,j:j+blockSize-1),imgI(refBlkVer:refBlkVer+blockSize-1,refBlkHor:refBlkHor+blockSize-1), blockSize);
%                         computations = computations + 1;
                        end
                      otherwise
                    end%switch/case yapisi sonu
                end
                [cost, point] = min(costs);
                if (point == 4)%eger min. nokta merkezde ise Small Hexagon desenine gec
                    SHSPFlag = 1;
                else
                    SHSPFlag = 0;
                if ( abs(LHSP(point,1)) * abs(LHSP(point,2))== 0 )
                    cornerFlag = 0;
                else
                    cornerFlag = 1;
                end
                xLast = x;
                yLast = y;
                x = x + LHSP(point, 1);
                y = y + LHSP(point, 2);
                costs = ones(1,7) * 255;
                costs(4) = cost;
                end
        end % while loop ends here

        %SHSP
        costs = ones(1,5) * 255;
        costs(3) = cost;
        for k = 1:5
            refBlkVer = y + SHSP(k,2); % row/Vert co-ordinate for ref block
            refBlkHor = x + SHSP(k,1); % col/Horizontal co-ordinate
            if ( refBlkVer < 1 || refBlkVer+blockSize-1 > row || refBlkHor < 1 || refBlkHor+blockSize-1 > col)
                continue; % do nothing, outside image boundary
            elseif (refBlkHor < j-p || refBlkHor > j+p || refBlkVer < i-p || refBlkVer > i+p)
                continue; % do nothing, outside search window
            end
            if (k == 3)
                continue
            end
            costs(k) = costFuncMAD(imgP(i:i+blockSize-1,j:j+blockSize-1),imgI(refBlkVer:refBlkVer+blockSize-1,refBlkHor:refBlkHor+blockSize-1), blockSize);
%             computations = computations + 1;
        end
        [cost, point] = min(costs);
        x = x + SHSP(point, 1);
        y = y + SHSP(point, 2);
        vectors(1,blockCount) = y-i; %  row co-ordinate for the vector
        vectors(2,blockCount) = x-j; %  col co-ordinate for the vector
        blockCount = blockCount + 1;       
        
        %% Motion Compansated
        indis=1;
        dy = vectors(1,indis);
        dx = vectors(2,indis);
        refBlkVer = i + dy;
        refBlkHor = j + dx;
        indis = indis + 1;        
        costs = ones(1,7) * 255;        
        I2Comp(i:i+blockSize-1,j:j+blockSize-1) = imgI(refBlkVer:refBlkVer+blockSize-1,refBlkHor:refBlkHor+blockSize-1);
        imageName = sprintf(['C:\\MATLAB\\HexagonWork\\test\\cikis\\output\\I1' , sequenceName , '%3.3d.bmp'],imageNumber);
        imwrite(imgI,imageName);
        imgI=imgP;%referans çerçeve güncellemesi
        imageName = sprintf(['C:\\MATLAB\\HexagonWork\\test\\cikis2\\output2\\I2Comp' , sequenceName , '%3.3d.bmp'],imageNumber+1);
        imwrite(uint8((I2Comp)),imageName); 
        
%         %Reconstruct Islemi
            indis=1;
%             for ii = 0:blockSize-1
%                 for jj = 0:blockSize-1
%                     I2Predicted( i + ii , j + jj ) = imgI( i + ii + vectors(1,indis) , j + jj + vectors(2,indis) );
                    I2Predicted( i:i+blockSize-1,j:j+blockSize-1)=imgI( i+vectors(1,indis):i+vectors(1,indis)+blockSize-1 , j+vectors(2,indis):j+vectors(2,indis)+blockSize-1  );
                    indis=indis+1;
                    if(indis==((row*col)/(blockSize^2)))
                        indis=1;
                    end
%                 end
%             end
        imgI=I2;%referans çerçeve güncellemesi
        imageName = sprintf(['C:\\MATLAB\\HexagonWork\\test\\cikis2\\output2\\I2Comp' , sequenceName , '%3.3d.bmp'],imageNumber+1);
        imwrite(uint8((I2Predicted)),imageName); 

        MSE(imageNumber)= sum(sum((double(I2)-double(I2Predicted)).^2))/(row*col);
        psnr(imageNumber)=20*log10(255/sqrt(MSE(imageNumber)));
    end
  end
end
motionVect = vectors;
% HScomputations = computations/(blockCount - 1);
result=sum(psnr)/(imageNumber);
