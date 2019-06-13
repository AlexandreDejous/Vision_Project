function im = LoG(im)
h = fspecial('log',4,3)*10000;
im = imfilter(im,h);
end