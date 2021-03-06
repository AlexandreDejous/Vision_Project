function [c,r] = searchCircles(im)
%find circles in function to make the code cleaner
[centers, radii,metric] = imfindcircles(im,[15 100],'ObjectPolarity','dark', ...
'Sensitivity',0.92,'EdgeThreshold',0.1);
if(length(radii)>10)
    centers = centers(1:10,:);
    radii = radii(1:10);
end
c = centers;
r = radii;

end