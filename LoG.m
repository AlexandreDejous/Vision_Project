clear all;
close all;
clc;
im = imread(".\BD\IM (36).JPG");
[sizex, sizey, sizez] = size(im);
im = rgb2gray(im);





h = fspecial('log',10,7)*10000;
im = imfilter(im,h);
imshow(im);
%actual test
[centers, radii,metric] = imfindcircles(im,[15 100],'ObjectPolarity','dark', ...
    'Sensitivity',0.92,'EdgeThreshold',0.1);
centers = centers(1:15,:);
radii = radii(1:15,:);
viscircles(centers, radii,'EdgeColor','b');