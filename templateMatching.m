function similarity = templateMatching(C)

sizeC = length(C);%contains the bin image of numbers

similarity = zeros(10,sizeC);
for i = (1:sizeC)
    [sizeX,sizeY] = size(C{i});
    for number = 0:9
        tIm = imread(['.\PICTO\C',num2str(number),'.png']);%template image
        tIm = imresize(tIm,[sizeX sizeY]);
        tBin = tIm>200; %template image to binary
        imIAND = C{i}&tBin | ~C{i} & ~tBin;
        similarity(number+1,i) = sum(sum(imIAND))/(sizeX*sizeY);
    end
end
end

