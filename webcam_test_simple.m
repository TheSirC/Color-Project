clc; clear all; close all;

warning('off')

% Game Setup :
global nComportement; % A changer via le menu déroulant
nComportement = 0; % Initialisation sur le mode par défaut
position = 0.3;
indexResolution = 5; % 1-5
numberofplayers = 2; % 1-4
colorsP = ([1,0,0;0,0,1;1,1,0;1,1,1]); % Rouge, Bleu, Jaune, Blanc
% colorsP = ([1,1,1;1,0,0;0,0,1;1,1,0]); % Blanc, Bleu, Rouge, Jaune
available = {'RGB','RG','GB','RB','R','G','B'};
% colorsCorrel = {'B','B','B','B'}; % GB semble le mieux
colorsCorrel = {available{3},available{3},available{3},available{3}};
colorsCanvas = ([255,0,0;0,0,255;255,215,0;255,255,255]); % Rouge, Bleu, Jaune, Blanc
% Webcam Setup :
camList = webcamlist
cam = webcam(1) % Connect to the webcam
Resolutions = cam.AvailableResolutions
sizeR = numel(Resolutions);
for i = 1:1:sizeR
    vecteurResolutions(i,:) = strsplit(cell2mat(cellstr(Resolutions{1,i})),'x'); 
end
resolutionsDispo = zeros(size(vecteurResolutions,2)/2,2);
ratioResolutions = str2double(vecteurResolutions);

for i = 1:1:(size(ratioResolutions,2)/2)
    resolutionsDispo(i,1) = ratioResolutions(i);
    resolutionsDispo(i,2) = ratioResolutions(i+1);
end
%%
cam.Resolution = Resolutions{1}
% cam.Resolution = Resolutions{indexResolution}
% cam.ExposureMode = 'manual';

% ratio(1,1) = ratioResolutions(1,1) / ratioResolutions(indexResolution,1);
% ratio(1,2) = ratioResolutions(1,2) / ratioResolutions(indexResolution,2);
ratio(1,1) = 8;
% preview(cam);
ratio2(1,1) = 2;

% Initialisation :
% fmin = 0;
init = 0;
init2 = 0;
out = 0; % initialisation principale
out2 = 0; % initialisation de la video
out3 = 0; % initialisation par imagettes
timer = 0;

%%

while (init == 0) % phase d'initialisation !
    video = snapshot(cam);
%     f = double(video)/255; % necessaire pour la correlation
    f = im2double(video,'indexed')/255;
    f = fliplr(f);
    figure(1);
    while (init2 == 0) % parametres principaux
        [L,H,~] = size(f);
        H2 = (H/10)*2;
        L2 = (L/10)*2;
        radius = H/12; % 12
        radiusVisu = floor(radius);
        radiusCircles = floor(radiusVisu/2);
        for i = 1:1:numberofplayers
            SE = strel('disk',radiusCircles,8);
            SE = SE.Neighborhood;
            SE0 = (SE == 0);
            CR = 255*colorsP(i,1).*SE;
%             CR = CR + 255*SE0;
            CG = 255*colorsP(i,2).*SE;
%             CG = CG + 255*SE0;
            CB = 255*colorsP(i,3).*SE;
%             CB = CB + 255*SE0;
            C{i} = cat(3,CR,CG,CB);
        end
        sizecanvas = floor([(size(f,1)/ratio2(1,1))+radiusCircles (size(f,2)/ratio2(1,1))+radiusCircles size(f,3)]);
        canvas = 255*ones(sizecanvas);
        init2 = 1;
    end
    imshow(f, []); title('image Webcam');
    [playerscirclesC,playerscirclesR] = calibrage(numberofplayers,[L H],position,radius);
    for i=1:1:numberofplayers
        players(i) = viscircles(playerscirclesC(i,:), playerscirclesR(i));
        players(i).Children(1).Color = colorsP(i,:); % applique la couleur a chacun
        % hold on
    end
    hold off
    drawnow
    timer = timer + 1
    if (timer == 50)
        % sprintf('timer off')
        init = 1; % initialisation !
        g = imresize(f,1/ratio(1,1));
        g = rgb2lab(g);
        for i = 1:1:numberofplayers
            [~,fmini{i}] = savecalibrage(playerscirclesC(i,:)/ratio(1,1),playerscirclesR(i)/ratio(1,1),g);
