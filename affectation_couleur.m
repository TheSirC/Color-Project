% Copyright (C) 2017 Claude-Alban
% 
% This program is free software; you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

% -*- texinfo -*- 
% @deftypefn {Function File} {@var{retval} =} affectation_couleur (@var{input1}, @var{input2})
##
% @seealso{}
% @end deftypefn

% Author: Claude-Alban <sirc@Python>
% Created: 2017-05-05

function [I] = affectation_couleur (I, vecC, vecP)
%% Permet d'affecter une couleur à une matrice image prédéfinie
% I la matrice image
% vecC le vecteur codant la couleur à coder
% vecP le vecteur de coordonnées correspondant au changement

I(vecP(1),vecP(2),1) = vecC(1);
I(vecP(1),vecP(2),3) = vecC(3);
I(vecP(1),vecP(2),2) = vecC(2);

end
