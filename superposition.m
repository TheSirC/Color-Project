function [ vecf ] = superposition( vecI, vecF)
% superposition Remplace la couleur actuelle par le produit de l'inverse de la couleur passée en paramètre
% avec l'inverse de la couleur actuelle
% vecI: vecteur codant la couleur à changer (provenant de l'image actuelle
% vecF: vecteur codant la couleur de fusion (provenant de l'interaction
% utilisateur)
% vecf: vecteur codant la couleur finale 

vecf = vecF; % Pour éviter des affectations non nécesaires dans la boucle
[i,j,k] = size(vecI);
parfor a = 1:i
    for b = 1:j
        for c = 1:k
            if (vecI(a,b,c,1)+vecI(a,b,c,2)+vecI(a,b,c,3) == 0) % Cas pour du noir
                vecf = vecI; % Renvoie du noir 
            elseif (vecF(a,b,c,1)+vecF(a,b,c,2)+vecF(a,b,c,3)==765) % Cas pour du blanc
                continue % Renvoie du blanc
            else
                vecf(a,b,c,1) = (1/vecI(a,b,c,1))*(1/vecF(a,b,c,1));
                vecf(a,b,c,2) = (1/vecI(a,b,c,2))*(1/vecF(a,b,c,2));
                vecf(a,b,c,3) = (1/vecI(a,b,c,3))*(1/vecF(a,b,c,3));
            end
        end
    end
end

end

