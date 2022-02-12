%110207011 SERCAN SATICI
clear all;close all;clc;
fileName=sprintf('C:\\Dosyalarým\\Electronics and Com. Engineering\\Optimizasyon Tekniklerine Giriþ\\Ödev\\ilmesafe');%dosya ismi
ilmesafeleri=xlsread(fileName);%il mesafelerini iceren .xls dosyasi okundu(http://www.kgm.gov.tr/)
for i=1:81
    for j=1:81
        if(i==j)
            ilmesafeleri(i,j)=0;%NaN ifadeleri(ayný ilin kendine uzaklýgi) 0 yapildi
        end
    end
end
mutasyonorani=1/3;%mutasyon orani yaklasik %33 olarak belirlendi
% stop=0;%durdurma olcutu
minMesafe=100000;%durdurma olcutu
width=81;%dizi uzunlugu
indis=width*mutasyonorani;%27
%% 1-Baslangic populasyonu olusturulmasý
PopulasyonBuyuklugu=81;
P1=randperm(81,PopulasyonBuyuklugu);%81 boyutlu [1 81] arasýnda tekrarsiz farklý  sayýlar uret
% ilknokta=P1(1);%baslangic noktasi
% sonnokta=ilknokta;%son nokta olarak baslangýc noktasi belirlendi 
% P1(1,82)=sonnokta;%populasyonun son noktasina baslangýc noktasi eklendi

P2=randperm(81,PopulasyonBuyuklugu);%81 boyutlu [1 81] arasýnda tekrarsiz farklý  sayýlar uret
% ilknokta=P2(1);%baslangic noktasi
% sonnokta=ilknokta;%son nokta olarak baslangýc noktasi belirlendi 
% P2(1,82)=sonnokta;%populasyonun son noktasina baslangýc noktasi eklendi

P3=randperm(81,PopulasyonBuyuklugu);%81 boyutlu [1 81] arasýnda tekrarsiz farklý  sayýlar uret
% ilknokta=P3(1);%baslangic noktasi
% sonnokta=ilknokta;%son nokta olarak baslangýc noktasi belirlendi 
% P3(1,82)=sonnokta;%populasyonun son noktasina baslangýc noktasi eklendi

% P4=randperm(81,PopulasyonBuyuklugu);%81 boyutlu [1 81] arasýnda tekrarsiz farklý  sayýlar uret
% ilknokta=P4(1);%baslangic noktasi
% sonnokta=ilknokta;%son nokta olarak baslangýc noktasi belirlendi 
% P4(1,82)=sonnokta;%populasyonun son noktasina baslangýc noktasi eklendi

% P5=randperm(81,PopulasyonBuyuklugu);%81 boyutlu [1 81] arasýnda tekrarsiz farklý  sayýlar uret
% ilknokta=P5(1);%baslangic noktasi
% sonnokta=ilknokta;%son nokta olarak baslangýc noktasi belirlendi 
% P5(1,82)=sonnokta;%populasyonun son noktasina baslangýc noktasi eklendi

%Tum olasi cozumlerden bir grup cozum dizi olarak kodlandi

while(minMesafe>55000)%Durdurma olcutu saglanýncaya kadar devam edecek dongu baslangici
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
%BubbleSort algoritmasý ile mesafeler kucukten buyuge sýralandi en uzun mesafeli, yani en kötü bireyi eleyeceðiz
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

%Sýra Temelli Caprazlama

% 3!=6 farklý kombinasyon ile caprazlanacak iki bireyin yerine gelecek iki bireylerin tespiti yapýlacak
%Kombinasyon(1)
if(maxFlag==1 && minFlag==2)%P2 ve P3 caprazlanacak olusacak yeni birey en kotu bireyler P1 ve P3 yerine yazilacak
    P11=P2;
    P22=P3;
    ii=width-(indis-1);
    for i=indis+1:1:(indis*2)
        C1(i)=P11(i);%korunacak kod kisimlari
        P1temp(ii)=P11(i);%korunacak kod kýsýmlari,gecici degiskenin sonuna atildi
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

    jtemp=j;%alt dizi cýkarmadan indis gecici degiskende tutulur,j=width-(indis-1)
    P1temp2=P1temp;
    P2temp2=P2temp;

    for i=1:width
        for k=0:indis-1
            if(P1temp2(i)== P2temp(j+k))
                P1temp2(i)=0;%'*'
            end
            %yeni sýralanan 2.ebeveynden 1.ebeveynin alt dizisi cikarildi
            if(P2temp2(i)== P1temp(j+k))
                P2temp2(i)=0;%'*'
            end
            %ayný islem diger yondede yapildi 
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
        P1temp(ii)=P11(i);%korunacak kod kýsýmlari,gecici degiskenin sonuna atildi
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

    jtemp=j;%alt dizi cýkarmadan indis gecici degiskende tutulur,j=width-(indis-1)
    P1temp2=P1temp;
    P2temp2=P2temp;

    for i=1:width
        for k=0:indis-1
            if(P1temp2(i)== P2temp(j+k))
                P1temp2(i)=0;
            end
            %yeni sýralanan 2.ebeveynden 1.ebeveynin alt dizisi cikarildi
            if(P2temp2(i)== P1temp(j+k))
                P2temp2(i)=0;
            end
            %ayný islem diger yondede yapildi 
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
        P1temp(ii)=P11(i);%korunacak kod kýsýmlari,gecici degiskenin sonuna atildi
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

    jtemp=j;%alt dizi cýkarmadan indis gecici degiskende tutulur,j=width-(indis-1)
    P1temp2=P1temp;
    P2temp2=P2temp;

    for i=1:width
        for k=0:indis-1
            if(P1temp2(i)== P2temp(j+k))
                P1temp2(i)=0;
            end
            %yeni sýralanan 2.ebeveynden 1.ebeveynin alt dizisi cikarildi
            if(P2temp2(i)== P1temp(j+k))
                P2temp2(i)=0;
            end
            %ayný islem diger yondede yapildi 
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
        P1temp(ii)=P11(i);%korunacak kod kýsýmlari,gecici degiskenin sonuna atildi
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

    jtemp=j;%alt dizi cýkarmadan indis gecici degiskende tutulur,j=width-(indis-1)
    P1temp2=P1temp;
    P2temp2=P2temp;

    for i=1:width
        for k=0:indis-1
            if(P1temp2(i)== P2temp(j+k))
                P1temp2(i)=0;
            end
            %yeni sýralanan 2.ebeveynden 1.ebeveynin alt dizisi cikarildi
            if(P2temp2(i)== P1temp(j+k))
                P2temp2(i)=0;
            end
            %ayný islem diger yondede yapildi 
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
        P1temp(ii)=P11(i);%korunacak kod kýsýmlari,gecici degiskenin sonuna atildi
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

    jtemp=j;%alt dizi cýkarmadan indis gecici degiskende tutulur,j=width-(indis-1)
    P1temp2=P1temp;
    P2temp2=P2temp;

    for i=1:width
        for k=0:indis-1
            if(P1temp2(i)== P2temp(j+k))
                P1temp2(i)=0;
            end
            %yeni sýralanan 2.ebeveynden 1.ebeveynin alt dizisi cikarildi
            if(P2temp2(i)== P1temp(j+k))
                P2temp2(i)=0;
            end
            %ayný islem diger yondede yapildi 
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
        P1temp(ii)=P11(i);%korunacak kod kýsýmlari,gecici degiskenin sonuna atildi
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

    jtemp=j;%alt dizi cýkarmadan indis gecici degiskende tutulur,j=width-(indis-1)
    P1temp2=P1temp;
    P2temp2=P2temp;

    for i=1:width
        for k=0:indis-1
            if(P1temp2(i)== P2temp(j+k))
                P1temp2(i)=0;
            end
            %yeni sýralanan 2.ebeveynden 1.ebeveynin alt dizisi cikarildi
            if(P2temp2(i)== P1temp(j+k))
                P2temp2(i)=0;
            end
            %ayný islem diger yondede yapildi 
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
end%%Durdurma olcutu saglanýncaya kadar devam edecek dongu sonu

%% 4-Gezgin Satýcý icin En Kýsa Yol Sonucu
disp('Gezgin satýcý icin en kýsa yol=');
if (minFlag==1)
    disp(P1);
else if(minFlag==2)
        disp(P2);
    else
        disp(P3);
    end
end