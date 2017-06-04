function [playerscirclesC,playerscirclesR] = calibrage(numberofplayers,videosize,position,radius)

L = videosize(1);
H = videosize(2);
Hposition = round(position*L); % dessine à 80% de la Hauteur
% Pposition = ([H-floor(H/8),Hposition;H-3*floor(H/8),Hposition;H-5*floor(H/8),Hposition;H-7*floor(H/8),Hposition]);
% 
% playerscirclesR = ([floor(H/10),floor(H/10),floor(H/10),floor(H/10)]);
% playerscirclesR = playerscirclesR(1:numberofplayers);
% playerscirclesC = Pposition;

Pposition = ([H-floor(H/8),Hposition;H-3*floor(H/8),Hposition;H-5*floor(H/8),Hposition;H-7*floor(H/8),Hposition]);

playerscirclesR = ([floor(radius),floor(radius),floor(radius),floor(radius)]);
playerscirclesR = playerscirclesR(1:numberofplayers);
playerscirclesC = Pposition;
end