%110207011 SERCAN SATICI
clear all;close all;clc;
% tic
%% NNMP / SAD Relation
blockSizeRow=16;%blok boyutu
blockSizeCol=16;%blok boyutu
searchRange=16;%arama araligi
numberOfBits=8;%bit sayisi(K=8) 
% sequenceName='foreman';%dizin ismi
sequenceName='football_cif';%dizin ismi
% sequenceName='stefan_cif';%dizin ismi
% sequenceName='BasketballPass';%dizin ismi
numberOfImages=260;%cerceve sayisi[foreman=300,footbal=260,BasketballPass=500,Stefan=90,fb=125,tennis=150,BigBuckBunny=300]
imageName=sprintf(['C:\\MATLAB\\TGCBPMWorkFootball\\test\\frames\\' , sequenceName , '%3.3d.bmp'],20);%goruntu ismi
% imageName=sprintf(['C:\\MATLAB\\TGCBPMWorkBasketballPass\\test\\frames\\' , sequenceName , '%3.3d.bmp'],1);%goruntu ismi
% imageName=sprintf(['C:\\MATLAB\\TGCBPMWorkStefan\\test\\frames\\' , sequenceName , '%3.3d.bmp'],1);%goruntu ismi
% imageName=sprintf(['C:\\MATLAB\\work\\test\\frames\\' , sequenceName , '%3.3d.bmp'],1);%goruntu ismi
%%t. frame
I1=imread(imageName);%t. goruntu okundu
I1=rgb2gray(I1);%iki boyutlu hale getirildi
I1T=I1;%gecici saklandi t. frame
I1double=double(I1);%SAD hesabinda kayip olmamasi icin
[h,w]=size(I1);%yukseklik,genislik alindi
ak=zeros(1,numberOfBits);%ikili kod
gk=zeros(1,numberOfBits);%gray kod
zerovector=zeros(1,numberOfBits);%0 vektoru
NTB=7;%kesilen bit sayisi
M=numberOfBits-NTB;%uyumlama yapilacak en deðerlikli bit duzlem sayisi
numberOfHorizontalBlocks=h/blockSizeCol;%yatay blok sayisi hesaplandi
numberOfVerticalBlocks=w/blockSizeRow;%dikey blok sayisi hesaplandi
indis=numberOfBits;
% vectors = zeros(2,(h*w)/(blockSize^2));
blockCount=1;
for i=1:h
    for j=1:w
        while(I1T(i,j)>=1)
          ak(1,indis)=mod(I1T(i,j),2);
          I1T(i,j)=I1T(i,j)-mod(I1T(i,j),2); 
          I1T(i,j)=I1T(i,j)/2;
          indis=indis-1;
        end
        indis=numberOfBits;
        %sayý binary hale getirildi
        gk(1,indis-(numberOfBits-1))=ak(1,indis-(numberOfBits-1));
        for ii=indis-(numberOfBits-2):1:numberOfBits
            gk(1,ii)=xor(ak(1,ii-1),ak(1,ii));
        end
        %binary kod gray kod haline getirildi 
        I1T(i,j)=gk(1,M);
        ak=zerovector;%ikili kod bir  sonraki piksel icin sifirlandi
        gk=zerovector;%gray kod bir  sonraki piksel icin sifirlandi
    end
end
% imwrite(I1T,'C:\\MATLAB\\work\\cikis\\1B_TGCBPM\\1Boyutlu.bmp');%dosya yazildi

dosya=fopen('NNMP.txt','w');%dosya acildi
dosya2=fopen('SAD.txt','w');%dosya acildi
% fprintf(dosya,'X /Y /nnmp /SAD \n');%baslýk yazildi
%%(t+1).frame
for imageNumber=20:21
    imageName=sprintf(['C:\\MATLAB\\TGCBPMWorkFootball\\test\\frames\\' , sequenceName , '%3.3d.bmp'],imageNumber+1);%goruntu ismi
    % imageName=sprintf(['C:\\MATLAB\\TGCBPMWorkBasketballPass\\test\\frames\\' , sequenceName , '%3.3d.bmp'],imageNumber+1);%goruntu ismi
    % imageName=sprintf(['C:\\MATLAB\\TGCBPMWorkStefan\\test\\frames\\' , sequenceName , '%3.3d.bmp'],imageNumber+1);%goruntu ismi
    % imageName=sprintf(['C:\\MATLAB\\work\\test\\frames\\' , sequenceName , '%3.3d.bmp'],imageNumber+1);%goruntu ismi
    I2 = imread(imageName);%bir sonraki cerceve okundu
    I2=rgb2gray(I2);%iki boyutlu hale getirildi
    I2T=I2;%gecici (t+1).frame
    I2double=double(I2);%SAD hesabi kayip olmamasi icin

    for i=1:h
        for j=1:w
             while(I2T(i,j)>=1)
                ak(1,indis)=mod(I2T(i,j),2);
                I2T(i,j)=I2T(i,j)-mod(I2T(i,j),2); 
                I2T(i,j)=I2T(i,j)/2;
                indis=indis-1;
             end
            indis=numberOfBits;
            %sayý binary hale getirildi
            gk(1,indis-(numberOfBits-1))=ak(1,indis-(numberOfBits-1));
             for ii=indis-(numberOfBits-2):1:numberOfBits
                  gk(1,ii)=xor(ak(1,ii-1),ak(1,ii));
             end
             %binary kod gray kod haline getirildi 
             I2T(i,j)=gk(1,M);
             ak=zerovector;%ikili kod bir  sonraki piksel icin sifirlandi
             gk=zerovector;%gray kod bir  sonraki piksel icin sifirlandi
        end
    end
    indis=numberOfBits;    
%     I2Predicted=zeros(h,w);%kestirim matrisi olusturuldu
%% Hareket Vektorlerinin Tespiti
  for i = 1 : blockSizeRow : h %16x16 blok boyutu
        for j = 1 : blockSizeCol : w
            mvx=0;%hareket vektörü -x- bileseni
            mvy=0;%hareket vektörü -y- bileseni
            % arama penceresine eriþim
            minNnmp=blockSizeRow*blockSizeCol ;%max (number of non-matching pixels)NNMP degeri
            for ii = i - searchRange : i + searchRange - 1%pencere içinde tutmak için blockSize cikarildi
                for jj = j - searchRange : j + searchRange - 1  
                    if ii > 0 && ii <= h - blockSizeRow + 1 && jj > 0 && jj <= w - blockSizeCol + 1%sinir kontrolleri
                        % blok içindeki piksellere eriþim
                        nnmp = 0 ;
                        SAD = 0;
                        for iii = 0 : blockSizeRow-1
                            for jjj = 0 : blockSizeCol-1
                                    nnmp = nnmp + (xor( I1T( ii + iii , jj + jjj  ) , I2T( i + iii , j + jjj  )));
                                    SAD = SAD + abs( I1double( ii + iii , jj + jjj  ) -  I2double( i + iii , j + jjj  ));
                             end
                        end
%                         disp(ii + iii);
%                         disp(jj + jjj);
%                         disp(i+iii);
%                         disp(j+jjj);%Kontrol islemleri
%                         disp(nnmp);
%                         disp(SAD);
%                         disp('----')
%                         pause
                        fprintf(dosya, '%d  \n',nnmp);
                        fprintf(dosya2,'%d  \n',SAD);
                    end
                end
            end

        end
    end %blok indislerini belirleyen döngülerin sonu


    I1=I2;%referans çerçeve güncellemesi
    I1T=I2T; 

end
fclose(dosya); %dosyayi kapat
fclose(dosya2); %dosyayi kapat  
% toc
    
     

   
