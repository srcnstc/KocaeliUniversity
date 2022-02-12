%110207011 SERCAN SATICI
clear all;close all;clc;
fileName=sprintf('C:\\Dosyalar�m\\Electronics and Com. Engineering\\Optimizasyon Tekniklerine Giri�\\�dev\\ilmesafe');%dosya ismi
ilmesafeleri=xlsread(fileName);%il mesafelerini iceren .xls dosyasi okundu(http://www.kgm.gov.tr/)
for i=1:81
    for j=1:81
        if(i==j)
            ilmesafeleri(i,j)=0;%NaN ifadeleri(ayn� ilin kendine uzakl�gi) 0 yapildi
        end
    end
end
mutasyonorani=1/3;%mutasyon orani yaklasik %33 olarak belirlendi
% stop=0;%durdurma olcutu
minMesafe=100000;%durdurma olcutu
width=81;%dizi uzunlugu
indis=width*mutasyonorani;%27
%% 1-Baslangic populasyonu olusturulmas�
PopulasyonBuyuklugu=81;
P1=randperm(81,PopulasyonBuyuklugu);%81 boyutlu [1 81] aras�nda tekrarsiz farkl�  say�lar uret
% ilknokta=P1(1);%baslangic noktasi
% sonnokta=ilknokta;%son nokta olarak baslang�c noktasi belirlendi 
% P1(1,82)=sonnokta;%populasyonun son noktasina baslang�c noktasi eklendi

P2=randperm(81,PopulasyonBuyuklugu);%81 boyutlu [1 81] aras�nda tekrarsiz farkl�  say�lar uret
% ilknokta=P2(1);%baslangic noktasi
% sonnokta=ilknokta;%son nokta olarak baslang�c noktasi belirlendi 
% P2(1,82)=sonnokta;%populasyonun son noktasina baslang�c noktasi eklendi

P3=randperm(81,PopulasyonBuyuklugu);%81 boyutlu [1 81] aras�nda tekrarsiz farkl�  say�lar uret
% ilknokta=P3(1);%baslangic noktasi
% sonnokta=ilknokta;%son nokta olarak baslang�c noktasi belirlendi 
% P3(1,82)=sonnokta;%populasyonun son noktasina baslang�c noktasi eklendi

% P4=randperm(81,PopulasyonBuyuklugu);%81 boyutlu [1 81] aras�nda tekrarsiz farkl�  say�lar uret
% ilknokta=P4(1);%baslangic noktasi
% sonnokta=ilknokta;%son nokta olarak baslang�c noktasi belirlendi 
% P4(1,82)=sonnokta;%populasyonun son noktasina baslang�c noktasi eklendi

% P5=randperm(81,PopulasyonBuyuklugu);%81 boyutlu [1 81] aras�nda tekrarsiz farkl�  say�lar uret
% ilknokta=P5(1);%baslangic noktasi
% sonnokta=ilknokta;%son nokta olarak baslang�c noktasi belirlendi 
% P5(1,82)=sonnokta;%populasyonun son noktasina baslang�c noktasi eklendi

%Tum olasi cozumlerden bir grup cozum dizi olarak kodlandi

while(minMesafe>55000)%Durdurma olcutu saglan�ncaya kadar devam edecek dongu baslangici
%% 2-Uygunluk Degeri Hesaplamasi
mesafeP1=0;mesafeP2=0;mesafeP3=0;
%mesafeP4=0;mesafeP5=0;
C1=zeros(1,width);%cocuk1
C2=zeros(1,width);%cocuk2
P1temp=zeros(1,width);%P1'
P2temp=zeros(1,width);%P2'
P1temp2=zeros(1,width);%P1''
P2temp2=zeros(1,width);%P2''
P1temp3=zeros(1,width-indis);%P1'''
P2temp3=zeros(1,width-indis);%P2'''
for i=1:width-1
    mesafeP1=mesafeP1+ilmesafeleri(P1(i),P1(i+1));
    mesafeP2=mesafeP2+ilmesafeleri(P2(i),P2(i+1));
    mesafeP3=mesafeP3+ilmesafeleri(P3(i),P3(i+1));
%     mesafeP4=mesafeP4+ilmesafeleri(P4(i),P4(i+1));
%     mesafeP5=mesafeP5+ilmesafeleri(P5(i),P5(i+1));
end
%Dizilerin cozum kalitesi elde edildi
mesafe=[mesafeP1 mesafeP2 mesafeP3];
%BubbleSort
for j=1:3
    for i=1:2
        if(mesafe(1,i+1)<mesafe(1,i))
            temp=mesafe(1,i);
            mesafe(1,i)=mesafe(1,i+1);
            mesafe(1,i+1)=temp;
        end
    end
end
%BubbleSort algoritmas� ile mesafeler kucukten buyuge s�ralandi en uzun mesafeli, yani en k�t� bireyi eleyece�iz
minMesafe=mesafe(1);%Durdurma olcutu,en kucuk mesafe
%% 3-Caprazlama ve Mutasyon Islemleri
maxFlag=0;
minFlag=0;
if(mesafe(3)==mesafeP1)%en buyuk mesafe Populasyon1'e ait ise
    maxFlag=1;
else if(mesafe(3)==mesafeP2)%en buyuk mesafe Populasyon2'e ait ise
    maxFlag=2;   
    else%en buyuk mesafe Populasyon3'e ait ise
    maxFlag=3;    
    end
end
%maxFlag degeri ne ise en buyuk mesafe o populasyona aittir

if(mesafe(1)==mesafeP1)%en kucuk mesafe Populasyon1'e ait ise
    minFlag=1;
else if(mesafe(1)==mesafeP2)%en kucuk mesafe Populasyon2'e ait ise
    minFlag=2;
    else%en kucuk mesafe Populasyon3'e ait ise
    minFlag=3;
    end
end
%minFlag degeri ne ise en kucuk mesafe o populasyona aittir

%S�ra Temelli Caprazlama

% 3!=6 farkl� kombinasyon ile caprazlanacak iki bireyin yerine gelecek iki bireylerin tespiti yap�lacak
%Kombinasyon(1)
if(maxFlag==1 && minFlag==2)%P2 ve P3 caprazlanacak olusacak yeni birey en kotu bireyler P1 ve P3 yerine yazilacak
    P11=P2;
    P22=P3;
    ii=width-(indis-1);
    for i=indis+1:1:(indis*2)
        C1(i)=P11(i);%korunacak kod kisimlari
        P1temp(ii)=P11(i);%korunacak kod k�s�mlari,gecici degiskenin sonuna atildi
        C2(i)=P22(i);
        P2temp(ii)=P22(i);
        ii=ii+1;  
    end

    j=1;
    for i=(indis*2)+1:1:width
        P1temp(j)=P11(i);%son kisim basa aktarildi
        P2temp(j)=P22(i);
        j=j+1;
    end

    for i=1:1:indis
        P1temp(j)=P11(i);%ilk kisim ortaya alindi
        P2temp(j)=P22(i);
        j=j+1;
    end

    jtemp=j;%alt dizi c�karmadan indis gecici degiskende tutulur,j=width-(indis-1)
    P1temp2=P1temp;
    P2temp2=P2temp;

    for i=1:width
        for k=0:indis-1
            if(P1temp2(i)== P2temp(j+k))
                P1temp2(i)=0;%'*'
            end
            %yeni s�ralanan 2.ebeveynden 1.ebeveynin alt dizisi cikarildi
            if(P2temp2(i)== P1temp(j+k))
                P2temp2(i)=0;%'*'
            end
            %ayn� islem diger yondede yapildi 
        end
    end

    jj=1;
    for i=1:width
        if(P1temp2(i)==0)
            continue%'*' ifadesi ise bir sonraki indise devam et
        end
        P1temp3(jj)=P1temp2(i);
        jj=jj+1;
    end

    jj=1;
    for i=1:width
        if(P2temp2(i)==0)
            continue%'*' ifadesi ise bir sonraki indise devam et
        end
        P2temp3(jj)=P2temp2(i);
        jj=jj+1;
    end
    %cikarilan kisimlar olmadan dizi duzenlendi

    jj=indis+1;
    for i=1:indis
        C1(i)=P2temp3(jj);
        C2(i)=P1temp3(jj);
        jj=jj+1;
    end
    jj=1;
    for i=(indis*2)+1:width
        C1(i)=P2temp3(jj);
        C2(i)=P1temp3(jj);
        jj=jj+1;
    end
    P1=C1;
    P3=C2;
    %yeni bireyler meydana getirildi
end
%Kombinasyon(2)
if(maxFlag==1 && minFlag==3)%P2 ve P3 caprazlanacak olusacak yeni birey en kotu bireyler P1 ve P2 yerine yazilacak
    P11=P2;
    P22=P3;
    ii=width-(indis-1);
    for i=indis+1:1:(indis*2)
        C1(i)=P11(i);%korunacak kod kisimlari
        P1temp(ii)=P11(i);%korunacak kod k�s�mlari,gecici degiskenin sonuna atildi
        C2(i)=P22(i);
        P2temp(ii)=P22(i);
        ii=ii+1;  
    end

    j=1;
    for i=(indis*2)+1:1:width
        P1temp(j)=P11(i);%son kisim basa aktarildi
        P2temp(j)=P22(i);
        j=j+1;
    end

    for i=1:1:indis
        P1temp(j)=P11(i);%ilk kisim ortaya alindi
        P2temp(j)=P22(i);
        j=j+1;
    end

    jtemp=j;%alt dizi c�karmadan indis gecici degiskende tutulur,j=width-(indis-1)
    P1temp2=P1temp;
    P2temp2=P2temp;

    for i=1:width
        for k=0:indis-1
            if(P1temp2(i)== P2temp(j+k))
                P1temp2(i)=0;
            end
            %yeni s�ralanan 2.ebeveynden 1.ebeveynin alt dizisi cikarildi
            if(P2temp2(i)== P1temp(j+k))
                P2temp2(i)=0;
            end
            %ayn� islem diger yondede yapildi 
        end
    end

    jj=1;
    for i=1:width
        if(P1temp2(i)==0)
            continue
        end
        P1temp3(jj)=P1temp2(i);
        jj=jj+1;
    end

    jj=1;
    for i=1:width
        if(P2temp2(i)==0)
            continue
        end
        P2temp3(jj)=P2temp2(i);
        jj=jj+1;
    end
    %cikarilan kisimlar olmadan dizi duzenlendi

    jj=indis+1;
    for i=1:indis
        C1(i)=P2temp3(jj);
        C2(i)=P1temp3(jj);
        jj=jj+1;
    end
    jj=1;
    for i=(indis*2)+1:width
        C1(i)=P2temp3(jj);
        C2(i)=P1temp3(jj);
        jj=jj+1;
    end
    P1=C1;
    P2=C2;
    %yeni bireyler meydana getirildi
end

%Kombinasyon(3)
if(maxFlag==2 && minFlag==1)%P1 ve P3 caprazlanacak olusacak yeni birey en kotu bireyler P2 ve P3 yerine yazilacak
    P11=P1;
    P22=P3;
    ii=width-(indis-1);
    for i=indis+1:1:(indis*2)
        C1(i)=P11(i);%korunacak kod kisimlari
        P1temp(ii)=P11(i);%korunacak kod k�s�mlari,gecici degiskenin sonuna atildi
        C2(i)=P22(i);
        P2temp(ii)=P22(i);
        ii=ii+1;  
    end

    j=1;
    for i=(indis*2)+1:1:width
        P1temp(j)=P11(i);%son kisim basa aktarildi
        P2temp(j)=P22(i);
        j=j+1;
    end

    for i=1:1:indis
        P1temp(j)=P11(i);%ilk kisim ortaya alindi
        P2temp(j)=P22(i);
        j=j+1;
    end

    jtemp=j;%alt dizi c�karmadan indis gecici degiskende tutulur,j=width-(indis-1)
    P1temp2=P1temp;
    P2temp2=P2temp;

    for i=1:width
        for k=0:indis-1
            if(P1temp2(i)== P2temp(j+k))
                P1temp2(i)=0;
            end
            %yeni s�ralanan 2.ebeveynden 1.ebeveynin alt dizisi cikarildi
            if(P2temp2(i)== P1temp(j+k))
                P2temp2(i)=0;
            end
            %ayn� islem diger yondede yapildi 
        end
    end

    jj=1;
    for i=1:width
        if(P1temp2(i)==0)
            continue
        end
        P1temp3(jj)=P1temp2(i);
        jj=jj+1;
    end

    jj=1;
    for i=1:width
        if(P2temp2(i)==0)
            continue
        end
        P2temp3(jj)=P2temp2(i);
        jj=jj+1;
    end
    %cikarilan kisimlar olmadan dizi duzenlendi

    jj=indis+1;
    for i=1:indis
        C1(i)=P2temp3(jj);
        C2(i)=P1temp3(jj);
        jj=jj+1;
    end
    jj=1;
    for i=(indis*2)+1:width
        C1(i)=P2temp3(jj);
        C2(i)=P1temp3(jj);
        jj=jj+1;
    end
    P2=C1;
    P3=C2;
    %yeni bireyler meydana getirildi
end

%Kombinasyon(4)
if(maxFlag==2 && minFlag==3)%P1 ve P3 caprazlanacak olusacak yeni birey en kotu bireyler P1 ve P2 yerine yazilacak
    P11=P1;
    P22=P3;
    ii=width-(indis-1);
    for i=indis+1:1:(indis*2)
        C1(i)=P11(i);%korunacak kod kisimlari
        P1temp(ii)=P11(i);%korunacak kod k�s�mlari,gecici degiskenin sonuna atildi
        C2(i)=P22(i);
        P2temp(ii)=P22(i);
        ii=ii+1;  
    end

    j=1;
    for i=(indis*2)+1:1:width
        P1temp(j)=P11(i);%son kisim basa aktarildi
        P2temp(j)=P22(i);
        j=j+1;
    end

    for i=1:1:indis
        P1temp(j)=P11(i);%ilk kisim ortaya alindi
        P2temp(j)=P22(i);
        j=j+1;
    end

    jtemp=j;%alt dizi c�karmadan indis gecici degiskende tutulur,j=width-(indis-1)
    P1temp2=P1temp;
    P2temp2=P2temp;

    for i=1:width
        for k=0:indis-1
            if(P1temp2(i)== P2temp(j+k))
                P1temp2(i)=0;
            end
            %yeni s�ralanan 2.ebeveynden 1.ebeveynin alt dizisi cikarildi
            if(P2temp2(i)== P1temp(j+k))
                P2temp2(i)=0;
            end
            %ayn� islem diger yondede yapildi 
        end
    end

    jj=1;
    for i=1:width
        if(P1temp2(i)==0)
            continue
        end
        P1temp3(jj)=P1temp2(i);
        jj=jj+1;
    end

    jj=1;
    for i=1:width
        if(P2temp2(i)==0)
            continue
        end
        P2temp3(jj)=P2temp2(i);
        jj=jj+1;
    end
    %cikarilan kisimlar olmadan dizi duzenlendi

    jj=indis+1;
    for i=1:indis
        C1(i)=P2temp3(jj);
        C2(i)=P1temp3(jj);
        jj=jj+1;
    end
    jj=1;
    for i=(indis*2)+1:width
        C1(i)=P2temp3(jj);
        C2(i)=P1temp3(jj);
        jj=jj+1;
    end
    P1=C1;
    P2=C2;
    %yeni bireyler meydana getirildi
end

%Kombinasyon(5)
    if(maxFlag==3 && minFlag==1)%P1 ve P2 caprazlanacak olusacak yeni birey en kotu bireyler P2 ve P3 yerine yazilacak
    P11=P1;
    P22=P2;
    ii=width-(indis-1);
    for i=indis+1:1:(indis*2)
        C1(i)=P11(i);%korunacak kod kisimlari
        P1temp(ii)=P11(i);%korunacak kod k�s�mlari,gecici degiskenin sonuna atildi
        C2(i)=P22(i);
        P2temp(ii)=P22(i);
        ii=ii+1;  
    end

    j=1;
    for i=(indis*2)+1:1:width
        P1temp(j)=P11(i);%son kisim basa aktarildi
        P2temp(j)=P22(i);
        j=j+1;
    end

    for i=1:1:indis
        P1temp(j)=P11(i);%ilk kisim ortaya alindi
        P2temp(j)=P22(i);
        j=j+1;
    end

    jtemp=j;%alt dizi c�karmadan indis gecici degiskende tutulur,j=width-(indis-1)
    P1temp2=P1temp;
    P2temp2=P2temp;

    for i=1:width
        for k=0:indis-1
            if(P1temp2(i)== P2temp(j+k))
                P1temp2(i)=0;
            end
            %yeni s�ralanan 2.ebeveynden 1.ebeveynin alt dizisi cikarildi
            if(P2temp2(i)== P1temp(j+k))
                P2temp2(i)=0;
            end
            %ayn� islem diger yondede yapildi 
        end
    end

    jj=1;
    for i=1:width
        if(P1temp2(i)==0)
            continue
        end
        P1temp3(jj)=P1temp2(i);
        jj=jj+1;
    end

    jj=1;
    for i=1:width
        if(P2temp2(i)==0)
            continue
        end
        P2temp3(jj)=P2temp2(i);
        jj=jj+1;
    end
    %cikarilan kisimlar olmadan dizi duzenlendi

    jj=indis+1;
    for i=1:indis
        C1(i)=P2temp3(jj);
        C2(i)=P1temp3(jj);
        jj=jj+1;
    end
    jj=1;
    for i=(indis*2)+1:width
        C1(i)=P2temp3(jj);
        C2(i)=P1temp3(jj);
        jj=jj+1;
    end
    P2=C1;
    P3=C2;
    %yeni bireyler meydana getirildi
end

%Kombinasyon(6)
if(maxFlag==3 && minFlag==2)%P1 ve P2 caprazlanacak olusacak yeni birey en kotu bireyler P1 ve P3 yerine yazilacak
    P11=P1;
    P22=P2;
    ii=width-(indis-1);
    for i=indis+1:1:(indis*2)
        C1(i)=P11(i);%korunacak kod kisimlari
        P1temp(ii)=P11(i);%korunacak kod k�s�mlari,gecici degiskenin sonuna atildi
        C2(i)=P22(i);
        P2temp(ii)=P22(i);
        ii=ii+1;  
    end

    j=1;
    for i=(indis*2)+1:1:width
        P1temp(j)=P11(i);%son kisim basa aktarildi
        P2temp(j)=P22(i);
        j=j+1;
    end

    for i=1:1:indis
        P1temp(j)=P11(i);%ilk kisim ortaya alindi
        P2temp(j)=P22(i);
        j=j+1;
    end

    jtemp=j;%alt dizi c�karmadan indis gecici degiskende tutulur,j=width-(indis-1)
    P1temp2=P1temp;
    P2temp2=P2temp;

    for i=1:width
        for k=0:indis-1
            if(P1temp2(i)== P2temp(j+k))
                P1temp2(i)=0;
            end
            %yeni s�ralanan 2.ebeveynden 1.ebeveynin alt dizisi cikarildi
            if(P2temp2(i)== P1temp(j+k))
                P2temp2(i)=0;
            end
            %ayn� islem diger yondede yapildi 
        end
    end

    jj=1;
    for i=1:width
        if(P1temp2(i)==0)
            continue
        end
        P1temp3(jj)=P1temp2(i);
        jj=jj+1;
    end

    jj=1;
    for i=1:width
        if(P2temp2(i)==0)
            continue
        end
        P2temp3(jj)=P2temp2(i);
        jj=jj+1;
    end
    %cikarilan kisimlar olmadan dizi duzenlendi

    jj=indis+1;
    for i=1:indis
        C1(i)=P2temp3(jj);
        C2(i)=P1temp3(jj);
        jj=jj+1;
    end
    jj=1;
    for i=(indis*2)+1:width
        C1(i)=P2temp3(jj);
        C2(i)=P1temp3(jj);
        jj=jj+1;
    end
    P1=C1;
    P3=C2;
    %yeni bireyler meydana getirildi
end

% Secilen dizi uzerinden caprazlama ve mutasyon islemleri gerceklestirildi, olusan yeni populasyon eski populasyon ile yer degistirildi
% stop=stop+1;
end%%Durdurma olcutu saglan�ncaya kadar devam edecek dongu sonu

%% 4-Gezgin Sat�c� icin En K�sa Yol Sonucu
disp('Gezgin sat�c� icin en k�sa yol=');
if (minFlag==1)
    disp(P1);
else if(minFlag==2)
        disp(P2);
    else
        disp(P3);
    end
end