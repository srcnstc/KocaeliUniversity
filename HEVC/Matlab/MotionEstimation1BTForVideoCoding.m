%110207011 SERCAN SATICI
clear all;close all;clc;

%% YUV formatini uint8 yapma
% Nx=352;%dikey boyut
% Ny=288;%yatay boyut
% Nt=300;%frame sayisi
% A = zeros(Ny,Nx);%0 matrisi yaratildi
% fid=fopen('c:\MATLAB\work\foreman_cif.yuv','r','b');%dosya acildi
% for t=1:Nt,
%    A(:,:)=transpose(fread(fid,[Nx,Ny],'uint8'));%Y(luminance)
%    tmp=fread(fid,[Nx/2,Ny/2],'uint8');%U(chrominance)	
%    tmp=fread(fid,[Nx/2,Ny/2],'uint8');%V(chrominance)
%    video = A / max(A(:));
% %    imshow(video);
%    imwrite(video,sprintf('C:\\MATLAB\\work\\test\\frames\\foreman%03d.jpg',t),'jpg','Quality',100);%her frame tek tek belirtilen yola yazildi
% end

%% 1BT
blockSize=16;%blok boyutu
searchRange=16;%arama araligi
numberOfBits=8;%bit sayisi(K=8) 
sequenceName='foreman';%dizin ismi
numberOfImages=300;%cerceve sayisi[foreman=300,fb=125,tennis=150,BigBuckBunny=300]
kernel1D=[1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1];%1Boyutlu çekirdek(1x17)
unity=sum(kernel1D);%normalizasyon faktoru olarak kullanilmak icin cekirdek elemanlari toplami alindi(5) 
kernel=conv2(kernel1D,kernel1D')*1/unity^2;%1/25 ile olcekleme yapildi
kernel=kernel/(sum(sum(kernel)));%17x17 kernel
imageName=sprintf(['C:\\MATLAB\\work\\test\\frames\\' , sequenceName , '%3.3d.bmp'],1);%goruntu ismi
I1=imread(imageName);%t. goruntu okundu
I1=double(I1);%imge double tipine getirildi
[h,w]=size(I1);%yukseklik,genislik alindi
numberOfHorizontalBlocks=h/blockSize;%yatay blok sayisi hesaplandi
numberOfVerticalBlocks=w/blockSize;%dikey blok sayisi hesaplandi
I1F=imfilter(I1,kernel,'same');%kernel ile filtreleme yapildi ve karsilastirma matrisi elde edildi
I1B = zeros(h,w);%t.frame icin B(i,j) esikleme matrisi yaratildi
I1B=I1>=I1F;%I1 ile I1F karsilastirmasiyla B(i,j) matrisi olusturuldu(esikleme)
imwrite(I1B,'C:\\MATLAB\\work\\cikis\\B(i,j)esiklenmis.bmp');%dosya yazildi
for imageNumber=1:299
    imageName=sprintf(['C:\\MATLAB\\work\\test\\frames\\' , sequenceName , '%3.3d.bmp'],imageNumber+1);%goruntu ismi
    I2 = imread(imageName);%bir sonraki cerceve okundu
    I2=double(I2);%double tipine donusturuldu
    I2F=imfilter(I2,kernel,'same');%filtreleme islemi yapildi ve karsilastirma matrisi elde edildi
    I2B=zeros(h,w);%(t+1). frame icin B(i,j) esikleme matrisi yaratildi
    I2B=I2>=I2F;%%I2 ile I2F karsilastirmasiyla B(i,j) matrisi olusturuldu(esikleme)  
    I2Predicted=zeros(h,w);%kestirim matrisi olusturuldu
    for i = 1 : blockSize : h %16x16 blok boyutu
        for j = 1 : blockSize : w
            mvx=0;%hareket vektörü -x- bileseni
            mvy=0;%hareket vektörü -y- bileseni
            % arama penceresine eriþim
            minNnmp=blockSize*blockSize ;%max (number of non-matching pixels)NNMP degeri
            for ii = i - searchRange : i + searchRange - 1%pencere içinde tutmak için blockSize cikarildi
                for jj = j - searchRange : j + searchRange - 1  
                    if ii > 0 && ii <= h - blockSize + 1 && jj > 0 && jj <= w - blockSize + 1%sinir kontrolleri
                        % blok içindeki piksellere eriþim
                        nnmp = 0 ;
                        for iii = 0 : blockSize-1
                            for jjj = 0 : blockSize-1
                                nnmp = nnmp + xor( I1B( ii + iii , jj + jjj  ) , I2B( i + iii , j + jjj  ));
                            end
                        end
                        if nnmp < minNnmp
                            minNnmp = nnmp ;
                            mvy = ii - i ;
                            mvx = jj - j ;
                            
                            elseif nnmp == minNnmp % farklý noktalarda eþit nnmp varsa daha yakýn olan seçilecek
                                if mvy * mvy + mvx * mvx > ( ii - i ) * ( ii - i ) + ( jj - j ) * ( jj - j )
                                     mvy = ii - i ;
                                     mvx = jj - j ;
                                end
                            
                        end
                    end
                end
            end
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % reconstruct iþlemleri
            for ii = 0:blockSize-1
                for jj = 0:blockSize-1
                    I2Predicted( i + ii , j + jj ) = I1( i + ii + mvy , j + jj + mvx );
                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
        end
    end %blok indislerini belirleyen döngülerin sonu
   
    imageName = sprintf(['C:\\MATLAB\\work\\test\\cikis\\output\\1BT' , sequenceName , '%3.3d.bmp'],imageNumber);
    imwrite(I1B,imageName);
    imageName = sprintf(['C:\\MATLAB\\work\\test\\cikis\\output\\1BT\\F' , sequenceName , '%3.3d.bmp'],imageNumber);
    imwrite(uint8(I1F),imageName);
    I1=I2;%referans çerçeve güncelleniyor
    I1F=I2F;
    I1B=I2B; 
    
    imageName = sprintf(['C:\\MATLAB\\work\\cikis\\1B' , sequenceName , '%3.3d.bmp'],imageNumber+1);
    imwrite(uint8((I2Predicted)),imageName);
     
    imageName = sprintf(['C:\\MATLAB\\work\\cikis\\1BD' , sequenceName , '%3.3d.bmp'],imageNumber+1);
    imwrite(uint8((I2Predicted)),imageName);
     
    MSE(imageNumber)= sum(sum((double(I2)-double(I2Predicted)).^2))/(h*w);
    psnr(imageNumber)=20*log10(255/sqrt(MSE(imageNumber)));
    imageNumber;
end


    result=sum(psnr)/(imageNumber)  
    



