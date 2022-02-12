%110207011 SERCAN SATICI
clc;clear all;close all;
testimge=imread('testimage.jpg');%test imgesi okundu
testimge=rgb2gray(testimge);%iki boyutlu hale getirildi
figure(1),imshow(testimge);%imgeyi ekrana bas
testimge = double(testimge);%uint8 tipindeki imge double yapildi
[w h] = size(testimge);%imgenin genislik ve yuksekligi
se = strel('disk',2);%disk yapisi olusturuldu
kizcocuk = imread('face1.jpg');%maske olusturulacak ilk imge(kiz cocuk)
kizcocuk=rgb2gray(kizcocuk);
figure(2),imshow(kizcocuk);
erkekcocuk = imread('face2.jpg');%maske olusturulacak ikinci imge(erkek cocuk)
erkekcocuk=rgb2gray(erkekcocuk);
figure(3),imshow(erkekcocuk);

%% YUZ1(Kiz Cocuk Prototipi)

%% MASKE1
goz1=kizcocuk(4:10,7:36);%maske1 goz bolgesi ve arasi
goz1 = double(goz1);%double tipine cevir
kiz_maske1 = goz1;
kiz_maske1(:,1:7)=-1;
kiz_maske1(:,24:30)=-1;
kiz_maske1(:,8:23)=+1;
[wm1 hm1] = size(kiz_maske1);%maske boyutu
% figure,imshow(kiz_maske1);%maske1
maskelemesonucu1=testimge;
mask1Image = zeros(size(testimge));%test imgesi ile ayný boyutta 0 matrisi
sum(sum(kiz_maske1.*goz1)); % 5022 ,carpma islemi aslinda sola dogru fark alma,once sutunlarý topla sonra satir topla maske icin thresold degerini hesapla
for i=1:w-wm1
    for j=1:h-hm1
       total1 = sum(sum(kiz_maske1.*testimge(i:i+wm1-1,j:j+hm1-1)));  
       if(total1 > 4800 && total1 <5200)
          maskelemesonucu1(i+4,j+14,1)=255;%test imgesi thresolda yakýn oldugu yerleri beyaz yap
          mask1Image(i+4,j+14,1)=1;%test imgesi ile ayný boyutta 0 matrisinin thresolda yakýn oldugu yerleri siyah yap
       end
       total1=0;
    end
end
% figure(1),imshow(maskelemesonucu1,[]);
maskelemesonucu1 = imdilate(maskelemesonucu1,se);%genisletme
%  figure(2),imshow(maskelemesonucu1,[]);

%% MASKE2
eyes2=kizcocuk(4:10,1:41);%maske2 göz çevresi sað ve sol bölgesi
eyes2=double(eyes2);
kiz_maske2 = eyes2;
kiz_maske2(:,1:6)=1;
kiz_maske2(:,7:12)=-1;
kiz_maske2(:,13:29)=1;
kiz_maske2(:,30:36)=-1;
kiz_maske2(:,37:41)=1;
[wm2 hm2] = size(kiz_maske2);
% figure,imshow(kiz_maske2);
maskelemesonucu2 = testimge;
sum(sum(kiz_maske2.*eyes2)); % 16.667
mask2Image = zeros(size(testimge));
for i=1:w-wm2
    for j=1:h-hm2
       total2 = sum(sum(kiz_maske2.*maskelemesonucu2(i:i+wm2-1,j:j+hm2-1)));
        
       if( total2 > 16400 && total2 < 16800 ) 
         maskelemesonucu2(i+4,j+20)=255;%test imgesi thresolda yakýn oldugu yerleri beyaz yap
          mask2Image(i+4,j+20)=1;
       end
       total2=0;
    end
end
maskelemesonucu2 = imdilate(maskelemesonucu2,se);
% figure,imshow(maskelemesonucu2,[]);

