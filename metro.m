%% Programme principal de reconnaissance et de sauvegarde des résultats
% -------------------------------------------------------------------------
% Input :
%           type = 'Test' ou 'Learn' pour définir les images traitées
% Outputs
%           fileOut  :      nom (string) du fichier .mat des résultats de
%                           reconnaissance
%           resizeFactor :  facteur de redimensionnement qui a été appliqué
%                           aux images
% 
%--------------------------------------------------------------------------
function [fileOut,resizeFactor] = metro(type)


% Sélectionner les images en fonction de la base de données, apprentissage ou test

n = 1:261;
ok =1;
if strcmp(type,'Test')
    numImages  = n(find(mod(n,3)));
elseif strcmp(type,'Learn')
    numImages  = n(find(~mod(n,3)));
else
    ok = 0;
    uiwait(errordlg('Bad identifier (should be ''Learn'' or ''Test'' ','ERRORDLG'));
end

fid = figure('Name', 'SOURCE IMAGE');
if ok
    % Definir le facteur de redimensionnement
    resizeFactor =  0.25;
    BD = zeros(1,6);
    iterationBD = 1;
    % FOR TESTS
    iteration = 0;%don't change
    iterationmax = 1;%change
    % END FOR TESTS
    
    %Shuts down imfindcircles warnings
    warning('off','images:imfindcircles:warnForLargeRadiusRange');
    
    % Programme de reconnaissance des images
    for n = numImages
        %condition to make the loop iterate a certain number of times
        %(serves BD indexing)
        if (iteration >= iterationmax)
            break
        end
        iteration = iteration+1;
        
        %numImage modificator to start over at a defined image
        %comment if useless, put modificator = image you want to start
%         modificator = 3;
%         if strcmp(type,'Test')
%             if mod(modificator + n - 1,3) == 0
%                 n = modificator + n;
%             else
%                 n = modificator + n - 1;
%             end
%         elseif strcmp(type,'Learn')
%             n = modificator + n - 3;
%         end
                
        if (n>261)
            break;%prevent the pop of an error in the case where the modificator 
            %makes the loop iterate over a non existing index of image and
            %essentially makes us lose our BD results
        end
 
        nom = ['IM (' num2str(n) ')'];
        im = (imread(['./BD/'  nom '.JPG']));
        %imshow(im);
        title 'Image source'
%        -- RECONNAISSANCE DES SYMBOLES DANS L'IMAGE n
        close all;
        
        sprintf('---IMAGE %d ---',n)
        
        %apply some saturation in whites and filtering to image
        imProcessed = saturAndFilt(im,100);
        %figure,imshow(im);
        
        %1st round
        [centers1,radii1] = searchCircles(imProcessed);
        
        %2nd round
        [centers2,radii2] = searchCircles(im);
        
        %merge centers and radii
        [centers, radii] = mergeCenters(centers1,radii1,centers2,radii2);
        
        coords = centersToCoords(centers,radii);
        
        
        %viscircles(centers, radii,'EdgeColor','g');
        %viscircles(centers1, radii1,'EdgeColor','b');
        %viscircles(centers2, radii2,'EdgeColor','r');
    
        
        for i = (1:length(radii))
            
            %returns subImage with specified coords
            subIm = subImage(im,coords,i);
            sprintf('subImage %d - %d processing...',n,i)
            
            %adjust luminosity
            illuminant = illumgray(im);
            subImIllu = chromadapt(subIm,illuminant,'ColorSpace','linear-rgb');          
            %figure,imshow(subImIllu);
            
            %begin analysis chain
            C = extractNumbers(subImIllu);
            similarity = templateMatching(C);
            RESULTS = simToNum(similarity);
            %end of analysis

            if (RESULTS{1}~=0)
                %if RESULTS is not an empty cell
                %write a new BD matrix line
                BD(iterationBD,1) = n;%first col, image number
                BD(iterationBD,(2:5)) = coords(i,:);%sub-box coordinates
                BD(iterationBD,6) = RESULTS{1};%number of the line
                iterationBD = iterationBD + 1;%next time we'll write one row further on BD
            end
            %pause(3);
        end
        
%        -- STOCAGE DANS LA MATRICE BD de 6 colonnes
    end
    
    % Sauvegarde dans un fichier .mat des résulatts
    if strcmp(type,'Test')
        fileOut  = 'myTestResults.mat';
    elseif strcmp(type,'Learn')
        fileOut  = 'myLearnResults.mat';
    end
    save(fileOut,'BD');
    
end