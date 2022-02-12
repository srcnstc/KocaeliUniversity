clear all;close all;clc;
Img=imread('testimage.jpg');
faceDetector = vision.CascadeObjectDetector;
bboxes = step(faceDetector, Img);
figure, imshow(Img), title('Detected faces');hold on
for i=1:size(bboxes,1)
    rectangle('Position',bboxes(i,:),'LineWidth',2,'EdgeColor','y');
end