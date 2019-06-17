function response = saturAndFilt(im,tresh)


[sizex, sizey, sizez] = size(im);
imHsv = rgb2hsv(im);
line7Hue = 0.96;
line7Tresh = 0.06;

for x = (1:sizex)
    for y = (1:sizey)
        if(imHsv(x,y,2)<=0.30 & imHsv(x,y,3)>0.55)
            if (imHsv(x,y,1)> line7Hue + line7Tresh | imHsv(x,y,1)< line7Hue - line7Tresh)
                im(x,y,1)= 255;%if current pixel is white enough and not similar to line7 color, saturate!
                im(x,y,2)= 255;
                im(x,y,3)= 255;
            
            end
        end
    end
end

im = rgb2gray(im); %gray image
im = glp(im,tresh); %slight gaussian low pass
im = abs(im); 
im = uint8(im);
response = im;

end


