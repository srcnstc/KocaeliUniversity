%110207011 SERCAN SATICI
clear all;close all;clc;
tic
%% T-GCBPM
blockSize=16;%blok boyutu
searchRange=16;%arama araligi
numberOfBits=8;%bit sayisi(K=8) 
sequenceName='foreman';%dizin ismi
numberOfImages=300;%cerceve sayisi[foreman=300,fb=125,tennis=150,BigBuckBunny=300]
imageName=sprintf(['C:\\MATLAB\\work\\test\\frames\\' , sequenceName , '%3.3d.bmp'],1);%goruntu ismi
%%t. frame
I1=imread(imageName);%t. goruntu okundu
[h,w]=size(I1);%yukseklik,genislik alindi
I1B=I1;%1B t. frame
ak=zeros(1,numberOfBits);%ikili kod
gk=zeros(1,numberOfBits);%gray kod
zerovector=zeros(1,numberOfBits);%0 vektoru
NTB=7;%kesilen bit sayisi
M=numberOfBits-NTB;%uyumlama yapilacak en deðerlikli bit duzlem sayisi
numberOfHorizontalBlocks=h/blockSize;%yatay blok sayisi hesaplandi
numberOfVerticalBlocks=w/blockSize;%dikey blok sayisi hesaplandi
indis=numberOfBits;
vectors = zeros(2,(h*w)/(blockSize^2));
blockCount=1;
for i=1:h
    for j=1:w
        while(I1B(i,j)>=1)
          ak(1,indis)=mod(I1B(i,j),2);
          I1B(i,j)=I1B(i,j)-mod(I1B(i,j),2); 
          I1B(i,j)=I1B(i,j)/2;
          indis=indis-1;
        end
        indis=numberOfBits;
        %sayý binary hale getirildi
        gk(1,indis-(numberOfBits-1))=ak(1,indis-(numberOfBits-1));
        for ii=indis-(numberOfBits-2):1:numberOfBits
            gk(1,ii)=xor(ak(1,ii-1),ak(1,ii));
        end
        %binary kod gray kod haline getirildi 
        I1B(i,j)=gk(1,M);
        ak=zerovector;%ikili kod bir  sonraki piksel icin sifirlandi
        gk=zerovector;%gray kod bir  sonraki piksel icin sifirlandi
    end
end
% imwrite(I1B,'C:\\MATLAB\\work\\cikis\\1B_TGCBPM\\1Boyutlu.bmp');%dosya yazildi

%%(t+1).frame
for imageNumber=1:1
    imageName=sprintf(['C:\\MATLAB\\work\\test\\frames\\' , sequenceName , '%3.3d.bmp'],imageNumber+1);%goruntu ismi
    I2 = imread(imageName);%bir sonraki cerceve okundu
    I2B=I2;%1B (t+1).frame
    for i=1:h
        for j=1:w
             while(I2B(i,j)>=1)
                ak(1,indis)=mod(I2B(i,j),2);
                I2B(i,j)=I2B(i,j)-mod(I2B(i,j),2); 
                I2B(i,j)=I2B(i,j)/2;
                indis=indis-1;
             end
            indis=numberOfBits;
            %sayý binary hale getirildi
            gk(1,indis-(numberOfBits-1))=ak(1,indis-(numberOfBits-1));
             for ii=indis-(numberOfBits-2):1:numberOfBits
                  gk(1,ii)=xor(ak(1,ii-1),ak(1,ii));
             end
             %binary kod gray kod haline getirildi 
             I2B(i,j)=gk(1,M);
             ak=zerovector;%ikili kod bir  sonraki piksel icin sifirlandi
             gk=zerovector;%gray kod bir  sonraki piksel icin sifirlandi
        end
    end
    indis=numberOfBits;    
    I2Predicted=zeros(h,w);%kestirim matrisi olusturuldu
%% Hareket Vektorlerinin Tespiti
  for i = 1 : blockSize : h %16x16 blok boyutu
        for j = 1 : blockSize : w
            mvx=0;%hareket vektörü -x- bileseni
            mvy=0;%hareket vektörü -y- bileseni
            % arama penceresine eriþim
            minCMtg=blockSize*blockSize*((2^numberOfBits)-1) ;%max (number of non-matching pixels)NNMP degeri
            for ii = i - searchRange : i + searchRange - 1%pencere içinde tutmak için blockSize cikarildi
                for jj = j - searchRange : j + searchRange - 1  
                    if ii > 0 && ii <= h - blockSize + 1 && jj > 0 && jj <= w - blockSize + 1%sinir kontrolleri
                        % blok içindeki piksellere eriþim
                        CMtg = 0 ;
                        for iii = 0 : blockSize-1
                            for jjj = 0 : blockSize-1
                                    CMtg = CMtg + (xor( I1B( ii + iii , jj + jjj  ) , I2B( i + iii , j + jjj  )));
                            end
                        end
                        CMtg=CMtg*(2^NTB);%olcekleme yapildi
                        if CMtg < minCMtg
                            minCMtg = CMtg ;
                            mvy = ii - i ;
                            mvx = jj - j ;
                            
                            elseif CMtg == minCMtg % farklý noktalarda eþit CMtg varsa daha yakýn olan seçilecek
                                if mvy * mvy + mvx * mvx > ( ii - i ) * ( ii - i ) + ( jj - j ) * ( jj - j )
                                     mvy = ii - i ;
                                     mvx = jj - j ;
                                end
                            
                        end
                    end
                end
            end
        vectors(1,blockCount) = mvy; % blogun dikey hareket
        vectors(2,blockCount) = mvx; % blogun yatay hareket
        blockCount = blockCount + 1;
            % reconstruct iþlemleri
            for ii = 0:blockSize-1
                for jj = 0:blockSize-1
                    I2Predicted( i + ii , j + jj ) = I1( i + ii + mvy , j + jj + mvx );
                end
            end
            
        end
    end %blok indislerini belirleyen döngülerin sonu
    
    imageName = sprintf(['C:\\MATLAB\\work\\test\\cikis\\output2\\TGCBPM' , sequenceName , '%3.3d.bmp'],imageNumber);
    imwrite(I1B,imageName);
    I1=I2;%referans çerçeve güncellemesi
    I1B=I2B; 
    
    imageName = sprintf(['C:\\MATLAB\\work\\cikis2\\1B' , sequenceName , '%3.3d.bmp'],imageNumber+1);
    imwrite(uint8((I2Predicted)),imageName);     
    imageName = sprintf(['C:\\MATLAB\\work\\cikis2\\1BD' , sequenceName , '%3.3d.bmp'],imageNumber+1);
    imwrite(uint8((I2Predicted)),imageName);
    
    MSE(imageNumber)= sum(sum((double(I2)-double(I2Predicted)).^2))/(h*w);
    psnr(imageNumber)=20*log10(255/sqrt(MSE(imageNumber)));
%     disp('Hareketin kestirildigi ardýsýk t.frame=');
%     disp(imageNumber);
end
result=sum(psnr)/(imageNumber)  
toc
    
     

   
