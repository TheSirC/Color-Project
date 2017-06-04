function [barycentre] = subpx2(image)


[~,Indice] = max(image(:)); % On cherche le maximum de l'image
[I_row, I_col] = ind2sub(size(image),Indice);

[H,L] = size(image);
image3 = zeros(7,7);
% On cr�e une image de voisinage 7x7 du maximum

i=1; % indices de lignes de l'image du voisinage 7x7
j=1; % indices de colonnes de l'image du voisinage 7x7
while((i<7) && (j<7)) 
    for k=(I_row-3):1:(I_row+3)
        for l=(I_col-3):1:(I_col+3)
            if (((k <= 0) || (k >= H)) || ((l <= 0) || (l >= L)))
                image3(i,j)=0; % On d�passe l'indice max, on prend 0.
            else
                image3(i,j)=image(k,l); % On peut copier le bon indice.
            end;
            if (j==7)
                j=1; % si on d�passe la taille, remise � z�ro.
            else
                j=j+1; % on incr�mente
            end;
        end;
        i=i+1; % On remet l'indice de lignes � z�ro.
    end;
end;
[H,L] = size(image3); % la nouvelle taille de r�f�rence

barycentre=[0,0]; % xg et yg : coordonn�es du barycentre
for k=1:1:H
    for l=1:1:L
        barycentre(1) = barycentre(1) + k*image3(k,l); % xg
        barycentre(2) = barycentre(2) + l*image3(k,l); % yg
    end;
end;
barycentre(1) = barycentre(1) / sum(image3(:)); % moyenne sur x
barycentre(2) = barycentre(2) / sum(image3(:)); % moyenne sur y

% On renvoie les valeurs du maximum cod�es sur la grille de l'image
% originale: On ajoute l'indice de ligne ou colonne, + 3, + 1 pour centrer.
barycentre(1)= -4 + I_row + barycentre(1);
barycentre(2)= -4 + I_col + barycentre(2);

end