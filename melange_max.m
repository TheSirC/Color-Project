function [ vecf ] = melange_max( vecI, vecF)
% melange_max Transforme la couleur actuelle en couleur primaire ou noir ou
% blanc
% vecI: vecteur codant la couleur à changer (provenant de l'image actuelle
% vecF: vecteur codant la couleur de fusion (provenant de l'interaction
% utilisateur)
% vecf: vecteur codant la couleur finale 

[i,j,k] = size(vecI);
parfor a = 1:i
    for b = 1:j
        for c = 1:k
            for couleur = 1:3
                if (vecI(a,b,c,couleur)+vecF(a,b,c,couleur) >= 255)
                    vecf(a,b,c,couleur) = 255;
                else
                    vecf(a,b,c,couleur) = 0;
                end
            end
        end
    end
end

end

