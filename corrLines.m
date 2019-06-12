function corrArrayMEAN = corrLines(im)
%takes sub image in input and returns correlation with paris metro lines
    lineIm = imread('.\PICTO\01.png');
    [lineX, lineY, ~] = size(lineIm);%we assume dimensions of all picto images are same
    im = imresize(im,[lineX lineY]);%resize input im according to metro picto dim
    corrArrayRGB = zeros(14,3);
    corrArrayMEAN = zeros(14,3);
    for line = (1:14)
        if(line < 10)
            n = num2str(line);
            lineIm = imread(['.\PICTO\0',n,'.png']);
        else
            n = num2str(line);
            lineIm = imread(['.\PICTO\',n,'.png']);
        end
        
        corrArrayRGB(line,1) = corr2(im(:,:,1),lineIm(:,:,1));
        corrArrayRGB(line,2) = corr2(im(:,:,2),lineIm(:,:,2));
        corrArrayRGB(line,3) = corr2(im(:,:,3),lineIm(:,:,3));
        corrArrayMEAN(line,1) = (corrArrayRGB(line,1)+corrArrayRGB(line,2)+corrArrayRGB(line,3))/3;
    end
end