%             playerscirclesC(i,:) = playerscirclesC(i,:) - playerscirclesR(i);
%             playerscirclesC(i,:) = - playerscirclesR(i);

        end
%         sprintf('saved')
        % pause(2); % attente de 2 secondes
    end
end

% k = 0;
% k = 3;
% sprintf('I made it out')

while (out == 0) % (1)
%     sprintf('I looped')
    video = snapshot(cam);
%     f = double(video)/255;
    f = im2double(video,'indexed')/255;
    f = fliplr(f);
    g = imresize(f,1/ratio(1,1));
    g = rgb2lab(g);
    if (out2 == 0)
        figure(2);
%         sprintf('drawing patterns')
        if (numberofplayers == 1)
            imshow(fmini{1}, []); title('vignette');
        else
            for i = 1:1:numberofplayers
                titre1{i} = sprintf('vignette : %g',i);
                titre2{i} = sprintf('correlation : %g',i);
                subplot(2,2,i); imshow(fmini{i}, []); title(titre1{i});
            end
        end
        out2 = 1;
        hold off
    end
    % sprintf('here')
    for j = 1:1:numberofplayers % parfor
%         sprintf('starting correlation')
        tic
%         [imcorrel{i},centrecorrel(i,:)] = correl2(g,fmini{i},'oui','R');
%         [imcorrel{i},centrecorrel(i,:)] = correl3(f,fmin{i},'R'); 
        [imcorrel{j}, centrecorrel(j,:),ratio3] = correl4(g,fmini{j},colorsCorrel{j},playerscirclesR(j)/ratio(1,1),[0, 0]);
        tempscorrel = toc
%         [imcropped{i}] = imgcrop(fmini{i}, centrecorrel(i,:));
%         centrecorrel(i,:)
        tic
%         [canvas] = drawOnCanvas(canvas,(centrecorrel(j,:)*(ratio(1,1)/ratio2(1,1))),C{j});
        [canvas] = drawOnCanvas(canvas,[(centrecorrel(j,1)*(ratio(1,1)/(ratio2(1,1)*ratio3(1,1)))) (centrecorrel(j,2)*(ratio(1,1)/(ratio2(1,1)*ratio3(1,1))))],C{j});
%         [canvas] = updateCanvasPlusSize(canvas,(centrecorrel(i,:)*(ratio(1,1)/ratio2(1,1))),colorsP(i,:),radiusVisu,'C');
        tempsdessin = toc
    end
%     centrecorrel = mod(centrecorrel + playerscirclesC(1:numberofplayers,:),[H L]);
%     sprintf('done')
    figure(3);
%     sprintf('drawing something')
    if (numberofplayers == 1)
        subplot(2,1,1); imshow(f, []); title('correlation : 1'); % imcorrel{i}
        % correl1(1) = viscircles(centrecorrel(1,:), floor(H/15),'LineStyle','--');
        % correl1(i) = viscircles([centrecorrel(i,1), centrecorrel(i,2)], floor(H/15),'LineStyle','--');
        correl1(i) = viscircles([centrecorrel(i,2)*ratio(1,1), centrecorrel(i,1)*ratio(1,1)], radiusVisu,'LineStyle','--');
        correl1(1).Children(1).Color = colorsP(1,:); % apply the color
