function prob = simToNum(similarity)
    [sizeX,sizeY] = size(similarity);
    candidates = zeros(1,1);%gather max similarity from each cell
    for i = (1:sizeY)
        candidates(i,1) = max(similarity(:,i));
    end
    %find the 2 indexes of images of C wich hold the hightest similarity
    best1 = max(candidates);
    [~,index1] = ismembertol(candidates,best1,0.02);
    candidates(index1,1) = 10;%we get this value out to find snd maximum
    best2 = max(candidates);
    [~,index2] = ismembertol(candidates,best2,0.02);
    
    
end