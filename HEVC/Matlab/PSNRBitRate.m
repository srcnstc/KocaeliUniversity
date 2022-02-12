%110207011 SERCAN SATICI
clear all;close all;clc;

%Football.yuv test dosyasý R&D grafikleri

%% FS
bitrateTarget=[600;800;1000;1200];%[kbps]
rb_FS=[502.9812;696.4261;890.6988;1091.0694;];%Bitrate [kbps]
PSNR_FS=[31.3898;33.0789;34.4256;35.6092;];%YUV-PSNR


%% T-GCBPM1

m=50;
bitrateTarget=[600;800;1000;1200];%[kbps]
rb_m50=[503.0547;696.4163;890.8751;1091.0939];%Bitrate [kbps]
PSNR_m50=[29.7692;31.4178;32.6085;33.7654];%YUV-PSNR

figure(1);plot(rb_FS,PSNR_FS);hold on;
title('Farklý Olcekleme katsayýlari için R&D performansý');xlabel('Bit oraný(rb)[kbps]');ylabel('PSNR[dB]');
plot(rb_m50,PSNR_m50,'--r');hold on;

%---------------------------------

m=100;
bitrateTarget=[600;800;1000;1200];%[kbps]
rb_m100=[502.9959;696.4849;890.7918;1091.1527];%Bitrate [kbps]
PSNR_m100=[29.6485;31.1891;32.4053;33.5759];%YUV-PSNR
plot(rb_m100,PSNR_m100,'--g');hold on;

%---------------------------------

m=120;
bitrateTarget=[600;800;1000;1200];%[kbps]
rb_m120=[502.9029;696.3967;890.7331;1091.0547];%Bitrate [kbps]
PSNR_m120=[29.3296;30.9517;32.2233;33.3527];%YUV-PSNR

plot(rb_m120,PSNR_m120,'--k');hold on;

%---------------------------------

m=150;
bitrateTarget=[600;800;1000;1200];%[kbps]
rb_m150=[502.9714;696.4506;890.6841;1091.1478];%Bitrate [kbps]
PSNR_m150=[29.7595;31.3755;32.6583;33.7996];%YUV-PSNR

plot(rb_m150,PSNR_m150,'--y');
legend('SAD','m=50','m=100','m=120','m=150');