%         pause(0.01);
        subplot(2,1,2); imshow(canvas, []); title('dessin');
        drawnow
    else
        for i = 1:1:numberofplayers
            subplot(2,2,i); imshow(f, []); title(titre2{i}); % imcorrel{i}
            % correl1(i) = viscircles([centrecorrel(i,1), centrecorrel(i,2)], floor(H/15),'LineStyle','--');
            correl1(i) = viscircles([centrecorrel(i,2)*ratio(1,1), centrecorrel(i,1)*ratio(1,1)], radiusVisu,'LineStyle','--');
            correl1(i).Children(1).Color = colorsP(i,:); % apply the color
%             subplot(2,2,i+2); imshow(imcorrel{i}, []); title(titre3{i});
            subplot(2,2,[3 4]); imshow(canvas, []); title('dessin');
%             pause(0.01);
            drawnow
        end
    end
end
% sprintf('there')
out = 1;

clear('cam');
whos video


%% ETUDE DES MAXIMUMS DE CORRELATION :

figure(4), imshow(fmin{2}, []);
imcorrel2 = imcorrel{2};
imcorrel2R = imcorrel2(:,:,1);
% imcorrel2G = imcorrel2(:,:,2);
% imcorrel2B = imcorrel2(:,:,3);
figure(5), subplot(2,1,1); imshow(imcorrel2, []); title('RGB');
subplot(2,1,2); imshow(imcorrel2R, []); title('R');
% subplot(2,2,3); imshow(imcorrel2G, []); title('G');
% subplot(2,2,4); imshow(imcorrel2B, []); title('B');

[barycentreR] = subpx2(imcorrel2);
[barycentreRGB] = subpx2(imcorrel2R);
barycentreR = abs(barycentreR);
barycentreRGB = real(barycentreRGB);

[~,Indice(1)] = max(imcorrel2(:));
[I_row(1), I_col(1)] = ind2sub(size(imcorrel2(:,:,i)),Indice(1));
[~,Indice(2)] = max(imcorrel2R(:));
[I_row(2), I_col(2)] = ind2sub(size(imcorrel2(:,:,i)),Indice(2));
% [~,Indice(3)] = max(imcorrel2G(:));
% [I_row(3), I_col(3)] = ind2sub(size(imcorrel2(:,:,i)),Indice(3));
% [~,Indice(4)] = max(imcorrel2B(:));
% [I_row(4), I_col(4)] = ind2sub(size(imcorrel2(:,:,i)),Indice(4));

%% ETUDE DES CORRELATIONS :

% f2 = fmin{1};
% X = corr2(f(:,:,1),f2(:,:,1));
% figure(6); imshow(X, []);

for i=1:1:numberofplayers
    
    img1 = g;
    img2 = fmin{i};
    
    
%     IMG1 = fft2(img1);
    % img2 = fftshift(img2);
