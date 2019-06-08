function erode_dilate(im)
[sizex, sizey, sizez] = size(im);
im = rgb2gray(im);



se = strel('square',4);
imEro = imerode(im,se);
%imEro = imerode(imEro,se);


imEroDila = imdilate(imEro,se);
%imEroDila = imdilate(imEroDila,se);



imshow(imEroDila);

IMTEST = imEroDila;
[centers, radii,metric] = imfindcircles(IMTEST,[15 100],'ObjectPolarity','dark', ...
    'Sensitivity',0.92,'EdgeThreshold',0.1);
viscircles(centers, radii,'EdgeColor','b');
end
