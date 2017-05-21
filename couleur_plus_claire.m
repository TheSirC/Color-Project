function [ vecf ] = couleur_plus_claire( vecI, vecF)
% couleur_plus_claire Remplace la couleur actuelle par la couleur passée en paramètre
% si la somme de ses informations chromatiques est plus élevée
% vecI: vecteur codant la couleur à changer (provenant de l'image actuelle
% vecF: vecteur codant la couleur de fusion (provenant de l'interaction
% utilisateur)
% vecf: vecteur codant la couleur finale 

vecf = vecF; % Pour éviter des affectations non nécesaires dans la boucle

[i,j,k] = size(vecI);
parfor a = 1:i
    for b = 1:j
        for c = 1:k
            if (vecF(a,b,c,1)+vecF(a,b,c,2)+vecF(a,b,c,3) < vecI(a,b,c,1)+vecI(a,b,c,2)+vecI(a,b,c,3))
                vecf(a,b,c) = vecI(a,b,c);
            end
        end
    end
end

end

