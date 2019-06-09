function LoG(im)
imshow(im);
%im = rgb2gray(im);

[centers, radii,metric] = imfindcircles(im,[15 100],'ObjectPolarity','dark', ...
    'Sensitivity',0.92,'EdgeThreshold',0.1);
viscircles(centers, radii,'EdgeColor','b');

h = fspecial('log',10,7)*10000;
im = imfilter(im,h);

%actual test
[centers2, radii2,metric2] = imfindcircles(im,[15 100],'ObjectPolarity','dark', ...
    'Sensitivity',0.92,'EdgeThreshold',0.1);
centers2 = centers2(1:15,:);
radii2 = radii2(1:15,:);
viscircles(centers2, radii2,'EdgeColor','r');
end