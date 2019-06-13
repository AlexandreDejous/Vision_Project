function C = extractNumbers(im)
%close all;
%BW = FinalResult >= 200;%mask
%im  = imread('.\PICTO\12.png')
%[im,map] = imread(".\BD\IM (1).JPG");
%im = im((518:562),(1263:1307),:); %FALSE POSITIVE
%im = im((459:613),(813:968),:); %TRUE POSITIVE
%[im,map] = imread(".\PICTO\12.png");
[sizeX,sizeY,~] = size(im);
imGray = rgb2gray(im);
imNumbers = zeros(sizeX,sizeY);
%grayconnected()



optimal = 3;
thresh = multithresh(imGray,optimal-1);
seg_im = imquantize(imGray,thresh);
pixelsInClust = zeros(3,1);
pixelsInClust(1) = sum(seg_im(:) == 1);
pixelsInClust(2)= sum(seg_im(:) == 2);
pixelsInClust(3)= sum(seg_im(:) == 3);
if pixelsInClust(1) ~= min(pixelsInClust)
    
    optimal = 2;
    thresh = multithresh(imGray,optimal-1);
    seg_im = imquantize(imGray,thresh);
    for x = 1:sizeX
        for y = 1:sizeY
            if seg_im(x,y) == 2;
                imNumbers(x,y) = 255;
            end
        end
    end
end

if optimal == 3
    for x = 1:sizeX
        for y = 1:sizeY
            if seg_im(x,y) == 1;
                imNumbers(x,y) = 255;
            end
        end
    end
end

%figure, imshow(imNumbers);

BW1 = grayconnected(imNumbers,1,1);
BW2 = grayconnected(imNumbers,1,sizeY);
BW3 = grayconnected(imNumbers,sizeX,1);
BW4 = grayconnected(imNumbers,sizeX,sizeY);
BW = BW1|BW2|BW3|BW4;
%imshow(BW);

for x = 1:sizeX
    for y = 1:sizeY
        if BW(x,y) == 1;
            imNumbers(x,y) = 0;
        end
    end
end

%figure, imshow(imNumbers);
    %white
imNumbersBin = imNumbers == 255;
[labels,labeled] = bwlabel(imNumbersBin);


%preparing cells
C = cell(labeled,1);

%putting binary image of numbers cropped in cells
for i = (1:labeled)
    for x =(1:sizeX)
        for y =(1:sizeY)
            binary = labels == i;%creates binary image from the label i
            [rows, columns] = find(binary);
            row1 = min(rows);
            row2 = max(rows);
            col1 = min(columns);
            col2 = max(columns);
            C{i} = binary(row1:row2, col1:col2); % Crop image and put in cell
        end
    end
end


end
