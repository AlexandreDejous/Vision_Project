function similarity = templateMatching(C)

sizeC = length(C);%contains the bin image of numbers

similarity = zeros(10,sizeC);
for i = (1:sizeC)
    [sizeX,sizeY] = size(C{i});
    for number = 0:9
        tIm = imread(['.\PICTO\C',number,'.png']);%template image
        tIm = imresize(tIm,[numrows numcols]);
        tBin = tIm>200; %template image to binary
        imOR = im|tBin;
        similarity(number+1,1) = sum(sum(imOR))/(sizeX*sizeY);
    end
end
end

