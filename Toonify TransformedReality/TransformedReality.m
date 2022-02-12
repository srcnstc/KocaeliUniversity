clear all ; close all ; clc;
I = imread('toonifys.bmp');
I3=I;
figure, imshow(I);


for i=1:size(I3,1) %% color partition
    for j=1:size(I3,2)
        for k=1:size(I3,3)
            if (I3(i,j,k)<= 63)
                I3(i,j,k)=32;
            end
            if (I3(i,j,k)>= 64 && I3(i,j,k)<= 127)
                I3(i,j,k)=96;
            end
            if (I3(i,j,k)>= 128 && I3(i,j,k)<= 191)
                I3(i,j,k)=160;
            end
            if (I3(i,j,k)>= 192 && I3(i,j,k)<= 255)
                I3(i,j,k)=224;
            end
        end
    end
end


R = I3(:,:,1); %% median filter
G = I3(:,:,2);
B = I3(:,:,3);
I4(:,:,1) = medfilt2(R);
I4(:,:,2) = medfilt2(G);
I4(:,:,3) = medfilt2(B);


 R = I4(:,:,1); %% image adjusting
 G = I4(:,:,2);
 B = I4(:,:,3);
 J(:,:,1) = imadjust(R);  %goruntuyu kalitelestirmek icin makaleden bagimsiz olarak eklendi
 J(:,:,2) = imadjust(G);
 J(:,:,3) = imadjust(B);
 

 
Br = edge(J(:,:,1),'canny',0.1); %% edge filters
Bg = edge(J(:,:,2),'canny',0.1);
Bb = edge(J(:,:,3),'canny',0.1);

for i=1:size(Br,1)
    for j=1:size(Br,2)
        if((Br(i,j)==1 && Bg(i,j)==1) || (Bb(i,j)==1 && Bg(i,j)==1) || (Br(i,j)==1 && Bb(i,j)==1))
            J(i,j,:)= 0;
        end
    end
end


figure, imshow(J);

        
        