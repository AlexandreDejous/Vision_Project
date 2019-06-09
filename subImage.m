function subIm = subImage(im, coords, n)%pick n-th sub image from im with coords(n)
    x1 = coords(n,1);
    x2 = coords(n,2);
    y1 = coords(n,3);
    y2 = coords(n,4);
    subIm = im((x1:x2),(y1:y2),:);
end