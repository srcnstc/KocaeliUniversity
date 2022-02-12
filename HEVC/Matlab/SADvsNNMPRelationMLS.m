%110207011 SERCAN SATICI
clear all;close all;clc;
dosya=fopen('NNMP.txt', 'r' );%dosya acildi
dosya2=fopen('SAD.txt', 'r' );%dosya acildi

%Dosya Okuma
nnmpcell={};
fid = fopen('NNMP.txt');
tline = fgetl(fid);
while ischar(tline)
   nnmpcell=[nnmpcell;tline];
   tline = fgetl(fid);
end

SADcell={};
fid = fopen('SAD.txt');
tline = fgetl(fid);
while ischar(tline)
   SADcell=[SADcell;tline];
   tline = fgetl(fid);
end

%Degisken tipi degistirme
for i = 1:length(SADcell)
   SAD(i,1) = str2num(cell2mat(SADcell(i))); 
   nnmp(i,1) = str2num(cell2mat(nnmpcell(i)));
end
% [X,Y]=fscanf(dosya,'%d',inf);%veriler degiskenlere cekildi

%BubleSort
for j=1:length(SAD)
    for i=1:length(SAD)-1
        if(SAD(i+1,1)<SAD(i,1))
            temp=SAD(i,1);
            temp2=nnmp(i,1);
            SAD(i,1)=SAD(i+1,1);
            nnmp(i,1)=nnmp(i+1,1);
            SAD(i+1,1)=temp;
            nnmp(i+1,1)=temp2;
        end
    end
end

% En Kucuk Kareler Yaklasýmý
vizualization='yes';
XData=nnmp;
YData=SAD;
kx=length(XData);
ky=length(YData);
if kx ~= ky
   disp('Incompatible X and Y data.');
   close all;
end
n=size(YData,2);
sy=sum(YData)./ky;
sx=sum(XData)./kx;
sxy=sum(XData.*YData);
sy2=sum(YData.^2);
sx2=sum(XData.^2);
B=0.5.*(((sy2-ky.*sy.^2)-(sx2-kx.*sx.^2))./(ky.*sx.*sy-sxy));
b1=-B+(B.^2+1).^0.5;
b2=-B-(B.^2+1).^0.5;
a1=sy-b1.*sx;
a2=sy-b2.*sx;
R=corrcoef(XData,YData);
if R(1,2) > 0 
    P=[b1 a1];
    Yhat = XData.*b1 + a1;
    Xhat = ((YData-a1)./b1);
end
if R(1,2) < 0
    P=[b2 a2];
    Yhat = XData.*b2 + a2;
    Xhat = ((YData-a2)./b2);
end   
alpha = atan(abs((Yhat-YData)./(Xhat-XData)));
d=abs(Xhat-XData).*sin(alpha);
%Err=sum(abs(d));
Err=sum(d.^2);
switch lower(vizualization)
     case {'yes'}
        plot(XData,YData,'blue*'); 
        hold on;
        plot(XData,Yhat,'black');
        hold off
     case {'no' }
         disp('No vizualization.')      
end
disp('Min. Least Square yaklasimi ile en uyugun denklem, y=mx+b ');
disp('[m b]');
disp(P);

%RANSAC

