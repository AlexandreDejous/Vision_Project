clear all;
close all;
clc;

%%
%reads each image with metro line on it and extract hsv
%12,30
lineColor = zeros(14,3);
for line = (1:14)
    if(line < 10)
        n = num2str(line);
        lineIm = imread(['.\PICTO\0',n,'.png']);
    else
        n = num2str(line);
        lineIm = imread(['.\PICTO\',n,'.png']);
    end
    lineIm = rgb2hsv(lineIm);
    lineColor(line,:) = lineIm(12,30,:);
    %figure(line);
    %imshow(lineIm);
end
%% 


%import image and init hsvimage + resulting image
[im,map] = imread(".\BD\IM (36).JPG");
imHsv = rgb2hsv(im);
[sizex, sizey, sizez] = size(imHsv);
imResult = zeros(sizex, sizey, sizez);
imResultLine = zeros(sizex, sizey);

%tresholds for detection
treshHlow = 0.08 ;  %/360; 0.08
treshHhigh = 0.08 ;  %/360; 0.08
treshSlow =  0.10;%/100; 0.2
treshShigh =  0.20;%/100; 0.2
treshVlow =  0.55;%/100; 0.8
treshVhigh =  0.0;%/100; 0.8

%check if values of hsv in tresholds, then put them into resulting image
for x = 1:sizex
    for y = 1:sizey
        for line = 1:14
            if imHsv(x,y,1) > lineColor(line,1)-treshHlow & imHsv(x,y,1) < lineColor(line,1)+treshHhigh
                if imHsv(x,y,2) > lineColor(line,2)-treshSlow & imHsv(x,y,2) < lineColor(line,2)+treshShigh
                    if imHsv(x,y,3) > lineColor(line,3)-treshVlow & imHsv(x,y,3) < lineColor(line,3)+treshVhigh
                        imResult(x,y,:) = imHsv(x,y,:);
                        imResultLine(x,y) = line;
                    end
                end
            end
        end
    end
end
figure(1);
imshow(imHsv);
figure(2);%debugging
imshow(imResult);
figure(3);
imshow(imResultLine);
figure(4);
imshow(im);
% [im,map] = imread(".\PICTO\01.png");
% [sizex, sizey, sizez] = size(im);
% figure(1);
% imshow(im);
% im = rgb2hsv(im);
% figure(2);
% imshow(im);