function [motif,motif_mini] = savecalibrage(Center,Radius,img)

xC = floor(Center(1));
yC = floor(Center(2));
R = floor(Radius);

xTop = (xC - R);
yTop = (yC - R);
xBottom = (xC + R);
yBottom = (yC + R);

[L,H,~] = size(img);
imgcenter = [floor(L/2+1), floor(H/2+1)];

motif = zeros(size(img));
% motif(yTop:yBottom,xTop:xBottom,:) = img(yTop:yBottom,xTop:xBottom,:);
% motif(imgcenter(1,2)-R:imgcenter(1,2)+R,imgcenter(1,1)-R:imgcenter(1,1)+R,:) = img(yTop:yBottom,xTop:xBottom,:);
motif(imgcenter(1,1)-R:imgcenter(1,1)+R,imgcenter(1,2)-R:imgcenter(1,2)+R,:) = img(yTop:yBottom,xTop:xBottom,:);

motif_mini = img(yTop:yBottom,xTop:xBottom,:);


end