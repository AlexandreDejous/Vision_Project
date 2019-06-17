%im = newAlgo(imread('.\BD\IM (2).JPG'),100);

function response = saturAndFilt(im,tresh)


[sizex, sizey, sizez] = size(im);
%figure(1);
%imshow(im);
imHsv = rgb2hsv(im);
% figure(3);
% imshow(imHsv);

%treshWhite = 3;
% for x = (1:sizex)
%     for y = (1:sizey)
%         if(im(x,y)>170)
%             im(x,y)= 255;
%         end
%     end
% end
% for x = (1:sizex)
%     for y = (1:sizey)
%         if(abs(im(x,y,2)-im(x,y,1))<=treshWhite & abs(im(x,y,2)-im(x,y,3))<=treshWhite & im(x,y,1)>170)
%             im(x,y,1)= 255;
%             im(x,y,2)= 255;
%             im(x,y,3)= 255;
%         end
%     end
% end
%im = imread("DetectFiveStrongestCirclesInImageExample_01.png");
line7Hue = 0.96;
line7Tresh = 0.06;

for x = (1:sizex)
    for y = (1:sizey)
        if(imHsv(x,y,2)<=0.30 & imHsv(x,y,3)>0.55)
            if (imHsv(x,y,1)> line7Hue + line7Tresh | imHsv(x,y,1)< line7Hue - line7Tresh)
                im(x,y,1)= 255;
                im(x,y,2)= 255;
                im(x,y,3)= 255;
            
            end
%         else
%                 im(x,y,1)= 0;
%                 im(x,y,2)= 0;
%                 im(x,y,3)= 0;
        end
    end
end

im = rgb2gray(im); %gris
%im = uint8(im);
im = glp(im,tresh);
im = abs(im);
im = uint8(im);
% figure(1)
% imshow(im);
% figure(2)
% imshow(imHsv);
response = im;

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
% [centers, radii,metric] = imfindcircles(im,[15 100],'ObjectPolarity','dark', ...
%     'Sensitivity',0.92,'EdgeThreshold',0.1);
% viscircles(centers(1:10,:), radii(1:10),'EdgeColor','r');

% figure(2);
% imshow(jm);
% [centers2, radii2,metric2] = imfindcircles(jm,[15 100],'ObjectPolarity','bright', ...
%    'Sensitivity',0.92,'EdgeThreshold',0.1);
% viscircles(centers2, radii2,'EdgeColor','r');
end


