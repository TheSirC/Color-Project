function [ vecF ] = fondu( vecI )
% fondu Remplace la couleur actuelle par la couleur pass�e en param�tre de
% mani�re al�atoire
% vecI: vecteur codant la couleur � changer
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
