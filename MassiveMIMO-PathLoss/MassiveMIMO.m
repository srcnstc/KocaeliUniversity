clear all;close all;clc;
%% Massive MIMO kapasite kazancý
M=input('Omnidirectinal anten sayýsýný giriniz=');%6400
Pt=input('Ýletilen toplam gücü giriniz[W]=');%120
f=input('Frekans deðerini giriniz[Hz]=');%1900*10^6
EachAntenna=Pt/M;
disp('Her bir anten gücü[mW]=');
disp(EachAntenna*10^3);
c=3*10^8;%isik hizi
lambda=c/f;
TotalFormFactor=(M*(lambda/2)^2);
disp('Toplam form faktörü[m^2]');
disp(TotalFormFactor);
R=input('yarýcapi giriniz[m]=')%6000
Gt=100000;%60dB in lineer ifadesi Gt,Gr =60 dB olsun
Gr=100000;%60dB in lineer ifadesi
Pr=Pt*(lambda./(4*pi*R)).^2*Gt*Gr;%the power of the recieved wave[W]
disp('Terminal kazancý[dB]')
disp(10*log10(Pr));

%% COST231-Hata Source=https://en.wikipedia.org/wiki/COST_Hata_model
hb=input('Anten dizi yüksekligini giriniz[m]=');%radiation centerline of the BTS transmitter[m] 30
hm=input('Terminal yuksekligini giriniz[m]=');%height of the mobile receive antenna[m] 5
r=input('Yarýcap ifadesini guncelleyiniz[km]=');%great circle distance between base station and mobile[km] 1
% n=input('Kayýp ussunu(path loss exponent) giriniz=');
fc=1900;
C=0;
ahm=(1.1*log10(fc)-0.7)*hm-(1.56*log10(fc)-0.8);
L=46.3+33.9*log10(fc)-13.82*log10(hb)-ahm+(44.9-6.55*log10(hb))*log10(r)+C;
disp('Yol kaybi(Path Loss)[dB]');
disp(L);