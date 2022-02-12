%110207011 SERCAN SATICI
clear all;close all;clc;
tic
Obj = VideoReader('shaky_car.avi'); % video yu okuma
% Obj = VideoReader('viplanedeparture.avi'); % video yu okuma
% Obj = VideoReader('viplane.avi'); % video yu okuma
% Obj = VideoReader('vipscenevideoclip.avi'); % video yu okuma
%get(Obj); % command windowa ?zellikleri bas
frameRate=get(Obj,'FrameRate');
vidFrames=read(Obj); % tum video frame lerini oku
numFrames=get(Obj,'numberOfFrames'); % frame say?s?n? ald?m
formeasure=read(Obj, 1); %frame in yukseklik ve genisligi tespiti icin yap?ld?
measure=rgb2gray(formeasure); % 3.boyut(rgb) den kurtuldu 2 boyutlu w x h haline donusturuldu
[satirsayisi,sutunsayisi]=size(measure);
Cy=zeros(numFrames-1,sutunsayisi,'double'); %satir toplami matrisi
Cx=zeros(numFrames-1,sutunsayisi,'double'); %sutun toplami matrisi
salinim=zeros(numFrames-1,2);%ilk sutun dikey diger sutun yatay salinimi tutacak
% table=zeros(sutunsayisi,sutunsayisi);
 for k = 1 : numFrames -1 
    singleFrame = read(Obj, k);%k.frame okundu
    gri=rgb2gray(singleFrame);%frameleri gri yap  
    %% 2 - Frame Signature Curves
    %Satir toplami
    for i=1:satirsayisi
         for j=1:sutunsayisi
             Cy(k,i)=Cy(k,i)+double(gri(i,j))/double(sutunsayisi);
             %Satir frame numarasini,sutun numarasi (i.) satir toplamini
             %temsil etmektedir
         end
    end
%   if(k>1)
%      figure(k),title('Cy-curves of two consecutive frames');
%      plot(Cy(k,:),'r');hold on;plot(Cy(k-1,:),'b');
%   end
%   pause
    
    %Sutun toplam?
    for i=1:sutunsayisi
         for j=1:satirsayisi
             Cx(k,i)=Cx(k,i)+gri(j,i)/satirsayisi;
             %Satir frame numarasini,sutun numarasi (i.) sutun toplamini
             %temsil etmektedir
         end
    end    
%   if(k>1)
%      figure(k),
%      plot(Cx(k,:),'r');title('Cx-curves of two consecutive frames');
%      axis([0,h,0,255]);hold on;plot(Cx(k-1,:),'b');
%   end
%   pause

     figure(1),imshow(gri); %tek bir pencerede hepsini video gibi bas  
    
 end
 
 %% DIKEY SALINIM
