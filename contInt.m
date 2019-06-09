clear all;
close all;
clc;
im = imread(".\BD\IM (6).JPG");
[sizex, sizey, sizez] = size(im);
im = rgb2gray(im);

se = strel('square',15);
imEro = imerode(im,se);

imRes = im - imEro;
%image(imEro)
imshow(imRes);

[centers, radii,metric] = imfindcircles(imRes,[15 100],'ObjectPolarity','dark', ...
    'Sensitivity',0.92,'EdgeThreshold',0.1);
viscircles(centers, radii,'EdgeColor','b');