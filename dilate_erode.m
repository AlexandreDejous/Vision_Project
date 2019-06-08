clear all;
close all;
clc;
im = imread(".\BD\IM (36).JPG");
[sizex, sizey, sizez] = size(im);
im = rgb2gray(im);

se = strel('square',4);

imDila = imdilate(im,se);

imDilaEro = imdilate(imDila,se);

imshow(imDilaEro);

IMTEST = imDilaEro;
[centers, radii,metric] = imfindcircles(IMTEST,[15 100],'ObjectPolarity','dark', ...
    'Sensitivity',0.92,'EdgeThreshold',0.1);
viscircles(centers, radii,'EdgeColor','b');