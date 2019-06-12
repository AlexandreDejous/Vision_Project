function result = adjust_luminosity(im)
[sizex, sizey, sizez] = size(im);
imInv = imcomplement(im);
imInv2 = imreducehaze(imInv);
result = imcomplement(imInv2);
end