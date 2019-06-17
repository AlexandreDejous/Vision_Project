function prob = simToNum(similarity)
    [sizeX,sizeY] = size(similarity);
    if (sizeY == 0)
        prob{1} = 0;
        prob{2} = 0;
    else
        candidates = zeros(1,1);%gather max similarity from each cell
        for i = (1:sizeY)
            candidates(i,1) = max(similarity(:,i));
        end
        %find the 2 indexes of images of C wich hold the hightest similarity
        best1 = max(candidates);
        [PLACEHOLDER,index1] = ismembertol(candidates,best1,0.0001);
        index1 = find(index1);
        if (sizeY > 1)
            candidates(index1,1) = -10;%we get this value out to find snd maximum
            best2 = max(candidates);
            [PLACEHOLDER,index2] = ismembertol(candidates,best2,0.0001);
            index2 = find(index2);

        %if index1>index2, swap indexes and bests (the numbers are recognized from left to right,
        %but the first max can be at the snd number
            if(index1>index2)
                PLACEHOLDER = index1;
                index1 = index2;
                index2 = PLACEHOLDER;
                PLACEHOLDER = best1;
                best1 = best2;
                best2 = PLACEHOLDER;
            end
        end

        %set threshold for number acceptance
        thresh = 0.78;
        %search in cell index1 and index2 the highest detected number and
        %convert it to string
        [PLACEHOLDER,num1] = ismembertol(similarity(:,index1),best1,0.0001);
        num1 = find(num1);
        num1 = num1 -1;
        num1 = num2str(num1);
        %reject num1 if best1 is < threshold
        if (best1<thresh)
            num1 = '';
        end
        lineNum = num1;
        if (sizeY > 1)
            [PLACEHOLDER,num2] = ismembertol(similarity(:,index2),best2,0.0001);
            num2 = find(num2);
            num2 = num2 -1;
            num2 = num2str(num2);
            if (best2<thresh)
                num2 = '';
            end        
        %concatenate strings to form line number ex: strcat('2','') = '2'; cat('1','4') = '14';
            lineNum = strcat(num1,num2);
        end

        %convert string back to number
        if length(lineNum) == 0 
            lineNum = 0;
        else
            lineNum = str2num(lineNum);
        end
        likelihood = best1;
        %if (sizeY > 1)
        %    likelihood = mean([best1,best2]);
        %end
        prob = cell(1,1);
        if (sizeY > 1)
            prob = cell(2,1);
        end
        prob{1} = lineNum;
        prob{2} = likelihood;
    end    
end