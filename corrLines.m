function corrArrayMEAN = corrLines(im)
%takes sub image in input and returns correlation with paris metro lines
    lineIm = imread('.\PICTO\01.png');
    [lineX, lineY, ~] = size(lineIm);%we assume dimensions of all picto images are same
    lineX = 46;%MODIF
    lineY = 47;%MODIF
    im = imresize(im,[lineX lineY]);%resize input im according to metro picto dim
    im = rgb2gray(im);%   GRAY-----------------
    im = LoG(im);%LOG
    corrArrayRGB = zeros(14,3);
    %corrArrayMEAN = zeros(14,3);
    corrArrayMEAN = zeros(14,1); %GRAY -----------
    for line = (1:14)
        if(line < 10)
            n = num2str(line);
            lineIm = imread(['.\PICTO\0',n,'.png']);
        else
            n = num2str(line);
            lineIm = imread(['.\PICTO\',n,'.png']);
        end
        lineIm = lineIm((9:54),(8:54),:);%MODIF
        lineIm = rgb2gray(lineIm);%GRAY---------------
        lineIm = LoG(lineIm);%LOG
%%
        for x = (1:lineX)
            for y = (1:lineY)
                if im(x,y) == 255 & lineIm(x,y) == 255
                    corrArrayMEAN(line,1) = corrArrayMEAN(line,1) + 1;
                end
            end
        end
        
%%
        corrArrayMEAN(line,1) = corrArrayMEAN(line,1) / (lineX*lineY);
        %corrArrayMEAN(line,1) = corr2(im,lineIm);%GRAY----------------
%         corrArrayRGB(line,1) = corr2(im(:,:,1),lineIm(:,:,1));
%         corrArrayRGB(line,2) = corr2(im(:,:,2),lineIm(:,:,2));
%         corrArrayRGB(line,3) = corr2(im(:,:,3),lineIm(:,:,3));
%         corrArrayMEAN(line,1) = (corrArrayRGB(line,1)+corrArrayRGB(line,2)+corrArrayRGB(line,3))/3;
    end
end