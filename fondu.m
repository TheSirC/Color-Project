function [ vecF ] = fondu( vecI )
% fondu Remplace la couleur actuelle par la couleur passée en paramètre de
% manière aléatoire
% vecI: vecteur codant la couleur à changer
% vecF: vecteur codant la couleur de fusion

[i,j,k] = size(vecI);
parfor a = 1:i
    for b = 1:j
        for c = 1:k
            if (rand() > 0.5)
            vecF(a,b,c) = vecI(a,b,c);
            end
        end
    end
end

end

