clear all ; close all ; clc;
I = imread('toonifys.bmp');
%I = imread('toonifys2.bmp');
se = strel('disk',1); % Kenar genisletme elemanlarý tanimlandi
figure(1), imshow(I);
title ('Orjinal Goruntu');

%% Ilk eleman
R = I(:,:,1); % Median Filtresi Uygulamasý / Median Filter
G = I(:,:,2);
B = I(:,:,3);
I2(:,:,1) = medfilt2(R);
I2(:,:,2) = medfilt2(G);
I2(:,:,3) = medfilt2(B);

figure(2) , imshow(I2);
title ('Median Uygulanmis Goruntu');

R = I2(:,:,1); % Goruntu Duzenlemesi / Image Adjusting
G = I2(:,:,2); % Goruntu kalitesi bakýmýndan imadjust filtresinden yararlanildi
B = I2(:,:,3);
J(:,:,1) = imadjust(R);
J(:,:,2) = imadjust(G);
J(:,:,3) = imadjust(B);

figure(3) , imshow(J);
title('Image Adjusting Uygulanmis Goruntu');


Brr = edge(J(:,:,1),'canny',0.1); % Kenar Cikarma(Bulma) Uygulamasý / Edge Finding
Bgg = edge(J(:,:,2),'canny',0.1); % Kenar bulma filtreleri arasidan en uygunu canny secildi
Bbb = edge(J(:,:,3),'canny',0.1);
Bb = imdilate (Bbb,se);
Bg = imdilate (Bgg,se);
Br = imdilate (Brr,se);


for i=1:size(Br,1)  % Her bir RGB elemanýnda bulunan kenarlar orjinal goruntuye aktarildi
    for j=1:size(Br,2)
        if((Br(i,j)==1 && Bg(i,j)==1) || (Bb(i,j)==1 && Bg(i,j)==1) || (Br(i,j)==1 && Bb(i,j)==1))
            J(i,j,:)= 0;
        end
    end
end


figure(4) , imshow(J);
title('Kenar Filtreleme Uygulanmis Goruntu');

J1 = imdilate(J,se); % Kenar Genisletme / Edge Dilation


figure(5), imshow(J1);
title('Kenar Genisletme Uygulanmis Goruntu');

%% Ikinci eleman

% Bilateral Filter
% Goruntunun double ve bit araligi [0,1] araliginda olmali
img = double(imread('toonifys.bmp'))/255;
%img = double(imread('toonifys2.bmp'))/255;

img = img+0.03*randn(size(img));
img(img<0) = 0; img(img>1) = 1;

% Bilateral filtre parametreleri ayarlandý
w     = 5;       % bilateral filtre yari genislik
sigma = [3 0.1]; % bilateral filtre standart sapmasi

% Goruntuye bilateral filtre uygulama
bflt_img = bfilter2(img,w,sigma);
figure(6), imshow(bflt_img);
title('Bilateral Filtre Uygulanmýþ Görüntü');


R = bflt_img(:,:,1); % Median Filtresi Uygulamasý / Median Filter
G = bflt_img(:,:,2);
B = bflt_img(:,:,3);
med2(:,:,1) = medfilt2(R); % Median filtre 2 boyutlu imgelere uygulandigi icin her bir RGB elemani ayri ayri Median Filtreye tabi tutuldu
med2(:,:,2) = medfilt2(G);
med2(:,:,3) = medfilt2(B);

figure(7) , imshow(med2);
title ('Median Uygulanmis Goruntu');

for i=1:size(med2,1) %% Renk Indirgeme(quantization)
    for j=1:size(med2,2) % Temel olarak PDF'teki degerler kullanýlarak renk indirgendi
        for k=1:size(med2,3) % Yorum olarak renkler icin denenen iyi sonuçlar alýnan farkli degerler yazildi
            if (med2(i,j,k)<= 0.24)
                med2(i,j,k)=0.125; % 0.05
            end
            if (med2(i,j,k)> 0.24 && med2(i,j,k)<= 0.5)
                med2(i,j,k) = 0.375; % 0.3
            end
            if (med2(i,j,k)> 0.5 && med2(i,j,k)<= 0.75)
                med2(i,j,k) = 0.62; % 0.7
            end
            if (med2(i,j,k)> 0.75 && med2(i,j,k)<= 1)
                med2(i,j,k) = 0.875; % 0.95
            end
        end
    end
end

R = med2(:,:,1); % Median Filtresi Uygulamasý / Median Filter
G = med2(:,:,2);
B = med2(:,:,3);
med2(:,:,1) = medfilt2(R);
med2(:,:,2) = medfilt2(G);
med2(:,:,3) = medfilt2(B);


figure(8) , imshow(med2);
title ('Renk Indirgeme Uygulanmis Goruntu');


R = med2(:,:,1); % Median Filtresi Uygulamasý / Median Filter daha iyi goruntu icin median 2 kez uygulandi
G = med2(:,:,2);
B = med2(:,:,3);
med3(:,:,1) = medfilt2(R);
med3(:,:,2) = medfilt2(G);
med3(:,:,3) = medfilt2(B);

figure(9) , imshow(med3);
title ('Median Uygulanmis Goruntu');

%% Son olarak J1 ve med3 imgelerini kombine etme

toonify = zeros(size(J1,1),size(J1,2),3);
for i=1:size(J1,1)
    for j=1:size(J1,2)
        if (J1(i,j,1)==0 && J1(i,j,2)==0 && J1(i,j,3)==0)
            toonify(i,j,1) = 0;
            toonify(i,j,2) = 0;
            toonify(i,j,3) = 0;
        else
            toonify(i,j,1) = med3(i,j,1);
            toonify(i,j,2) = med3(i,j,2);
            toonify(i,j,3) = med3(i,j,3);
        end
    end
end

figure(10), imshow(toonify);
            
        