%     IMG2 = fft2(img2);
    
    % Correl1 = ifftshift(fft2(IMG2.*conj(IMG1))); % original
    % Correl2 = ifft2(IMG2.*conj(IMG1));
    % Correl3 = fft2(fftshift(IMG1.*conj(IMG2)));
    % Correl4 = fft2(fftshift(IMG2.*conj(IMG1)));
    % Correl5 = ifftshift(ifft2(IMG2.*conj(IMG1)));
    % Correl6 = ifftshift(ifft2(IMG1.*conj(IMG2)));
    
    [Correl1, ~] = correl4(img1,img2,available{1},playerscirclesR(1)/ratio(1,1),[0, 0]);
    [Correl2, ~] = correl4(img1,img2,available{3},playerscirclesR(1)/ratio(1,1),[0, 0]);
    [Correl3, ~] = correl4(img1,img2,available{4},playerscirclesR(1)/ratio(1,1),[0, 0]);
    [Correl4, ~] = correl4(img1,img2,available{5},playerscirclesR(1)/ratio(1,1),[0, 0]);
    [Correl5, ~] = correl4(img1,img2,available{6},playerscirclesR(1)/ratio(1,1),[0, 0]);
    [Correl6, ~] = correl4(img1,img2,available{7},playerscirclesR(1)/ratio(1,1),[0, 0]);
    
    
    
    [~,Indice(1)] = max(Correl1(:));
    [I_row(1), I_col(1)] = ind2sub(size(Correl1(:,:,1)),Indice(1));
    
    [~,Indice(2)] = max(Correl2(:));
    [I_row(2), I_col(2)] = ind2sub(size(Correl2(:,:,1)),Indice(2));
    
    [~,Indice(3)] = max(Correl3(:));
    [I_row(3), I_col(3)] = ind2sub(size(Correl3(:,:,1)),Indice(3));
    
    [~,Indice(4)] = max(Correl4(:));
    [I_row(4), I_col(4)] = ind2sub(size(Correl4(:,:,1)),Indice(4));
    
    [~,Indice(5)] = max(Correl5(:));
    [I_row(5), I_col(5)] = ind2sub(size(Correl5(:,:,1)),Indice(5));
    
    [~,Indice(6)] = max(Correl6(:));
    [I_row(6), I_col(6)] = ind2sub(size(Correl6(:,:,1)),Indice(6));
    
    draw = viscircles([I_row(1), I_col(1)], floor(H/15),'LineStyle','--');
    draw.Children(1).Color = colorsP(1,:); % apply the color
    
    figure(6+i);
    subplot(4,2,1); imshow(img1, []); title('img1');
    subplot(4,2,2); imshow(img2, []); title('img2');
    
    subplot(4,2,3); imshow(abs(Correl1), []); title(sprintf('%s,x=%g,y=%g',available{1},I_col(1), I_row(1)));
    draw = viscircles([I_col(1), I_row(1)], floor(H/30),'LineStyle','--');
    draw.Children(1).Color = colorsP(1,:); % apply the color
    
    subplot(4,2,4); imshow(abs(Correl2), []); title(sprintf('%s,x=%g,y=%g',available{3},I_col(2), I_row(2)));
    draw = viscircles([I_col(2), I_row(2)], floor(H/30),'LineStyle','--');
    draw.Children(1).Color = colorsP(1,:); % apply the color
    
    subplot(4,2,5); imshow(abs(Correl3), []); title(sprintf('%s,x=%g,y=%g',available{4},I_col(3), I_row(3)));
    draw = viscircles([I_col(3), I_row(3)], floor(H/30),'LineStyle','--');
    draw.Children(1).Color = colorsP(1,:); % apply the color
    
    subplot(4,2,6); imshow(abs(Correl4), []); title(sprintf('%s,x=%g,y=%g',available{5},I_col(4), I_row(4)));
    draw = viscircles([I_col(4), I_row(4)], floor(H/30),'LineStyle','--');
    draw.Children(1).Color = colorsP(1,:); % apply the color
    
    subplot(4,2,7); imshow(abs(Correl5), []); title(sprintf('%s,x=%g,y=%g',available{6},I_col(5), I_row(5)));
    draw = viscircles([I_col(5), I_row(5)], floor(H/30),'LineStyle','--');
    draw.Children(1).Color = colorsP(1,:); % apply the color
    
    subplot(4,2,8); imshow(abs(Correl6), []); title(sprintf('%s,x=%g,y=%g',available{7},I_col(6), I_row(6)));
    draw = viscircles([I_col(6), I_row(6)], floor(H/30),'LineStyle','--');
    draw.Children(1).Color = colorsP(1,:); % apply the color
end

%%

SE = strel('disk',16,0)
SE = SE.Neighborhood
figure(1),
subplot(2,2,1), imshow(SE, []); title('disk, 0');

SE = strel('disk',16,4)
SE = SE.Neighborhood
subplot(2,2,2), imshow(SE, []); title('disk, 4');

SE = strel('disk',16,6)
SE = SE.Neighborhood
subplot(2,2,3), imshow(SE, []); title('disk, 6');

SE = strel('disk',16,8)
SE = SE.Neighborhood
subplot(2,2,4), imshow(SE, []); title('disk, 8');

%%

[canvas] = drawOnCanvas(canvas,([21 21]),C{1});
figure(5),
imshow(canvas, [])