%% MASKE3
eyes3=kizcocuk(1:8,7:36);%maske3 goz çevresi ve alin kismi
eyes3=double(eyes3);
kiz_maske3 = eyes3;
kiz_maske3(1:4,:)= 1;
kiz_maske3(5:8,:)=-1;
[wm3 hm3] = size(kiz_maske3);
% figure,imshow(kiz_maske3);
maskelemesonucu3 = testimge;
sum(sum(kiz_maske3.*eyes3)); % 3354
mask3Image = zeros(size(testimge));
for i=1:w-wm3
    for j=1:h-hm3
       total3 = sum(sum(kiz_maske3.*maskelemesonucu3(i:i+wm3-1,j:j+hm3-1)));
        
       if(total3 > 3000 && total3 < 3500) 
         maskelemesonucu3(i+6,j+14)=255;
          mask3Image(i+6,j+14)=1;
       end
       total3=0;
    end
end
maskelemesonucu3 = imdilate(maskelemesonucu3,se);
% figure,imshow(maskelemesonucu3,[]);

%% MASKE4
eyes4=kizcocuk(1:13,7:36);%maske4 goz alt ve ust alaniyla
eyes4=double(eyes4);
kiz_maske4 = eyes4;
kiz_maske4(1:4,:)=  1;
kiz_maske4(5:8,:)= -1;
kiz_maske4(9:13,:)= 1;
[wm4 hm4] = size(kiz_maske4);
% figure,imshow(kiz_maske4);
maskelemesonucu4 = testimge;
sum(sum(kiz_maske4.*eyes4)) ;% 23980
mask4Image = zeros(size(testimge));
for i=1:w-wm4
    for j=1:h-hm4
       total4 = sum(sum(kiz_maske4.*maskelemesonucu4(i:i+wm4-1,j:j+hm4-1)));
        
       if(total4 < 24000 && total4 > 23500) 
         maskelemesonucu4(i+6,j+14)=255;
         mask4Image(i+6,j+14)=1;
       end
       total4=0;
    end
end
maskelemesonucu4 = imdilate(maskelemesonucu4,se);
% figure,imshow(maskelemesonucu4,[]);

%% MASKE5
eyes5=kizcocuk(5:9,7:36);%maske5 sað ve sol göz farký
eyes5=double(eyes5);
kiz_maske5 = eyes5;
kiz_maske5(:,1:14)= -1;
kiz_maske5(:,15:end)= +1;
% figure,imshow(kiz_maske5);
[wm5 hm5] = size(kiz_maske5);
maskelemesonucu5 = testimge;
mask5Image = zeros(size(testimge));
sum(sum(kiz_maske5.*eyes5)) ;% 1139
for i=1:w-wm5
    for j=1:h-hm5
       total5 = sum(sum(kiz_maske5.*maskelemesonucu5(i:i+wm5-1,j:j+hm5-1)));
        
       if(total5 > 1130 && total5 < 1200) 
         maskelemesonucu5(i+2,j+14)=255;
         mask5Image(i+2,j+14)=1;
       end
       total5=0;
    end
end
maskelemesonucu5 = imdilate(maskelemesonucu5,se);
% figure,imshow(maskelemesonucu5,[]);

%% MASKE6
eyes6=kizcocuk(1:13,7:36);
eyes6=double(eyes6);
kiz_maske6 = eyes6 ;
kiz_maske6(1:7,1:14)= -1;
kiz_maske6(8:13,1:end)= -1;
kiz_maske6(1:7,15 :end)= +1;
kiz_maske6(8:13,1:14)= +1;
[wm6 hm6] = size(kiz_maske6);
% figure,imshow(kiz_maske6);
maskelemesonucu6 = testimge;
sum(sum(kiz_maske6.*eyes6)) ;% 1139
mask6Image = zeros(size(testimge));
for i=1:w-wm6
    for j=1:h-hm6
       total6 = sum(sum(kiz_maske6.*maskelemesonucu6(i:i+wm6-1,j:j+hm6-1)));
        
       if(total6 > 850 && total6 < 900) 
         maskelemesonucu6(i+6,j+14)=255;
         mask6Image(i+6,j+14)=1;
       end
       total6=0;
    end
