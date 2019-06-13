%im  = imread('.\PICTO\C0.png');
%tBin = im>200; %template binary
[sizeX,sizeY] = size(im);
similarity = zeros(10,1);

for number = 0:9
    tIm = imread(['.\PICTO\C',number,'.png']);%template image
    tIM = imresize(tIm,[numrows numcols]);
    tBin = tIm>200; %template image to binary
    imOR = im|tBin;
    similarity = sum(sum(imOR))/(sizeX*sizeY);
end
