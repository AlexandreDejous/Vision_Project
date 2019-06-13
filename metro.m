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
    resizeFactor =  0.25
    
    % Programme de reconnaissance des images
    for n = numImages
        nom = ['IM (' num2str(n) ')'];
        im = (imread(['./BD/'  nom '.JPG']));
%        figure(fid);
        imshow(im);
        title 'Image source'
%        -- RECONNAISSANCE DES SYMBOLES DANS L'IMAGE n
        close all;
        imProcessed = newAlgo(im,100);
        imshow(imProcessed);
        [centers1,radii1] = searchCircles(imProcessed);
        %2nd round
        [centers2,radii2] = searchCircles(im);
        %merge cenetrs and radii
        [centers, radii] = mergeCenters(centers1,radii1,centers2,radii2);
        coords = centersToCoords(centers,radii);
        %viscircles(centers, radii,'EdgeColor','r');
        
        %line COLOR array in hsv
        lineColorHsv = lineColorArray;
        
        for i = (1:length(radii))
            subIm = subImage(im,coords,i);
            %subImAdjusted = adjust_luminosity(subIm);
            illuminant = illumgray(im);
            subImIllu = chromadapt(subIm,illuminant,'ColorSpace','linear-rgb');
            imshow(subImIllu);
            C = exctractNumbers(subImIllu);
            %subImIllu = colorFilter(subImIllu,lineColorHsv);
            %montage({subIm,subImIllu});
            correlation = corrLines(subImIllu);
            pause(3);
        end
        

        
        
%        -- STOCAGE DANS LA MATRICE BD de 6 colonnes
    end
    
    % Sauvegarde dans un fichier .mat des résulatts
    fileOut  = 'myResuts.mat';
    save(fileOut,'BD');
    
end