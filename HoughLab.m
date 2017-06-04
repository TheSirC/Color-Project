function [centersW,radiiW,centersD,radiiD] = HoughLab(img,diamRange,sizeimg)

[Ld,Hd] = size(diamRange);
Lab = rgb2lab(img); % converts RGB image into Lab

for i=1:1:3
    for j=1:1:Ld
        [centersW, radiiW, ~] = imfindcircles(Lab(:,:,i),[diamRange(j,1) diamRange(j,2)],'ObjectPolarity','bright','Sensitivity',0.85);
        [centersD, radiiD, ~] = imfindcircles(Lab(:,:,i),[diamRange(j,1) diamRange(j,2)],'ObjectPolarity','dark','Sensitivity',0.85);
    end
end

end