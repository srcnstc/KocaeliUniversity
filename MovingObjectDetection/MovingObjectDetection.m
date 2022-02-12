% 110207011 Sercan SATICI-120207064 Ilker INANC-120207001 Duygu SAHÝN
clear all;close all;clc;
% Obj = VideoReader('viptrain.avi'); % video yu okuma
Obj = VideoReader('vipmen.avi'); % video yu okuma
%get(Obj); % command windowa özellikleri bas
frameRate=get(Obj,'FrameRate');
vidFrames=read(Obj); % tüm video frame lerini oku
numFrames=get(Obj,'numberOfFrames'); % frame sayýsýný aldým
formeasure=read(Obj, 1); %frame in yükseklik ve genisligi tespiti icin yapýldý
measure=rgb2gray(formeasure); % 3.boyut(rgb) den kurtuldu 2 boyutlu w x h haline donusturuldu
[w,h]=size(measure); %genislik/yükseklik alindi
thresold=50; %Esikleme degeri
sedisk = strel('disk',5); %uygun disk yapisi tasarlandi
Backgroundframe=read(Obj,1);%arkaplan cercevesi(referans frame)
gri_background=rgb2gray(Backgroundframe);%arkaplan cercevesi iki boyutlu hale getirildi
alpha = 0.5;%Arkaplan güncellemesi icin kullanilacak parametre(learning rate)
N=10;%N defa eylemsizlik için arkaplan güncellenecek
KI=0;%Key index (eylemsizlik)
BG=zeros(1,numFrames);%Background data
bg=1; %BG dizisi indis göstergesi
toplam=0;
BC=zeros(w,h);%Background Change Buffer
BCM=zeros(w,h);%Background Change Mask
 for k = 1 : numFrames -1 
    singleFrame = read(Obj, k);%t.anýndaki frame
    singleFrame_up = read(Obj, k+1);%t+1 anýndaki frame 
    gri=rgb2gray(singleFrame);%frameleri gri yap  
    gri_up=rgb2gray(singleFrame_up);%frameleri gri yap
    
    %% A - Frame Diffrence Model(FDM)
    farkframe=(double(gri)-double(gri_up)); %ardisik framelerin farki alindi
    for i=1:w
        for j=1:h
            if(farkframe(i,j)>thresold)    
                farkframe(i,j)=1;   %piksel hareket etmektedir(moving)
            else                      %eþikleme yapildi
                farkframe(i,j)=0;     %piksel duragandir(stationary)  
            end
        end
    end   
    farkframeerode=imerode(farkframe,sedisk);%nesneler arasý asindirma yapildi
    boundaryframeFDM=farkframe-farkframeerode;%Sýnýr cikartma islemi yapildi
%     farkframeclose=imclose(farkframe,sedisk);%nesneler arasý boþluk kapatýldý
    
%     %% B - Background Subtraction Model(BSM)
%     differenceframe=abs(double(gri)-double(gri_background));%framelerin referans frameden farklari alindi
%     for i=1:w
%         for j=1:h
%             if(differenceframe(i,j)>thresold)    
%                 differenceframe(i,j)=gri_background(i,j);%piksel hareket etmektedir(moving)
%             else                      %eþikleme yapildi
%                 differenceframe(i,j)=0;     %piksel duragandir(stationary)  
%             end
%         end
%     end   
% 
%      differenceframeerode=imerode(differenceframe,sedisk);%nesneler arasý asindirma yapildi
%      boundaryframeBSM=differenceframe-differenceframeerode;%Sýnýr cikartma islemi yapildi
 
%     %% C - Adaptive Background Subtraction Model(ABSM)
%     if(k>1)
%         gri_background=(1-alpha)* gri + alpha * gri_background;%background güncellemesi(adapting)
%     end
%     differenceframe=abs(double(gri)-double(gri_background));%framelerin referans frameden farklari alindi
%     for i=1:w
%         for j=1:h
%             if(differenceframe(i,j)>thresold)    
%                 differenceframe(i,j)=gri_background(i,j);%piksel hareket etmektedir(moving)
%             else                      %eþikleme yapildi
%                 differenceframe(i,j)=0;     %piksel duragandir(stationary)  
%             end
%         end
%     end       
%      differenceframeerode=imerode(differenceframe,sedisk);%nesneler arasý asindirma yapildi
%      boundaryframeABSM=differenceframe-differenceframeerode;%Sýnýr cikartma islemi yapildi

%     %% D - Block Based Background Subtraction Model(BBBSM)


%% PROPOSED METHOD/Construction of Background
        for i=1:w
            for j=1:h
                toplam=toplam+farkframe(i,j); %matrisi toplami hesaplandi
            end
        end
        if(toplam < sqrt((w*h)/2)) %sqrt((w*h)/2) ardisik frameler icin hareket kestirimi thresold degeri
            KI=KI+1;
        else
            KI=0;
        end
        toplam=0;
        if(KI==N)
            Backgroundframe=read(Obj,k-1);
            BG(1,bg)=k-1; %BG indis degerindeki frame sirasiyla güncel backgroundý temsil etmektedir
            bg=bg+1;
            KI=0;
        end
        backgroundframe=rgb2gray(Backgroundframe);
%% Background Change mask
BC=abs(double(gri)-double(backgroundframe)); %Arkaplan deðiþim buffer
    for i=1:w
        for j=1:h
            if(BC(i,j)>thresold)    
                BCM(i,j)=1;   %piksel hareket etmektedir(moving)
            else                      %eþikleme yapildi
                BCM(i,j)=0;     %piksel duragandir(stationary)  
            end
        end
    end   



%% %Videolari ekrana basma
%     figure(1),imshow(singleFrame); %Orjinal video 
%     figure(1),imshow(gri); %2D video
%     figure(1),imshow(boundaryframeFDM); %FDM video,FDM kolayca uygulanýp daha az hesaplama gerektirsede gürültüye cok duyarli/Three-Frame Differencing veya Persistent Frame Differencing denenebilir
%     figure(1),imshow(boundaryframeBSM); %BSM arkaplan goruntusu max.sayida sabit pixel degerlerini icermezse gurultu icerir ve nesneler tespit edilemez
%     figure(1),imshow(boundaryframeABSM); %ABSM arkaplan goruntusunu olusturmak icin cok zaman almaktadir ve parlaklýk ile kamera hareketine karsi daha tepkisel olmustur
    figure(1),imshow(BCM); %Background Change Mask ile nesne cok yavas veya gecici duragan iken FDM de olusan problemler giderildi




    
 end