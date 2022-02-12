%110207011 SERCAN SATICI
%110207004  ADEM ERTEM
voice=wavread('test.wav');%test dosyasýný oku
x=voice;%test dosayasýný x degiskeninde sakla
x=x';%transpozunu al
x=x(1,:);%ilk satýrýný al
x=x';%transpozunu al (ses dosyasinin ilk sutunu)
y1=wavread('one.wav');%1 sesini y1 de tut
y1=y1';
y1=y1(1,:);
y1=y1';%1 sesinin ilk sutunu
z1=xcorr(x,y1);%test sesiyle korelasyon
m1=max(z1);%korelasyonu sonucunun max degeri
l1=length(z1);%korelasyon sonucu uzunlugu
t1=-((l1-1)/2):1:((l1-1)/2);%plot icin zaman degiskeni
t1=t1';
%subplot(3,2,1);
plot(t1,z1);%test ile 1 sesi korelasyon grafigi
y2=wavread('two.wav');%2 sesini y2 de tut
y2=y2';
y2=y2(1,:);
y2=y2';%2 sesinin ilk sutunu
z2=xcorr(x,y2);%test sesiyle korelasyon
m2=max(z2);%korelasyonu sonucunun max degeri
l2=length(z2);%korelasyon sonucu uzunlugu
t2=-((l2-1)/2):1:((l2-1)/2);%plot icin zaman degiskeni
t2=t2';
%subplot(3,2,2);
figure
plot(t2,z2);%test ile 2 sesi korelasyon grafigi
y3=wavread('three.wav');%3 sesi
y3=y3';
y3=y3(1,:);
y3=y3';
z3=xcorr(x,y3);
m3=max(z3);
l3=length(z3);
t3=-((l3-1)/2):1:((l3-1)/2);
t3=t3';
%subplot(3,2,3);
figure
plot(t3,z3);
y4=wavread('four.wav');%4 sesi
y4=y4';
y4=y4(1,:);
y4=y4';
z4=xcorr(x,y4);
m4=max(z4);
l4=length(z4);
t4=-((l4-1)/2):1:((l4-1)/2);
t4=t4';
%subplot(3,2,4);
figure
plot(t4,z4);
y5=wavread('five.wav');%5 sesi
y5=y5';
y5=y5(1,:);
y5=y5';
z5=xcorr(x,y5);
m5=max(z5);
l5=length(z5);
t5=-((l5-1)/2):1:((l5-1)/2);
t5=t5';
%subplot(3,2,5);
figure
plot(t5,z5);
m6=300;
a=[m1 m2 m3 m4 m5 m6];%test ile korelasyonun maximum degerleri
m=max(a);%test ile korelasyonun maximum degerlerinin en buyugu
h=wavread('allow.wav'); %allow sesi
%test ile korelasyonun maximum degerlerinin en buyugunun en yakin oldugu
%korelasyon sonucu test sesini verecektir(hangisi ise onu calacaktýr)
if m<=m1
    soundsc(wavread('one.wav'),50000) %test sesi 1 dir
        soundsc(h,50000)%allow
elseif m<=m2
    soundsc(wavread('two.wav'),50000)%test sesi 2 dir
        soundsc(h,50000)
elseif m<=m3
    soundsc(wavread('three.wav'),50000)%test sesi 3 tur
        soundsc(h,50000)
elseif m<=m4
    soundsc(wavread('four.wav'),50000)%test sesi 4 tur
        soundsc(h,50000)
elseif m<m5
    soundsc(wavread('five.wav'),50000)%test sesi 5 tir
        soundsc(h,50000)
else soundsc(wavread('denied.wav'),50000)%test sesi tanýtýlmamýs(var olmayan) sestir
   
end