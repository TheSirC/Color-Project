function [ vecf ] = difference( vecI, vecF)
% difference Soustrait la couleur actuelle avec la couleur de fusion (ou
% son opposé en cas de résultat négatif) 
% vecI: vecteur codant la couleur à changer (provenant de l'image actuelle
% vecF: vecteur codant la couleur de fusion (provenant de l'interaction
% utilisateur)
% vecf: vecteur codant la couleur finale 

[i,j,k] = size(vecI);
parfor a = 1:i
    for b = 1:j
        for c = 1:k
            for couleur = 1:3
                vecf(a,b,c,couleur) = abs(vecI(a,b,c,couleur)-vecF(a,b,c,couleur));
            end
        end
    end
end

end

