function similarity = templateMatching(C)

sizeC = length(C);%contains the bin image of numbers

similarity = zeros(10,sizeC);
for i = (1:sizeC)
    [sizeX,sizeY] = size(C{i});
    for number = 0:9%over all detections, over all pictograms
        tIm = imread(['.\PICTO\C',num2str(number),'.png']);%template image
        tIm = imresize(tIm,[sizeX sizeY]);%resize it (we need it to be same size as detections)
        tBin = tIm>200; %template image to binary
        imIAND = C{i}&tBin | ~C{i} & ~tBin;% = XNOR(C{i},tBin)
        similarity(number+1,i) = sum(sum(imIAND))/(sizeX*sizeY);%calculates proportion of similar pixels
    end
end

end

