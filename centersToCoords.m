function coords = centerToCoords(centers,radii)
%centers (:,1) = Y
%centers (:,2) = X
    x1 = centers(:,2)-radii(:);
    x2 = centers(:,2)+radii(:);
    y1 = centers(:,1)-radii(:);
    y2 = centers(:,1)+radii(:);
    
    coords = round([x1 x2 y1 y2]);
end