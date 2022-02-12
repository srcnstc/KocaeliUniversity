clear all;close all;clc;
ak=zeros(1,8);gk=zeros(1,8);numberOfBits=8;indis=8;
dec=input('Decimal sayi giriniz=');
        while(dec>=1)
          ak(1,indis)=mod(dec,2);
          dec=dec-mod(dec,2);
          dec=dec/2;
          indis=indis-1;
        end
        indis=numberOfBits;
                gk(1,indis-(numberOfBits-1))=ak(1,indis-(numberOfBits-1));
        for ii=indis-(numberOfBits-2):1:numberOfBits
            gk(1,ii)=xor(ak(1,ii-1),ak(1,ii));
        end
        disp('Binary');
        disp(ak);
        disp('Gray kod=');
        disp(gk);
