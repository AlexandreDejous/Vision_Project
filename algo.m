clear all;
close all;
clc;

im = imread(".\BD\IM (36).JPG");
[sizex, sizey, sizez] = size(im);
figure(1);
imshow(im);
for x = (1:sizex)
    for y = (1:sizey)
        if(im(x,y,1)>130 & im(x,y,2)>130 & im(x,y,3)>130)
            im(x,y,1)= 255;
            im(x,y,2)= 255;
            im(x,y,3)= 255;
        end
    end
end
%im = imread("DetectFiveStrongestCirclesInImageExample_01.png");
im = rgb2gray(im); %gris
im = glp(im,100);
im = abs(im);
im = uint8(im);
figure(2);
imshow(im);

%jm = imcomplement(im); %complement

% h = fspecial('laplacian',0.2);
% im = imfilter(im,h);
% se = strel('square',5);
% im = imerode(im,se);
% for i = (1:sizex)
% 	for j = (1:sizey)
% 		if im(i,j)>15
% 			im(i,j) = 255;
% 		end
% 	end
% end

%se2 = strel('square',15);
%jm = imerode(jm,se2);

%figure(1);
%imshow(im);

%exam = im(1:250,1:250)
[centers, radii,metric] = imfindcircles(im,[15 100],'ObjectPolarity','dark', ...
    'Sensitivity',0.92,'EdgeThreshold',0.1);
viscircles(centers(1:10,:), radii(1:10),'EdgeColor','r');

% figure(2);
% imshow(jm);
% [centers2, radii2,metric2] = imfindcircles(jm,[15 100],'ObjectPolarity','bright', ...
%    'Sensitivity',0.92,'EdgeThreshold',0.1);
% viscircles(centers2, radii2,'EdgeColor','r');