end
maskelemesonucu6 = imdilate(maskelemesonucu6,se);
% figure,imshow(maskelemesonucu6,[]);

%% MASKE7
eyes7=kizcocuk(5:12,7:36);%maske7 goz ve goz alti bolgesi
eyes7=double(eyes7);
kiz_maske7 = eyes7;
kiz_maske7(1:4,:)= -1;
kiz_maske7(5:8,:)= 1;
% figure,imshow(kiz_maske7);
[wm7 hm7] = size(kiz_maske7);
maskelemesonucu7 = testimge;
mask7Image = zeros(size(testimge));
sum(sum(kiz_maske7.*eyes7)) ;% 2762
for i=1:w-wm7
    for j=1:h-hm7
       total7 = sum(sum(kiz_maske7.*maskelemesonucu7(i:i+wm7-1,j:j+hm7-1)));
        
       if(total7 > 2500 && total7 < 3000) 
         maskelemesonucu7(i+2,j+14)=255;
         mask7Image(i+2,j+14)=1;
       end
       total7=0;
    end
end
maskelemesonucu7 = imdilate(maskelemesonucu7,se);
% figure,imshow(maskelemesonucu7,[]);

%% YUZ2(Erkek Cocuk Prototipi)

%% MASKE1
eyes21=erkekcocuk(13:19,9:36);%maske1 sadece goz bolgesi ve arasi
eyes21 = double(eyes21);
erkek_maske1 = eyes21;
erkek_maske1(:,1:8)=1;
erkek_maske1(:,9:21)=-1;
erkek_maske1(:,22:end)=+1;
[wm21 hm21] = size(erkek_maske1);
% figure,imshow(erkek_maske1);
Emaskelemesonucu1=testimge;
mask21Image = zeros(size(testimge));
sum(sum(erkek_maske1.*eyes21)); % -742
for i=1:w-wm21
    for j=1:h-hm21
       total21 = sum(sum(erkek_maske1.*Emaskelemesonucu1(i:i+wm21-1,j:j+hm21-1)));
        if(total21 > -50 && total21 < 0)
         Emaskelemesonucu1(i+3,j+12,1)=255;
         mask21Image(i+3,j+12,1)=1;
        end
       total21=0;
    end
end
total2  = sum(sum(erkek_maske1.*Emaskelemesonucu1(i:i+wm21-1,j:j+hm21-1)));
Emaskelemesonucu1 = imdilate(Emaskelemesonucu1,se);
% figure,imshow(Emaskelemesonucu1,[]);

%% MASKE2
eyes22=erkekcocuk(14:18,4:40);
eyes22=double(eyes22);
erkek_maske2 = eyes22;
erkek_maske2(:,1:6)=1;
erkek_maske2(:,7:13)=-1;
erkek_maske2(:,13:27)=1;
erkek_maske2(:,28:32)=-1;
erkek_maske2(:,33:37)=1;
[wm22 hm22] = size(erkek_maske2);
% figure,imshow(erkek_maske2);
Emaskelemesonucu2 = testimge;
sum(sum(erkek_maske2.*eyes22)) ;% 11750
mask22Image = zeros(size(testimge));
for i=1:w-wm22
    for j=1:h-hm22
       total22 = sum(sum(erkek_maske2.*Emaskelemesonucu2(i:i+wm22-1,j:j+hm22-1)));
        
       if( total22 > 11750 && total22 < 12000 ) 
         Emaskelemesonucu2(i+2,j+20)=255;
          mask22Image(i+2,j+20)=1;
       end
       total22=0;
    end
end
Emaskelemesonucu2 = imdilate(Emaskelemesonucu2,se);
% figure,imshow(Emaskelemesonucu2,[]);

