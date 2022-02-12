# Face Detection with Viola-Jones 

# version 1.0.0
On most faces, the upper part of the eyes has a dark area, while the nose and cheekbones appear brighter. The algorithm that sees these properties decides that it is a face. Rectangular linear filters are used for feature detection. It uses integral images to quickly evaluate features.. Change Registration: 01.01.2014

Designer | Subject  |
---| --- |
Sercan SATICI | Face Detection with Viola-Jones  |


Method | Definition  |
---| --- |
Face Detection with Viola-Jones  | In this method developed for real-time object detection, the training phase is slow and the detection phase is fast. For the classification task, the faces that are desired to be detected are taken from the picture that includes the facial features. Then the mask of the face is created by clipping. Two face prototypes were included within the scope of the project in the Viola-Jones method, in which masking was performed with approximately 5000 faces during the training phase. In these face prototypes, the pixels in the same position as the pixels where the mask is black and the pixels in the same position in the picture are -1 and the pixels in the same position as the pixels where the mask is white are crossed by +1 to find a threshold value of the picture. With this found threshold mask, the face image is subjected to And operation from the logical operation commands. The resulting picture is hovered over the original picture and detects the places with faces on the picture. |
Input |  "ViolaJones.m", "testimage.JPG" |
Output | Face detected image output |
