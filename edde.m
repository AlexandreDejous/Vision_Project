function edde(im)
[sizex, sizey, sizez] = size(im);
im = rgb2gray(im);

se = strel('square',7);

im1 = imerode(im,se);

im2 = imdilate(im1,se);

im3 = imdilate(im2,se);

im4 = imerode(im3,se);

imshow(im4);
[centers, radii,metric] = imfindcircles(im4,[15 100],'ObjectPolarity','dark', ...
    'Sensitivity',0.92,'EdgeThreshold',0.1);
viscircles(centers, radii,'EdgeColor','b');

end