%% MASKE3
eyes23=erkekcocuk(9:18,11:35);
eyes23=double(eyes23);
erkek_maske3 = eyes23;
erkek_maske3(1:4,:)= 1;
erkek_maske3(5:end,:)=-1;
[wm23 hm23] = size(erkek_maske3);
% figure,imshow(erkek_maske3);
Emaskelemesonucu3 = testimge;
sum(sum(erkek_maske3.*eyes23)) ;% -3065
mask23Image = zeros(size(testimge));
for i=1:w-wm23
    for j=1:h-hm23
       total23 = sum(sum(erkek_maske3.*Emaskelemesonucu3(i:i+wm23-1,j:j+hm23-1)));
        
       if(total23 > -3200 && total23 < -3000) 
         Emaskelemesonucu3(i+6,j+14)=255;
          mask23Image(i+6,j+14)=1;
       end
       total23=0;
    end
end
Emaskelemesonucu3 = imdilate(Emaskelemesonucu3,se);
% figure,imshow(Emaskelemesonucu3,[]);

%% MASKE4
eyes24=erkekcocuk(10:23,11:35);
eyes24=double(eyes24);
erkek_maske4 = eyes24;
erkek_maske4(1:4,:)=  1;
erkek_maske4(5:10,:)= -1;
erkek_maske4(11:14,:)= 1;
[wm24 hm24] = size(erkek_maske4);
% figure,imshow(erkek_maske4);
Emaskelemesonucu4 = testimge;
sum(sum(erkek_maske4.*eyes24)) ;% 11067
mask24Image = zeros(size(testimge));
for i=1:w-wm24
    for j=1:h-hm24
       total24 = sum(sum(erkek_maske4.*Emaskelemesonucu4(i:i+wm24-1,j:j+hm24-1)));
        
       if(total24 < 11500 && total24 > 11000) 
         Emaskelemesonucu4(i+6,j+12)=255;
         mask24Image(i+6,j+12)=1;
       end
       total24=0;
    end
end
Emaskelemesonucu4 = imdilate(Emaskelemesonucu4,se);
% figure,imshow(Emaskelemesonucu4,[]);

%% MASKE5
eyes25=erkekcocuk(13:19,9:36);
eyes25=double(eyes25);
erkek_maske5 = eyes25;
erkek_maske5(:,1:13)= -1;
erkek_maske5(:,14:end)= +1;
% figure,imshow(erkek_maske5);
[wm25 hm25] = size(erkek_maske5);
Emaskelemesonucu5 = testimge;
mask25Image = zeros(size(testimge));
sum(sum(erkek_maske5.*eyes25)) ;% 2108
for i=1:w-wm25
    for j=1:h-hm25
       total25 = sum(sum(erkek_maske5.*Emaskelemesonucu5(i:i+wm25-1,j:j+hm25-1)));
         if(total25 > 2080 && total25 < 2120) 
                Emaskelemesonucu5(i+2,j+13)=255;
                mask25Image(i+2,j+13)=1;
         end
       total25=0;
    end
end
Emaskelemesonucu5 = imdilate(Emaskelemesonucu5,se);
% figure,imshow(Emaskelemesonucu5,[]);

%% MASKE6
eyes26=erkekcocuk(9:18,11:35);
eyes26=double(eyes26);
erkek_maske6 = eyes26 ;
erkek_maske6(1:5,1:13)= -1;
erkek_maske6(1:5,14:end)= +1;
erkek_maske6(6:end,1:14)= +1;
erkek_maske6(6:end,14:end)= -1;
[wm26 hm26] = size(erkek_maske6);
% figure,imshow(erkek_maske6);
Emaskelemesonucu6 = testimge;
sum(sum(erkek_maske6.*eyes26)) ;% 79
mask26Image = zeros(size(testimge));
for i=1:w-wm26
    for j=1:h-hm26
       total26 = sum(sum(erkek_maske6.*Emaskelemesonucu6(i:i+wm26-1,j:j+hm26-1)));
       if(total26 > 70 && total26 < 90) 
         Emaskelemesonucu6(i+7,j+12)=255;
         mask26Image(i+7,j+12)=1;
       end
       total26=0;
    end