%% Dynamic Time Warping Algorithm
% Dist:t,r sinyalleri aras?ndaki normalize edilmemis uzaklik(Manhattan mesafesi)
% table:Mesafe matrisi tablosu
% k:normalizasyon katsayisi
% w:optimal yol
% t:t.frame icin Cx(s?tun toplam?)
% r:(t+1).frame icin Cx(s?tun toplam?)
% tw:t.frame egriligi
% rw:(t+1).frame egriligi
% cizdirme:cizim bayrag? (1:cizdir , 0:cizdirme)
%% 1 - t. frame ile (t+1).frame in dikgen oldugu cost(tablo olusturmak icin kullanilacak)matrisi olusumu
for cerceve=1:numFrames-2
r=Cy(cerceve,:);%t. cerceve
t=Cy(cerceve+1,:);%(t+1). cerceve
[row,M]=size(r); if (row > M) M=row; r=r'; end;
[row,N]=size(t); if (row > N) N=row; t=t'; end;
cost=(repmat(r',1,N)-repmat(t,M,1)).^2;%t?m degerleri r' olan 1xN matristen t?m degerleri t olan Mx1 matrisleri farki alindi
%% 2 - Tablo olusumu
table=zeros(size(cost));
table(1,1)=cost(1,1);
for m=2:M
    table(m,1)=cost(m,1)+table(m-1,1);
end
for n=2:N
    table(1,n)=cost(1,n)+table(1,n-1);
end
for m=2:M
    for n=2:N
         table(m,n)=cost(m,n)+min(table(m-1,n),min(table(m-1,n-1),table(m,n-1)));
        %Levenshtein mesafe tabanli(method olcekleme degerleri degistirilerek degistirilebilinir)
    end
end
%% 3 - Optimal Yol
Dist=table(M,N);%t,r sinyalleri arasindaki normalize edilmemis uzaklik(Manhattan mesafesi)
n=N;
m=M;
k=1;%normalizasyon faktoru
w=[M N];%optimal yol
while ((n+m)~=2)
    if (n-1)==0
        m=m-1;
    elseif (m-1)==0
        n=n-1;
    else 
      [values,number]=min([table(m-1,n),table(m,n-1),table(m-1,n-1)]);
      %values=belirtilen indislerdeki elemanlarin min.degeri
      %number=min.degerin bulundugu indis
      switch number
      case 1
        m=m-1;
      case 2
        n=n-1;
      case 3
        m=m-1;
        n=n-1;
      end
  end
    k=k+1;
    w=[m n; w];%tek parca halinde birlestirilerek optimal yol elde edildi
end

%% 4 - Egrilik Matrisleri Olusumu
XCurve=w(:,1);
YCurve=w(:,2);
dikeyhareketkestirimi=YCurve-XCurve;
%t anindaki frame ile (t+1).andaki frame DTW eslemesi
dikeysalinim=zeros(1,sutunsayisi);
for i=1:sutunsayisi
    if(dikeyhareketkestirimi(i,1)<=0)
        dikeyhareketkestirimi(i,1)=dikeyhareketkestirimi(i,1)+max(YCurve);%histogram hesabi yaparken indis degeri 0 veya negatif olmamasi icin yapilmis trick [max(YCurve)=320]
    end
    dikeysalinim(1,dikeyhareketkestirimi(i,1))=dikeysalinim(1,dikeyhareketkestirimi(i,1))+1; %histogram/peak noktasi dikey salinimi ifade edecektir 
end
[maximumvalue,index]=max(dikeysalinim);
if(index>150)
    index=index-max(YCurve);%eger kayma negatif yonde olursa max.degerin 320 ye tumleyeni yapilarak histogram hesabi yaparken indis degeri 0 veya negatif olmamasi icin yapilmis trick tolere edilecek
end
salinim(cerceve+1,1)=index;%ardisik iki frame arasi salinim 
end
rw=r(w(:,1));%t.frame egriligi
tw=t(w(:,2));%(t+1).frame egriligi

%Optimal yol X ve Y curveleri indis olarak ard?sik framelerde karsilik geldigi pixel degerleri egrilik matrislerinde tutuldu
%% 5 - Egrileri Cizdirme
cizdirme=0;
if cizdirme % cizdirme:cizim bayragi (1:cizdir , 0:cizdirme)
    figure('Name','DTW-Mesafe matrisi tablosu ve Optimal yol','NumberTitle','off');
    main1=subplot('position',[0.19 0.19 0.67 0.79]);
    image(table); %matristen imge olusturdu
    cmap=contrast(table);%imgenin contrast? pekistirtirildi
    imagesc(table); %mevcut renk haritasi goruntu verilerini olceklenip goruntulendi
    colormap(cmap); %gri tonlarinda renk haritasi olusturuldu,imagesc(table);
    hold on;
    x=w(:,1); y=w(:,2); %t ve (t+1). anlardaki frame egrilikleri
    ind=find(x==1); x(ind)=1+0.2; %X-Curve vektorunun 1 olan elamanlari 1+0.2 ye esitlendi
    ind=find(x==M); x(ind)=M-0.2; %X-Curve vektorunun M(frame sayisi) olan elemani M-0.2 ye esitlendi
    ind=find(y==1); y(ind)=1+0.2; %Y-Curve vektorunun 1 olan elamanlari 1+0.2 ye esitlendi
    ind=find(y==N); y(ind)=N-0.2; %Y-Curve vektorunun N(frame sayisi) olan elamanlari N-0.2 ye esitlendi
    plot(y,x,'-w','LineWidth',1); %optimal yol egrisi ekrana basildi
    hold off;
    axis([1 N 1 M]);
    set(main1, 'FontSize',7, 'XTickLabel','', 'YTickLabel','');
    colorb1=subplot('position',[0.88 0.19 0.05 0.79]);
    nticks=8;
    ticks=floor(1:(size(cmap,1)-1)/(nticks-1):size(cmap,1));
    mx=max(max(table)); %tablonun max elemani
    mn=min(min(table)); %tablonun min elemani
    ticklabels=floor(mn:(mx-mn)/(nticks-1):mx);
    colorbar(colorb1);
    set(colorb1, 'FontSize',7, 'YTick',ticks, 'YTickLabel',ticklabels);
    set(get(colorb1,'YLabel'), 'String','Distance', 'Rotation',-90, 'FontSize',7, 'VerticalAlignment','bottom');  
    left1=subplot('position',[0.07 0.19 0.10 0.79]);
    plot(r,M:-1:1,'-b'); %(t+1).frame belirtilen pozisyona basildi(sol k?s?m)
    set(left1, 'YTick',mod(M,10):10:M, 'YTickLabel',10*rem(M,10):-10:0)
    axis([min(r) 1.1*max(r) 1 M]);
    set(left1, 'FontSize',7);
    set(get(left1,'YLabel'), 'String','Sutun Toplami', 'FontSize',7, 'Rotation',-90, 'VerticalAlignment','cap');
    set(get(left1,'XLabel'), 'String','Genlik', 'FontSize',6, 'VerticalAlignment','cap');
    bottom1=subplot('position',[0.19 0.07 0.67 0.10]);
    plot(t,'-r'); %(t).frame belirtilen pozisyona basildi(alt kisim)
    axis([1 N min(t) 1.1*max(t)]);
    set(bottom1, 'FontSize',7, 'YAxisLocation','right');
    set(get(bottom1,'XLabel'), 'String','Sutun Toplami', 'FontSize',7, 'VerticalAlignment','middle');
    set(get(bottom1,'YLabel'), 'String','Genlik', 'Rotation',-90, 'FontSize',6, 'VerticalAlignment','bottom');
    figure('Name','DTW - Warped signals', 'NumberTitle','off');
    subplot(1,2,1);
    set(gca, 'FontSize',7);
    hold on;
    plot(r,'-bx');
    plot(t,':r.');
    hold off;
    axis([1 max(M,N) min(min(r),min(t)) 1.1*max(max(r),max(t))]);
    grid;
    legend('Signal 1','Signal 2');
    title('Orjinal Sinyaller');
    xlabel('Sutun Toplami');
    ylabel('Genlik');
    subplot(1,2,2);
    set(gca, 'FontSize',7);
    hold on;
    plot(rw,'-bx');
    plot(tw,':r.');
    hold off;
    axis([1 k min(min([rw; tw])) 1.1*max(max([rw; tw]))]);
    grid;
    legend('Signal 1','Signal 2');
    title('Warped Signals');
    xlabel('Sutun Toplami');
    ylabel('Genlik');  
end

 
%% YATAY SALINIM 
%% Dynamic Time Warping Algorithm
% Dist:t,r sinyalleri aras?ndaki normalize edilmemis uzaklik(Manhattan mesafesi)
% table:Mesafe matrisi tablosu
% k:normalizasyon katsayisi
% w:optimal yol
% t:t.frame icin Cx(s?tun toplam?)
% r:(t+1).frame icin Cx(s?tun toplam?)
% tw:t.frame egriligi
% rw:(t+1).frame egriligi
% cizdirme:cizim bayragi (1:cizdir , 0:cizdirme)
%% 1 - t. frame ile (t+1).frame in dikgen oldugu cost(tablo olusturmak icin kullanilacak)matrisi olusumu
for cerceve=1:numFrames-2
r=Cx(cerceve,:);%t.andaki cerceve
t=Cx(cerceve+1,:);%(t+1).anindaki cerceve
[row,M]=size(r); if (row > M) M=row; r=r'; end;
[row,N]=size(t); if (row > N) N=row; t=t'; end;
cost=(repmat(r',1,N)-repmat(t,M,1)).^2;%tum degerleri r' olan 1xN matristen tum degerleri t olan Mx1 matrisleri farki alindi
%% 2 - Tablo olusumu
table=zeros(size(cost));
table(1,1)=cost(1,1);
for m=2:M
    table(m,1)=cost(m,1)+table(m-1,1);
end
for n=2:N
    table(1,n)=cost(1,n)+table(1,n-1);
end
for m=2:M
    for n=2:N
         table(m,n)=cost(m,n)+min(table(m-1,n),min(table(m-1,n-1),table(m,n-1)));
        %Levenshtein mesafe tabanli(method olcekleme degerleri degistirilerek degistirilebilinir)
    end
end
%% 3 - Optimal Yol
Dist=table(M,N);%t,r sinyalleri arasindaki normalize edilmemis uzaklik(Manhattan mesafesi)
n=N;
m=M;
k=1;%normalizasyon faktoru
w=[M N];%optimal yol
while ((n+m)~=2)
    if (n-1)==0
        m=m-1;
    elseif (m-1)==0
        n=n-1;
    else 
      [values,number]=min([table(m-1,n),table(m,n-1),table(m-1,n-1)]);
      %values=belirtilen indislerdeki elemanlarin min.degeri
      %number=min.degerin bulundugu indis
      switch number
      case 1
        m=m-1;
      case 2
        n=n-1;
      case 3
        m=m-1;
        n=n-1;
      end
  end
    k=k+1;
    w=[m n; w];%tek parca halinde birlestirilerek optimal yol elde edildi
end

%% 4 - Egrilik Matrisleri Olusumu
XCurve=w(:,1);
YCurve=w(:,2);
yatayhareketkestirimi=YCurve-XCurve;
%t anindaki frame ile (t+1).andaki frame DTW eslemesi
yataysalinim=zeros(1,sutunsayisi);
for i=1:sutunsayisi
    if(yatayhareketkestirimi(i,1)<=0)
        yatayhareketkestirimi(i,1)=yatayhareketkestirimi(i,1)+max(YCurve);%histogram hesab? yaparken indis degeri 0 veya negatif olmamasi icin yapilmis trick
    end
    yataysalinim(1,yatayhareketkestirimi(i,1))=yataysalinim(1,yatayhareketkestirimi(i,1))+1; %histogram/peak noktasi yatay salinimi ifade edecektir 
end
[maximumvalue,index]=max(yataysalinim);
if(index>150)
    index=index-max(YCurve);%eger kayma negatif yonde olursa max.degerin 320 ye tumleyeni yapilarak histogram hesabi yaparken indis degeri 0 veya negatif olmamasi icin yapilmis trick tolere edilecek
end
salinim(cerceve+1,2)=index;%ardisik iki frame arasi salinim 
end
rw=r(w(:,1));%t.frame egriligi
tw=t(w(:,2));%(t+1).frame egriligi

%Optimal yol X ve Y curveleri indis olarak ard?sik framelerde karsilik geldigi pixel degerleri egrilik matrislerinde tutuldu
%% 5 - Egrileri Cizdirme
cizdirme=1;
if cizdirme % cizdirme:cizim bayragi (1:cizdir , 0:cizdirme)
    figure('Name','DTW-Mesafe matrisi tablosu ve Optimal yol','NumberTitle','off');
    main1=subplot('position',[0.19 0.19 0.67 0.79]);
    image(table); %matristen imge olusturdu
    cmap=contrast(table);%imgenin contrasti pekistirtirildi
    imagesc(table); %mevcut renk haritas? goruntu verilerini olceklenip goruntulendi
    colormap(cmap); %gri tonlar?nda renk haritasi olusturuldu,imagesc(table);
    hold on;
    x=w(:,1); y=w(:,2); %t ve (t+1). anlardaki frame egrilikleri
    ind=find(x==1); x(ind)=1+0.2; %X-Curve vektorunun 1 olan elamanlari 1+0.2 ye esitlendi
    ind=find(x==M); x(ind)=M-0.2; %X-Curve vektorunun M(frame sayisi) olan elemani M-0.2 ye esitlendi
    ind=find(y==1); y(ind)=1+0.2; %Y-Curve vektorunun 1 olan elamanlari 1+0.2 ye esitlendi
    ind=find(y==N); y(ind)=N-0.2; %Y-Curve vektorunun N(frame sayisi) olan elamanlari N-0.2 ye esitlendi
    plot(y,x,'-w','LineWidth',1); %optimal yol egrisi ekrana basildi
    hold off;
    axis([1 N 1 M]);
    set(main1, 'FontSize',7, 'XTickLabel','', 'YTickLabel','');
    colorb1=subplot('position',[0.88 0.19 0.05 0.79]);
    nticks=8;
    ticks=floor(1:(size(cmap,1)-1)/(nticks-1):size(cmap,1));
    mx=max(max(table)); %tablonun max elemani
    mn=min(min(table)); %tablonun min elemani
    ticklabels=floor(mn:(mx-mn)/(nticks-1):mx);
    colorbar(colorb1);
    set(colorb1, 'FontSize',7, 'YTick',ticks, 'YTickLabel',ticklabels);
    set(get(colorb1,'YLabel'), 'String','Distance', 'Rotation',-90, 'FontSize',7, 'VerticalAlignment','bottom');  
    left1=subplot('position',[0.07 0.19 0.10 0.79]);
    plot(r,M:-1:1,'-b'); %(t+1).frame belirtilen pozisyona basildi(sol kisim)
    set(left1, 'YTick',mod(M,10):10:M, 'YTickLabel',10*rem(M,10):-10:0)
    axis([min(r) 1.1*max(r) 1 M]);
    set(left1, 'FontSize',7);
    set(get(left1,'YLabel'), 'String','Sutun Toplami', 'FontSize',7, 'Rotation',-90, 'VerticalAlignment','cap');
    set(get(left1,'XLabel'), 'String','Genlik', 'FontSize',6, 'VerticalAlignment','cap');
    bottom1=subplot('position',[0.19 0.07 0.67 0.10]);
    plot(t,'-r'); %(t).frame belirtilen pozisyona basildi(alt kisim)
    axis([1 N min(t) 1.1*max(t)]);
    set(bottom1, 'FontSize',7, 'YAxisLocation','right');
    set(get(bottom1,'XLabel'), 'String','Sutun Toplami', 'FontSize',7, 'VerticalAlignment','middle');
    set(get(bottom1,'YLabel'), 'String','Genlik', 'Rotation',-90, 'FontSize',6, 'VerticalAlignment','bottom');
    figure('Name','DTW - Warped signals', 'NumberTitle','off');
    subplot(1,2,1);
    set(gca, 'FontSize',7);
    hold on;
    plot(r,'-bx');
    plot(t,':r.');
    hold off;
    axis([1 max(M,N) min(min(r),min(t)) 1.1*max(max(r),max(t))]);
    grid;
    legend('Signal 1','Signal 2');
    title('Orjinal Sinyaller');
    xlabel('Sutun Toplami');
    ylabel('Genlik');
    subplot(1,2,2);
    set(gca, 'FontSize',7);
    hold on;
    plot(rw,'-bx');
    plot(tw,':r.');
    hold off;
    axis([1 k min(min([rw; tw])) 1.1*max(max([rw; tw]))]);
    grid;
    legend('Signal 1','Signal 2');
    title('Warped Signals');
    xlabel('Sutun Toplami');
    ylabel('Genlik');  
end
salinimcdf(:,1)=cumsum(salinim(:,1));
salinimcdf(:,2)=cumsum(salinim(:,2));
tolerasyon=salinimcdf*-1; %salinimi tolere etmek icin negatifi tolerasyon matrisinde tutuldu
%% 6-Video Stabilizasyonu
for k = 1 : numFrames-1 
    singleFrame = read(Obj, k);%t+1.anindaki frame 
    gri=rgb2gray(singleFrame);%frameleri gri yap
    stabil = circshift(gri,[tolerasyon(k,1) tolerasyon(k,2)]); %dairesel kaydirma yapildi        
        %Dikey salinim tolerasyonu
        if(tolerasyon(k,1)>0)
            stabil(1:tolerasyon(k,1),:)=0;%Eger tolerasyon pozitif yonde ise alt taraf k?rp?larak ust k?s?m siyah olacak
        else
            stabil(satirsayisi+tolerasyon(k,1):satirsayisi,:)=0;%negatif ise tam tersi gerceklesecek
        end
        %Yatay salinim tolerasyonu
        if(tolerasyon(k,2)>0)
            stabil(:,1:tolerasyon(k,2))=0;
        else
            stabil(:,sutunsayisi+tolerasyon(k,2):sutunsayisi)=0;
        end
        figure(1),imshow(stabil); %tek bir pencerede hepsini video gibi bas
%         pause
end  
toc    