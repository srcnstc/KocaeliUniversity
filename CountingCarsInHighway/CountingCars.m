clear all;close all;clc;
Obj = VideoReader('traffic.mj2'); % video yu okuma
%get(Obj); % command windowa �zellikleri bas
frameRate=get(Obj,'FrameRate');
vidFrames=read(Obj); % t�m video frame lerini oku
numFrames=get(Obj,'numberOfFrames'); % frame say�s�n� ald�m

up=0;    %yolun sol seridini sayan sayac
down=0;  %yolun sag seridini sayan sayac

formeasure=read(Obj, 1); %frame in y�kseklik ve genisligi tespiti icin yap�ld�(her video frame inin w x h degisecek)
measure=rgb2gray(formeasure); % 3.boyut(rgb) den kurtuldu 2 boyutlu w x h haline donusturuldu
[w,h]=size(measure);

sutunexgri=zeros([numFrames-1,h]);    %frame say�s�(sat�r),51. sat�rdan 59. sat�ra kadar toplan�p her b�r sutuna at�ld�(sol serit �c�n)
sutunexgri_2=zeros([numFrames-1,h]);  %sag serit icin


sutunexgrifark=zeros([numFrames-1,h]); 
sutunexgrifark_2=zeros([numFrames-1,h]);

sutunexgrifarknew=zeros([numFrames-1,1]); 
sutunexgrifarknew_2=zeros([numFrames-1,1]);

 for k = 1 : numFrames-1
    singleFrame = read(Obj, k);   
    gri=rgb2gray(singleFrame); % frameleri gri yap

       
        for n=1:100     %yolun sol seridi icin 51:59 a kadar sat�rlar toplanarak her b�r frame �c�n ornekleme olusuturuldu(n=h/2)
            for m=1:9
                     sutunexgri(k,n)=sutunexgri(k,n)+(gri((w/2)-10+m,n)/9);
            end
        end
       
        for n=101:h   %yolun sag seridi icin 51:59 a kadar sat�rlar toplanarak her b�r frame �c�n ornekleme olusuturuldu
            for m=1:9
                sutunexgri_2(k,n)=sutunexgri_2(k,n)+(gri((w/2)-10+m,n)/9);
            end
        end
    
    
    
   
    if(k>1 && k<119)        
        for u=1:numFrames-2
        sutunexgrifark(u,:)=sutunexgri(u+1,:)-sutunexgri(1,:);  %olusan matr�ste tum sat�rlar(frameler) arac olmayan referans frameden(1.sat�rdan) cikartilarak kucuk hareketler�n alg�lan�lmas� saglan�ld�
        sutunexgrifark_2(u,:)=sutunexgri_2(u+1,:)-sutunexgri_2(1,:);
        end
    end
    
    if(k>3)
          for i=1:numFrames-1
              if(abs(sutunexgrifark(i,50))>28)   %yolun sol seridi icin 28(thresold) dan buyuk ise arac gelm�st�r ve 1 bitl�k donusum yap�lm�st�r (i,j) j=w/4
                sutunexgrifarknew(i,1)=1;
              else
                 sutunexgrifarknew(i,1)=0;
              end
              if(abs(sutunexgrifark_2(i,130))>18) %yolun sag seridi icin 15(thresold) dan buyuk ise arac gelm�st�r ve 1 bitl�k donusum yap�lm�st�r  (i,j) j=3w/4
                    sutunexgrifarknew_2(i,1)=1;
              else
                    sutunexgrifarknew_2(i,1)=0;
              end
         end 
    end
    
            
            
   
      
    if(k>4)    % arac sayma �slem� sonuc olarak burada yap�lmaktad�r

        if(sutunexgrifarknew(k-4)==1 && sutunexgrifarknew(k-3)==0 )
            up=up+1;
        end
        if(sutunexgrifarknew_2(k-4)==1 && sutunexgrifarknew_2(k-3)==0 && sutunexgrifarknew_2(k-2)==0  && sutunexgrifarknew_2(k-1)==0)
            down=down+1;
        end

    end    
    position =  [1 50; h-20 50]; % [x y]
    value = [up down];
    singleFrame=insertText(singleFrame, position, value, 'AnchorPoint', 'LeftBottom');  %degerler goruntu �zerine basilacak
    singleFrame((3*w/4):(w-(w/10)),:,1)=255;  %ortadan k�rm�z� cizgi ile ayr�ld� (kal�nl�k,t�m sutunlar,red)
    figure(1),imshow(singleFrame); %tek bir pencerede hepsini video gibi bas
%   if(k>2)
%           figure(2), plot(sutunexgri(k-1,:));
%           figure(3), plot(sutunexgri(k-1,:));
%      end
%   pause
 end