end
Emaskelemesonucu6 = imdilate(Emaskelemesonucu6,se);
% figure,imshow(Emaskelemesonucu6,[]);

%% MASKE7
eyes27=erkekcocuk(10:18,7:36);
eyes27=double(eyes27);
erkek_maske7 = eyes27;
erkek_maske7(1:4,:)= -1;
erkek_maske7(5:9,:)= 1;
% figure,imshow(erkek_maske7);
[wm27 hm27] = size(erkek_maske7);
Emaskelemesonucu7 = testimge;
mask27Image = zeros(size(testimge));
sum(sum(erkek_maske7.*eyes27)) ;
for i=1:w-wm27
    for j=1:h-hm27
       total27 = sum(sum(erkek_maske7.*Emaskelemesonucu7(i:i+wm27-1,j:j+hm27-1)));
         if(total27 > -120 && total27 < -20) 
            Emaskelemesonucu7(i+6,j+16)=255;
            mask27Image(i+6,j+16)=1;
         end
        total27=0;
    end
end
Emaskelemesonucu7 = imdilate(Emaskelemesonucu7,se);
% figure,imshow(Emaskelemesonucu7,[]);

%% SONUC ASAMASI

%% Kiz Cocuk icin Sonuc
total_mask = maskelemesonucu1 + maskelemesonucu2 + maskelemesonucu3 +maskelemesonucu4 +maskelemesonucu5 + maskelemesonucu6 + maskelemesonucu7   ;
counter=0;
i_total=0;
j_total = 0;
[wt ht]=size(total_mask);
for i=1 : wt
    for j=1 : ht
        if total_mask(i,j)>= 255*7-2
            total_(i,j)=255;
            i_total = i_total+i;%tum maskeleme sonucunda beyaz olan kýsýmda hedef bolgenin tespiti icin o anki indis ile topla
            j_total = j_total+j; 
            counter = counter+1;  
        else total_(i,j)=0;
        end
    end
end
i_total = ceil(i_total/counter);%satir bazinda hedef yeri
j_total = ceil(j_total/counter);%sutun bazinda hedef yeri
se = strel('disk',1);
total_ = imerode(total_,se);

%% Erkek Cocuk icin Sonuc
total_mask2 = Emaskelemesonucu1+ Emaskelemesonucu2 +  Emaskelemesonucu3 +Emaskelemesonucu5 + Emaskelemesonucu7   ;
counter2=0;
i2_total=0;
j2_total = 0;
[wt2 ht2]=size(total_mask2);
for i=1 : wt2
    for j=1 : ht2
        if total_mask2(i,j)>= 255*5-2
            total_2(i,j)=255;
            i2_total = i2_total+i;
            j2_total = j2_total+j; 
            counter2 = counter2+1;  
        else total_2(i,j)=0;
        end
    end
end
i2_total = ceil(i2_total/counter2);
j2_total = ceil(j2_total/counter2);
se = strel('disk',1);
total_2 = imerode(total_2,se);

%% Tespit edileni cerceve icine alma
testimge=imread('testimage.jpg');
testimge(i_total-30 : i_total+30,j_total-30,1)=255;
testimge(i_total-30 : i_total+30,j_total+30,1)=255; %Kiz cocugu kirmizi kare cerceveye al
testimge(i_total-30 , j_total-30:j_total+30,1)=255;
testimge(i_total+30 , j_total-30:j_total+30,1)=255;

testimge(i2_total-30 : i2_total+30,j2_total-30,2)=255;
testimge(i2_total-30 : i2_total+30,j2_total+30,2)=255; %Erkek cocugu yesil kare cerceveye al
testimge(i2_total-30 , j2_total-30:j2_total+30,2)=255;
testimge(i2_total+30 , j2_total-30:j2_total+30,2)=255;

figure(4),imshow(testimge,[]);
%help vision.CascadeObjectDetector go to example and show