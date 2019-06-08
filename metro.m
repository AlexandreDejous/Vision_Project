%% Programme principal de reconnaissance et de sauvegarde des r�sultats
% -------------------------------------------------------------------------
% Input :
%           type = 'Test' ou 'Learn' pour d�finir les images trait�es
% Outputs
%           fileOut  :      nom (string) du fichier .mat des r�sultats de
%                           reconnaissance
%           resizeFactor :  facteur de redimensionnement qui a �t� appliqu�
%                           aux images
% 
%--------------------------------------------------------------------------
function [fileOut,resizeFactor] = metro(type)


% S�lectionner les images en fonction de la base de donn�es, apprentissage ou test

%close all;
%clear all;
%clc;
se = strel('square',10);

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
        im = im2double(imread(['./BD/'  nom '.JPG']));
        figure(n);
        %imshow(im);
        title 'Image source'
%        -- RECONNAISSANCE DES SYMBOLES DANS L'IMAGE n
        [sizex, sizey, sizez] = size(im);
        im = rgb2gray(im);

        im = imdilate(im,se);
        imshow(im);
        [centers, radii,metric] = imfindcircles(im,[15 70],'ObjectPolarity','dark', ...
        'Sensitivity',0.92,'EdgeThreshold',0.1);
        viscircles(centers, radii,'EdgeColor','b');
        
%        -- STOCAGE DANS LA MATRICE BD de 6 colonnes
    end
    
    % Sauvegarde dans un fichier .mat des r�sulatts
    fileOut  = 'myResuts.mat';
    save(fileOut,'BD');
    
end