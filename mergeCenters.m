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
threshC = 10;
threshR = 10;

%merge radii
r(1) = radii12(1);
c(1,:) = centers12(1,:);
for i = (1:l12)
    same = false;
    for j = (1:length(r))
        if (centers12(i,1)<=c(j,1)+threshC & centers12(i,1)>=c(j,1)-threshC)
        if (centers12(i,2)<=c(j,2)+threshC & centers12(i,2)>=c(j,2)-threshC)
        if (radii12(i)<=r(j)+threshR & radii12(i)>=r(j)-threshR)
            centers12(i,:)
            c(j,:)
            same = true;
            break;
        end
        end
        end
        
    end
    if (~same)
        index = length(r)+1;
        r(index) = radii12(i);
        c(index,:) = centers12(i,:);
    end
    
end

%centers12
%c = centers12
%r = radii12
end