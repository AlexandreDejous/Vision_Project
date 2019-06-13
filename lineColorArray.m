function lineColor = lineColorArray
    lineColor = zeros(14,3);
    for line = (1:14)
        if(line < 10)
            n = num2str(line);
            lineIm = imread(['.\PICTO\0',n,'.png']);
        else
            n = num2str(line);
            lineIm = imread(['.\PICTO\',n,'.png']);
        end
        lineIm = rgb2hsv(lineIm);
        lineColor(line,:) = lineIm(12,30,:);
    end
end