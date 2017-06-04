function [ vecf ] = produit( vecI, vecF)
% produit Remplace la couleur actuelle par le produit de la couleur pass�e en param�tre
% avec la couleur actuelle
% vecI: vecteur codant la couleur � changer (provenant de l'image actuelle
% vecF: vecteur codant la couleur de fusion (provenant de l'interaction
% utilisateur)
% vecf: vecteur codant la couleur finale

vecf = vecF; % Pour �viter des affectations non n�cesaires dans la boucle
[i,j,k] = size(vecI);
for a = 1:i
    for b = 1:j
        for c = 1:k
            if (vecF(a,b,c,1)+vecF(a,b,c,2)+vecF(a,b,c,3)==765) % Cas pour du blanc
                continue % Renvoie du blanc
            else
                vecf(a,b,c,1) = vecI(a,b,c,1)*vecF(a,b,c,1);
                vecf(a,b,c,2) = vecI(a,b,c,2)*vecF(a,b,c,2);
                vecf(a,b,c,3) = vecI(a,b,c,3)*vecF(a,b,c,3);
            end
        end
    end
end

end
