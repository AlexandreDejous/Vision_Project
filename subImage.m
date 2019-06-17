function subIm = subImage(im, coords, n)%pick n-th sub image from im with coords(n)
    [sizeX,sizeY,~] = size(im);
    coords = coords;
    %this for loop is to prevent us to have an out of bound index error if
    %the coordinates of the box are outside the input image im
    for i = (1:4)
        if coords(n,i)<1
            coords(n,i) = 1;
        end
        if (i<3)
            if coords(n,i) > sizeX
                coords(n,i) = sizeX;
            end
        else
            if coords(n,i) > sizeY
                coords(n,i) = sizeY;
            end
        end
    end
    
    x1 = coords(n,1);
    x2 = coords(n,2);
    y1 = coords(n,3);
    y2 = coords(n,4);
    
    subIm = im((x1:x2),(y1:y2),:);
end