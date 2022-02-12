# Implementation of Fast Motion Estimation Algorithm to High Efficiency Video Coding (HEVC)

# version 1.0.0
Although motion estimation is one of the most important stages of video coding techniques, it is the part where the most complexity and processing load is in the coding part. In HEVC, which is known as the newest video coding technique, the Test Zone (TZ) algorithm is presented as a standard in the motion estimation stage. TZ is a search technique that incorporates the Eight-point and Two-point search techniques along with the Diamond search strategy, as well as the Raster search. Motion estimation can be accelerated by examining fewer points in the search phase or by approaches based on low bit representation, and it is also aimed to provide high quality. In the implementation phase, the fast motion segmentation algorithm (xPatternSearchTGCBPM()) was applied instead of the TZ motion estimation algorithm (xPatternSearch()) presented as standard in the HM reference software. Change Registration: 01.06.2016 

Designer | Subject  |
---| --- |
Sercan SATICI | Implementation of Fast Motion Estimation Algorithm to High Efficiency Video Coding (HEVC) |


Method | Definition  |
---| --- |
Implementation of Fast Motion Estimation Algorithm to High Efficiency Video Coding (HEVC) | Instead of the Test Zone (TZ) algorithm, which is offered as a standard in the motion estimation block with HEVC, a fast motion estimation algorithm (TGCBPM) has been implemented in which fewer search points are scanned. |
Input |  HM-dev sources, BasketballPass_416x240_50.yuv, football_cif.yuv, mobile_cif.yuv, stefan_cif.yuv |
Output | HEVC encoded video |
