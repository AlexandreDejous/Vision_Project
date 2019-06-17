function C = extractNumbers(im)

%FOR TESTS
%im  = imread('.\PICTO\12.png')
%[im,map] = imread(".\BD\IM (1).JPG");
%im = im((518:562),(1263:1307),:); %FALSE POSITIVE
%im = im((459:613),(813:968),:); %TRUE POSITIVE
%[im,map] = imread(".\PICTO\02.png");
%END TESTS


[sizeX,sizeY,~] = size(im);
imGray = rgb2gray(im);
imNumbers = zeros(sizeX,sizeY);




optimal = 3;%optimal is number of clusters, and optimal-1 is number of thresholds
thresh = multithresh(imGray,optimal-1);%multi otsu threshold
seg_im = imquantize(imGray,thresh);%apply found thresholds
pixelsInClust = zeros(3,1);
pixelsInClust(1) = sum(seg_im(:) == 1);
pixelsInClust(2)= sum(seg_im(:) == 2);
pixelsInClust(3)= sum(seg_im(:) == 3);
if pixelsInClust(1) ~= min(pixelsInClust)%if there is the fewest pixels in class 1
    
    optimal = 2;%then we choose otsu with k=2
    thresh = multithresh(imGray,optimal-1);%find thresholds with otsu k=2
    seg_im = imquantize(imGray,thresh);%apply
    for x = 1:sizeX
        for y = 1:sizeY
            if seg_im(x,y) == 2%if the current pixel is from class 2 out of 2 (brightest)
                imNumbers(x,y) = 255;%
            end
        end
    end
end

if optimal == 3%if we have 3 classes in image
    for x = 1:sizeX
        for y = 1:sizeY
            if seg_im(x,y) == 1;%if current pixel belongs to darkest class (1) (the number of the line)
                imNumbers(x,y) = 255;
            end
        end
    end
end

%figure, imshow(imNumbers);

%get the 4 corners of the image as pixels = 1, rest = 0
BW1 = grayconnected(imNumbers,1,1);
BW2 = grayconnected(imNumbers,1,sizeY);
BW3 = grayconnected(imNumbers,sizeX,1);
BW4 = grayconnected(imNumbers,sizeX,sizeY);
BW = BW1|BW2|BW3|BW4;
%imshow(BW);


for x = 1:sizeX
    for y = 1:sizeY
        if BW(x,y) == 1;
            imNumbers(x,y) = 0;%do imNumbers - BW (put to 0 the background)
        end
    end
end

%figure, imshow(imNumbers);
    %white
imNumbersBin = imNumbers == 255;

%give a label on the pixels at 1 on a contiguous region
%we iterate over a for loop to kick out regions with not enough pixels
[labels,labeled] = bwlabel(imNumbersBin);
for label = 1:labeled%iterate over all labels
    pixelsPerLabel = 0;
    for x = 1:sizeX %over the image
        for y = 1:sizeY
            if labels(x,y) == label
                pixelsPerLabel = pixelsPerLabel +1; %count the pixels of that label
            end
        end
    end
    probPerLabel = pixelsPerLabel/(sizeX*sizeY); % number of pixels -> proportion of pixels
    if probPerLabel < 0.05 %if proportion is less than 5% of total pixels
        imNumbersBin(find(labels==label)) = 0;%prune the region
    end
end
[labels,labeled] = bwlabel(imNumbersBin); %re-attribite labels 



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
