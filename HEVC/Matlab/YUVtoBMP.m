%110207011
clear all;close all;clc;
%YUV to BMP

%% YUV dosyasinin okunmasi
% function [Y,U,V]=yuvread(filename,st,n)
filename=('C:\Users\CASPER\Documents\MATLAB\football_cif.yuv');%dosya adi
% filename=('C:\Users\CASPER\Documents\MATLAB\stefan_cif.yuv');%dosya adi
% filename=('C:\Users\CASPER\Documents\MATLAB\BasketballPass.yuv');%dosya adi
st=1;%baslangýc frame numarasi
n=260;%okumak isteigimiz son frame numarasi
% n=500;%cerceve sayisi[foreman=300,footbal=260,BasketballPass=500,Stefan=90,fb=125,tennis=150,BigBuckBunny=300]
if nargin<3
    n=input('How many frames you want to read in [all]? n=');
end
if nargin<2
    st=input('Pls provide the starting frame to read [1]:');
    if isempty(st),st=1; end
end

fmt=filename(length(filename)-3:length(filename));
switch lower(fmt)
    case '_cif'
        R=288; C=352;
    case '_sif'
        R=240; C=352;
    case 'qcif'
        R=144; C=176;
    case 'qsif'
        R=120; C=176;
    case 'wqvga'
        R=416; C=240;
    otherwise
        fmt=input('Pls give the sequence format(cif/sif/qcif/qsif/[ others give R and C]),fmt=','s');
        fmtarray={'cif','sif','qcif','qsif'};
        flag=strcmpi(fmtarray,fmt);
        if flag==0
            R=input('Pls give the ROW of one frame,R=');
            C=input('Give the column of one frame,C=');
        else
            switch lower(fmt)
                case 'cif'
                    R=288; C=352;
                case 'sif'
                    R=240; C=352;
                case 'qcif'
                    R=144; C=176;
                otherwise
                    R=120; C=176;
            end
        end
end

fid = fopen(filename,'r');
fseek(fid,0,'eof');
if isempty(n)
    n = ftell(fid)/(1.5*R*C);                   % frame numbers of the file
end

for i = st-1 : st+n-2
    fseek(fid,i*R*C*1.5,'bof');                 % positioning for every frame
                                                % read 3 channels data from file                                               
    Y(:,:,i+2-st) = double((fread(fid,[C,R],'uchar'))');
    U(:,:,i+2-st) = double((fread(fid,[C/2,R/2],'uchar'))');
    V(:,:,i+2-st) = double((fread(fid,[C/2,R/2],'uchar'))');  
end
fclose(fid);

%% YUV formatýndan BMP ye gecme
start_frame=1;%baslangic frame
num_frame=260;%okunacak frame sayisi

if nargin<1
      [filename, pathname] = uigetfile('*.yuv', 'please choose a sequence');
    if isequal(filename,0) || isequal(pathname,0) % User pressed cancel
        return;
    end
end

if nargin<2
    start_frame=input('start frame you want to read in [all]? start_frame=');
end

if nargin<3
    num_frame=input('How many frames you want to read in [all]? num_frame=');
end

    
    [My Ny iL]=size(Y);
    [Mu Nu iu]=size(U);
    [Mv Nv iv]=size(V);

    
    for f=1:num_frame
       UU(:,:,f)= imresize(U(:,:,f),[My Ny],'nearest');
       VV(:,:,f)= imresize(V(:,:,f),[My Ny],'nearest');
        

        image(:,:,1) = Y(:,:,f)+1.402*(VV(:,:,f)-128);
        image(:,:,2) = Y(:,:,f)-0.34414*(UU(:,:,f)-128)-0.71414*(VV(:,:,f)-128);
        image(:,:,3) = Y(:,:,f)+1.772*(UU(:,:,f)-128);
        
        fname=sprintf('%s%3.3d%s',filename(1:length(filename)-4),f,'.bmp');
        
        imwrite(uint8(image),fname,'bmp');
    end