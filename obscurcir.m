function [ vecf ] = obscurcir( vecI, vecF)
% obscurcir Remplace la couleur actuelle par la couleur pass�e en param�tre
% si ses informations chromatiques sont plus faibles
% vecI: vecteur codant la couleur � changer
% vecF: vecteur codant la couleur de fusion
% vecF: vecteur codant la couleur finale

n = size(vecI);

[i,j,k] = size(vecI);
parfor a = 1:i
    for b = 1:j
        for c = 1:k
            if (vecF(a,b,c) > vecI)
            vecF(a,b,c) = vecI;
            else
            end
        end
    end
end

end

