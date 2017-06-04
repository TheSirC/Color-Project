function [correlationRGB,centreCorr,ratio] = correl4(img,motif,RGB,Radius,Offset)
% pour des images 3D, par TF

if strcmp(RGB,'RGB')
    correlationR = normxcorr2(motif(:,:,1),img(:,:,1));
    correlationG = normxcorr2(motif(:,:,2),img(:,:,2));
    correlationB = normxcorr2(motif(:,:,3),img(:,:,3));
    
    correlationRGB = ((correlationR).*(correlationG).*(correlationB));
%     correlationRGB = cat(3,correlationR,correlationG, correlationB);

    ratio = [size(correlationRGB,1)/size(img,1) size(correlationRGB,2)/size(img,2)];
    
    centreCorr = subpx2(correlationRGB);
    centreCorr = floor(abs(centreCorr - [Radius, Radius] + [Offset(1), Offset(2)]));
    return

elseif strcmp(RGB,'RG')
    correlationR = normxcorr2(motif(:,:,1),img(:,:,1));
    correlationG = normxcorr2(motif(:,:,2),img(:,:,2));
    
    correlationRGB = ((correlationR).*(correlationG));
%     correlationRGB = cat(3,correlationR,correlationG, correlationB);
    
    ratio = [size(correlationRGB,1)/size(img,1) size(correlationRGB,2)/size(img,2)];

    centreCorr = subpx2(correlationRGB);
    centreCorr = floor(abs(centreCorr - [Radius, Radius] + [Offset(1), Offset(2)]));
    return
    
elseif strcmp(RGB,'GB')
    correlationG = normxcorr2(motif(:,:,2),img(:,:,2));
    correlationB = normxcorr2(motif(:,:,3),img(:,:,3));
    
    correlationRGB = ((correlationG).*(correlationB));
%     correlationRGB = cat(3,correlationR,correlationG, correlationB);

    ratio = [size(correlationRGB,1)/size(img,1) size(correlationRGB,2)/size(img,2)];
    
    centreCorr = subpx2(correlationRGB);
%     centreCorr = [centreCorr(1)*ratio(1) centreCorr(2)*ratio(2)];
%     centreCorr = [centreCorr(1)*ratio(2) centreCorr(2)*ratio(1)];
%     centreCorr = floor(abs(centreCorr - [Radius, Radius] + [Offset(1), Offset(2)]));
    
    centreCorr = abs(centreCorr - [Radius, Radius] + [Offset(1), Offset(2)]);
    return
    
elseif strcmp(RGB,'RB')
    correlationR = normxcorr2(motif(:,:,1),img(:,:,1));
    correlationB = normxcorr2(motif(:,:,3),img(:,:,3));
    
    correlationRGB = ((correlationR).*(correlationB));
%     correlationRGB = cat(3,correlationR,correlationG, correlationB);
    
    ratio = [size(correlationRGB,1)/size(img,1) size(correlationRGB,2)/size(img,2)];

    centreCorr = subpx2(correlationRGB);
    centreCorr = floor(abs(centreCorr - [Radius, Radius] + [Offset(1), Offset(2)]));
    return
    
elseif strcmp(RGB,'R')
    correlationRGB = normxcorr2(motif(:,:,1),img(:,:,1));
    
    ratio = [size(correlationRGB,1)/size(img,1) size(correlationRGB,2)/size(img,2)];
    
    [centreCorr] = abs(floor(subpx2(correlationRGB)));
    centreCorr = floor(abs(centreCorr - [Radius, Radius] + [Offset(1), Offset(2)]));
    return
    
elseif strcmp(RGB,'G')
    correlationRGB = normxcorr2(motif(:,:,2),img(:,:,2));
    
    ratio = [size(correlationRGB,1)/size(img,1) size(correlationRGB,2)/size(img,2)];
    
    [centreCorr] = abs(floor(subpx2(correlationRGB)));
    centreCorr = floor(abs(centreCorr - [Radius, Radius] + [Offset(1), Offset(2)]));
    return
    
elseif strcmp(RGB,'B')
    correlationRGB = normxcorr2(motif(:,:,3),img(:,:,3));
    
    ratio = [size(correlationRGB,1)/size(img,1) size(correlationRGB,2)/size(img,2)];
    
    [centreCorr] = abs(floor(subpx2(correlationRGB)));
    centreCorr = floor(abs(centreCorr - [Radius, Radius] + [Offset(1), Offset(2)]));
    return

end