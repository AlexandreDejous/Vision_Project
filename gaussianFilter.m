function gaussianFilter(im)
[sizex, sizey, sizez] = size(im);
im = rgb2gray(im);

h = fspecial('gaussian',10,6);
im = imfilter(im,h);





imshow(im);

IMTEST = im;
[centers, radii,metric] = imfindcircles(IMTEST,[15 100],'ObjectPolarity','dark', ...
    'Sensitivity',0.92,'EdgeThreshold',0.1);
viscircles(centers, radii,'EdgeColor','b');
end
