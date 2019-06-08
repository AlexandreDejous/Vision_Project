clear all;
close all;
clc;
im = imread(".\BD\IM (36).JPG");
[sizex, sizey, sizez] = size(im);
im = rgb2gray(im);

%%
se = strel('square',10);
im = imerode(im,se);
%imEro = imerode(imEro,se);


im = imdilate(im,se);
%imEroDila = imdilate(imEroDila,se);
%%
%guassian filt and show + convert double


im = ghp(im,750);
im = abs(im);

imshow(im);

%%
%pepper and salt
%im = medfilt2(im,[4 4]);
imshow(im);

%%
%actual test
[centers, radii,metric] = imfindcircles(im,[15 100],'ObjectPolarity','dark', ...
    'Sensitivity',0.92,'EdgeThreshold',0.1);
viscircles(centers, radii,'EdgeColor','b');