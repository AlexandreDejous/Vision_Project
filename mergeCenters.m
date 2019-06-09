function [c, r] = mergeCenters(centers1, radii1,centers2,radii2)
%get their length
l1 = length(radii1(:));
l2 = length(radii2(:));
%concatenante the centers in centers12
l12 = l1 + l2;
centers12 = zeros(l12,2);
for i = (1:l1)
    centers12(i,:) = centers1(i,:);
end
for j = (1:l2)
    centers12(l1+j,:) = centers2(j,:);
end
%concatenante the radii in radii12
radii12 = zeros(l12,1);
for i = (1:l1)
    radii12(i) = radii1(i);
end
for j = (1:l2)
    radii12(l1+j) = radii2(j);
end

%thresholds for merge
threshC = 3;
threshR = 3;

%merge radii
r(1) = radii(1);
for i = (1:l12)
    same = false;
    for j = (1:length(r))
        if (centers12(i,1) )
        if (radii12(i)<r(j)+threshR & radii12(i)>r(j)-threshR)
            same = true
            break;
        end
        
    end
    if (same)
        r(length(r)+1) = radii12() 
    end
    
end

%centers12
c = centers12
r = radii12
end